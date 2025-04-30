unless released?
  original_dir = Dir.getwd
  Dir.chdir(File.expand_path(File.dirname(ARGV.shift)))
  $:.unshift Dir.getwd
end

require "templates/game_template"

require "lib/overrides"

require "app/commands/export"
require "app/commands/new"
require "app/commands/run"
require "app/commands/squash"
require "app/commands/version"

unless released?
  $:.shift
  Dir.chdir(original_dir)
end

$:.unshift Dir.getwd

options = if File.exist?("./taylor-config.json")
  JSON.parse(File.read("./taylor-config.json"))
else
  {}
end

command = ARGV[0]

case command
when "new"
  Taylor::Commands::New.call(ARGV[1..], options)

when "export"
  Taylor::Commands::Export.call(ARGV[1..], options)

when "squash"
  Taylor::Commands::Squash.call(ARGV[1..], options)

when "--version"
  Taylor::Commands::Version.call

else
  Taylor::Commands::Run.call(command, ARGV, options)
end
