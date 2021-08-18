require './templates/game_template'

require './app/commands/export'
require './app/commands/new'
require './app/commands/run'

if File.exists?('./taylor-config.json')
  options = JSON.parse(File.read('./taylor-config.json'))
else
  options = {}
end

parser = OptParser.new do |opts|
  opts.on(:help, :bool, false)

  # New
  opts.on(:name,             :string, options.fetch(:name,             'taylor_game'))
  opts.on(:input,            :string, options.fetch(:input,            'game.rb'))
  opts.on(:export_directory, :string, options.fetch(:export_directory, './exports'))
  opts.on(:load_paths,       :string, options.fetch(:load_paths,       './,./vendor'))
  opts.on(:copy_paths,       :string, options.fetch(:copy_paths,       './assets'))

  # Export
  opts.on(:dry_run, :bool, false)
end

parser.parse(ARGV, true)

command = parser.tail.shift

case command
when 'new'
  Taylor::Command::New.call(parser)

when 'export'
  Taylor::Command::Export.call(parser)

else
  Taylor::Command::Run.call(command, parser)
end
