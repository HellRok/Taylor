@unit.describe "Run --help" do
  Given "We have run `taylor --help`" do
    @run_command = Taylor::Commands::Run.new("./cli.rb", ["--help"], Taylor::Config.new)
  end

  Then "we return useful information" do
    expect(@run_command.puts_data).to_include("Taylor #{TAYLOR_VERSION}")

    expect(@run_command.puts_data).to_include(
      "taylor\t\t\t# If the current folder is a taylor game, launch it"
    )
    expect(@run_command.puts_data).to_include("taylor ./game.rb")
    expect(@run_command.puts_data).to_include("taylor --entrypoint ./game.rb")
    expect(@run_command.puts_data).to_include("taylor <action> [options]")

    expect(@run_command.puts_data).to_include("-h, --help")
    expect(@run_command.puts_data).to_include("-v, --version")
    expect(@run_command.puts_data).to_include("-e, --entrypoint entrypoint")

    expect(@run_command.puts_data).to_include(
      "new\t\tCreate a new Taylor game"
    )
    expect(@run_command.puts_data).to_include(
      "export\tCompile your game for release"
    )
    expect(@run_command.puts_data).to_include(
      "squash\tSquash all your source code into one file"
    )
  end
end

@unit.describe "Run" do
  When "we call run" do
    Taylor.removed_constants = []
    Taylor::Commands::Run.new("./cli.rb", [], Taylor::Config.new)
  end

  Then "remove the 'Command' constant" do
    expect(Taylor.removed_constants).to_equal([:Commands])
  end

  When "we pass a filename" do
    @run_command = Taylor::Commands::Run.new("./test/test.rb", [], Taylor::Config.new)
  end

  Then "we require that file" do
    expect(@run_command.require_list).to_equal(["./test/test.rb"])
  end

  When "we don't pass a filename" do
    config = Taylor::Config.new
    config.entrypoint = "./cli.rb"
    @run_command = Taylor::Commands::Run.new(nil, [], config)
  end

  Then "require the file in the options" do
    expect(@run_command.require_list).to_equal(["./cli.rb"])
  end

  When "we pass a file by entrypoint" do
    @run_command = Taylor::Commands::Run.new("--entrypoint", ["--entrypoint", "test/test.rb"], Taylor::Config.new)
  end

  Then "require the file in the options" do
    expect(@run_command.require_list).to_equal(["test/test.rb"])
  end

  When "we pass a file that doesn't exist" do
    @run_command = Taylor::Commands::Run.new("./non_existant.rb", [], Taylor::Config.new)
  end

  Then "we exit with an error" do
    expect(@run_command.exit_status).to_equal(1)
  end

  When "we pass specify arguments for the entrypoint via --" do
    @run_command = Taylor::Commands::Run.new(
      "--entrypoint",
      ["--entrypoint", "test/test.rb", "--", "-a", "arg1", "arg2"],
      Taylor::Config.new
    )
  end

  Then "ARGV is manipulated for the entrypoint after we've parsed the run opts" do
    expect(@run_command.require_list).to_equal(["test/test.rb"])
    expect(ARGV).to_equal(["-a", "arg1", "arg2"])
    expect(@run_command.options[:entrypoint]).to_equal("test/test.rb")
  end

  When "we pass specify arguments for the entrypoint via -- without any options for the command" do
    @run_command = Taylor::Commands::Run.new(
      "--",
      ["--", "--entrypoint", "arg1", "-h"],
      Taylor::Config.new
    )
  end

  Then "ARGV is manipulated to contain all the args" do
    expect(ARGV).to_equal(["--entrypoint", "arg1", "-h"])
    expect(@run_command.options).to_equal(help: false, entrypoint: "cli.rb")
    expect(@run_command.require_list).to_equal(["cli.rb"])
  end
end
