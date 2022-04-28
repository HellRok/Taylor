# We use load here to forcefully re-require the commands that are unloaded by
# automatically Taylor::Commands::Run
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
exit 1 if result
