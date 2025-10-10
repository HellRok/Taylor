#!/usr/bin/env ruby

require "webrick"
require "selenium-webdriver"
require "net/http"
require "net/https"

root = File.expand_path "."
server = WEBrick::HTTPServer.new(
  Port: 9999,
  DocumentRoot: root,
  Logger: WEBrick::Log.new(File::NULL),
  AccessLog: []
)

Thread.start { server.start }

options = Selenium::WebDriver::Firefox::Options.new(args: ["-headless"])

driver = Selenium::WebDriver.for(:firefox, options: options)

driver.get("http://localhost:9999")

def persist_analytics(analytics)
  File.write("test-analytics.json", analytics)
end

start_time = Time.now
taylor_logs = ""

until taylor_logs.include?("EXIT CODE:")
  sleep 0.5

  taylor_logs = driver.find_element(:css, "#logs").text

  # Give the tests 10 seconds to run (which should be ample)
  if Time.now - start_time > 30
    puts "TIMED OUT AFTER 30 SECONDS"
    puts "Taylor Logs"
    puts "-----------"
    puts taylor_logs
    exit 1
  end
end

driver.quit

taylor_logs.each_line { |log|
  if log.include?("ANALYTICS:")
    persist_analytics(JSON.parse(log.split(":", 2).last))

  elsif log.include?("EXIT CODE:")
    exit log.split("EXIT CODE: ").last.to_i

  else
    puts log
  end
}
