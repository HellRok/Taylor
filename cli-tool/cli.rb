# We use this to check if we've been released or not, it's a bit of a hack but
# it work since `released?` is forced to false below.
unless __FILE__ == "/app/taylor/output.rb"
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

if __FILE__ == "/app/taylor/output.rb"
  # Ditch the `taylor` executable argument
  ARGV.shift
else
  $:.shift
  Dir.chdir(original_dir)
end

config = Taylor::Config::Finder.call(ARGV.first)
$:.unshift config.game_dir

command = ARGV[0]

case command
when "new"
  Taylor::Commands::New.call(ARGV[1..], config)

when "export"
  Taylor::Commands::Export.call(ARGV[1..], config)

when "squash"
  Taylor::Commands::Squash.call(ARGV[1..], config)

when "--version", "-v"
  Taylor::Commands::Version.call

else
  Taylor::Commands::Run.call(ARGV, config)
end
