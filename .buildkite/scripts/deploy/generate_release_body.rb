#!/usr/bin/env ruby

tag = ENV['BUILDKITE_BRANCH']

changelog = File.read('CHANGELOG.md')

found_relevant_section = false

changelog.each_line do |line|
  exit if line.start_with?('##') && found_relevant_section
  found_relevant_section = true if line =~ /^## #{tag}$/

  puts line if found_relevant_section
end
