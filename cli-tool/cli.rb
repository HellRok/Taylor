require './templates/game_template'

require './app/commands/export'
require './app/commands/new'
require './app/commands/run'

$:.unshift WORKING_DIRECTORY
Dir.chdir WORKING_DIRECTORY

if File.exists?('./taylor-config.json')
  options = JSON.parse(File.read('./taylor-config.json'))
else
  options = {}
end

command = ARGV[0]

case command
when 'new'
  Taylor::Commands::New.call(ARGV[1..], options)

when 'export'
  Taylor::Commands::Export.call(ARGV[1..], options)

else
  Taylor::Commands::Run.call(command, ARGV, options)
end
