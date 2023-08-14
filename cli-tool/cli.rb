require "./templates/game_template"

require "./lib/overrides"

require "./app/commands/export"
require "./app/commands/new"
require "./app/commands/run"
require "./app/commands/version"

$:.unshift WORKING_DIRECTORY
Dir.chdir WORKING_DIRECTORY

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

when "--version"
  Taylor::Commands::Version.call

else
  Taylor::Commands::Run.call(command, ARGV, options)
end
