#!/usr/bin/env ruby

require 'webrick'
require 'selenium-webdriver'
require 'webdrivers/chromedriver'
require 'net/http'
require 'net/https'

root = File.expand_path '.'
server = WEBrick::HTTPServer.new :Port => 3001, :DocumentRoot => root
server.config[:Logger].level = 0

server_thread = Thread.start { server.start }

options = Selenium::WebDriver::Options.chrome(
  args: [
    'no-sandbox',
    'disable-dev-shm-usage',
    'window-size=1280,800',
  ]
)
driver = Selenium::WebDriver.for(:chrome, options: options)

driver.get('http://localhost:3001')

def upload_analytics(analytics)
  return unless ENV['BUILDKITE_TEST_ANALYTICS_KEY']
  puts
  puts "Found a Buildkite test analytics key, let's upload our results!"
  puts "..."

  uri = URI.parse("https://analytics-api.buildkite.com/v1/uploads")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  headers = {
    'Authorization' => "Token token=\"#{ENV['BUILDKITE_TEST_ANALYTICS_KEY']}\"",
    'Content-Type' => 'application/json',
  }

  body = {
    format: "json",
    run_env: {
      "CI" => "buildkite",
      "key" => ENV['BUILDKITE_BUILD_ID'],
      "number" => ENV['BUILDKITE_BUILD_NUMBER'],
      "job_id" => ENV['BUILDKITE_JOB_ID'],
      "branch" => ENV['BUILDKITE_BRANCH'],
      "commit_sha" => ENV['BUILDKITE_COMMIT'],
      "message" => ENV['BUILDKITE_MESSAGE'],
      "url" => ENV['BUILDKITE_BUILD_URL']
    },
    data: analytics
  }.to_json

  request = Net::HTTP::Post.new(uri.request_uri, headers)
  request.body = body

  response = http.request(request)

  response_data = JSON.parse(response.body)
  puts "ID: #{response_data['id']}"
  puts "Run ID: #{response_data['run_id']}"
  puts "Queued: #{response_data['queued']}"

  puts "Done!"
end

start_time = Time.now
analytics = nil
loop do
  sleep 0.1

  taylor_logs = driver.find_element(:css, '#logs').text

  taylor_logs.each_line { |log|
    if log.include?("ANALYTICS:")
      analytics = JSON.parse(log.split(":", 2).last)
    else
      puts log.chomp
    end

    if log.include?("EXIT CODE:")
      _, code = log.split("EXIT CODE: ")
      upload_analytics(analytics)
      exit code.to_i
    end
  }

  browser_logs = driver.logs.get :browser

  browser_logs.each { |log|
    if log.message.include?("program exited (with status: 1)")
      puts log.message
      sleep 10
      exit 1
    end
  }

  # Give the tests 1 minute to run (which should be ample)
  if Time.now - start_time > 60
    puts "TIMED OUT AFTER 1 MINUTE"
    puts "Browser Logs"
    puts "-----------"
    browser_logs.each { puts _1.message }
    puts "Taylor Logs"
    puts "-----------"
    puts taylor_logs
    exit 1
  end
end
