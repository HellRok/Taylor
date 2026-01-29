@unit = Neospec::Suite.new(runner: Neospec::Runner::Basic.new)
@browser = Neospec::Suite.new(runner: Neospec::Runner::Basic.new)

neospec = Neospec.new(
  logger: Neospec::Logger::Basic.new,
  reporters: [
    Neospec::Report::Basic,
    Neospec::Report::BuildkiteAnalytics
  ],
  suites: [@unit]
)

# We use load here to forcefully re-require the commands that are unloaded by
# Taylor::Commands::Run automatically
load "templates/game_template.rb"
load "app/commands/export.rb"
load "app/commands/new.rb"
load "app/commands/run.rb"
load "app/commands/squash.rb"
load "app/commands/version.rb"

require "test/helpers"
require "test/monkey_patches"

require "test/commands/export_test"
require "test/commands/new_test"
require "test/commands/run_test"
require "test/commands/squash_test"
require "test/commands/version_test"
require "test/overrides"

neospec.run!
