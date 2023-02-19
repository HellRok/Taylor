# We do this because we need to actually call it if there are failing tests
# (which is what happened and why I noticed!)
real_exit_bang = method(:exit!).to_proc

# We use load here to forcefully re-require the commands that are unloaded by
# Taylor::Commands::Run automatically
load './templates/game_template.rb'
load './app/commands/export.rb'
load './app/commands/new.rb'
load './app/commands/run.rb'
load './app/commands/version.rb'

require './test/helpers'
require './test/monkey_patches'

require './test/commands/export_test'
require './test/commands/new_test'
require './test/commands/run_test'
require './test/commands/version_test'

result = MTest::Unit.new.run.positive?
upload_buildkite_test_analytics

real_exit_bang.call(1) if result
