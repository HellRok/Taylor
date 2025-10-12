@unit.describe "Run --help" do
  Given "We have run `taylor --help`" do
    @run_command = Taylor::Commands::Run.new("./cli.rb", ["--help"], {})
  end

  Then "we return useful information" do
    expect(@run_command.puts_data).to_include("Taylor #{TAYLOR_VERSION}")

    expect(@run_command.puts_data).to_include(
      "taylor\t\t\t# If the current folder is a taylor game, launch it"
    )
    expect(@run_command.puts_data).to_include("taylor ./game.rb")
    expect(@run_command.puts_data).to_include("taylor --input ./game.rb")
    expect(@run_command.puts_data).to_include("taylor <action> [options]")

    expect(@run_command.puts_data).to_include("-h, --help")
    expect(@run_command.puts_data).to_include("-v, --version")
    expect(@run_command.puts_data).to_include("-i, --input input")

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
    Taylor::Commands::Run.new("./cli.rb", [], {})
  end

  Then "remove the 'Command' constant" do
    expect(Taylor.removed_constants).to_equal([:Commands])
  end

  When "we pass a filename" do
    @run_command = Taylor::Commands::Run.new("./test/test.rb", [], {})
  end

  Then "we require that file" do
    expect(@run_command.require_list).to_equal(["./test/test.rb"])
  end

  When "we don't pass a filename" do
    @run_command = Taylor::Commands::Run.new(nil, [], {"input" => "./cli.rb"})
  end

  Then "require the file in the options" do
    expect(@run_command.require_list).to_equal(["./cli.rb"])
  end

  When "we pass a file that doesn't exist" do
    @run_command = Taylor::Commands::Run.new("./non_existant.rb", [], {})
  end

  Then "we exit " do
    expect(@run_command.exit_status).to_equal(1)
  end
end
