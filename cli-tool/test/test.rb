# We use load here to forcefully re-require the commands that are unloaded by
# automatically Taylor::Commands::Run
load './templates/game_template.rb'
load './app/commands/export.rb'
load './app/commands/new.rb'
load './app/commands/run.rb'
load './app/commands/version.rb'

require './test/helpers'
require './test/monkey_patches'

require './test/commands/export'
require './test/commands/new'
require './test/commands/run'
require './test/commands/version'

exit 1 if MTest::Unit.new.run.positive?
