def setup_folders
  Dir.mkdir("run_test")
  Dir.mkdir("run_test/nested")
  Dir.mkdir("run_test/nested/deeply_nested")
  Dir.mkdir("run_test/game")
  File.open("run_test/game/game.rb", "w") { |file| file.puts "puts 'client'" }
  File.open("run_test/game/server.rb", "w") { |file| file.puts "puts 'server'" }
  File.open("run_test/game/taylor-config.json", "w") { |file| file.puts({entrypoint: "game.rb"}.to_json) }
end

@unit.describe "Run --help" do
  Given "We have run `taylor --help`" do
    @run_command = Taylor::Commands::Run.new(["./cli.rb", "--help"], Taylor::Config.new(file: ""))
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
    Taylor::Commands::Run.new("./cli.rb", Taylor::Config.new(file: ""))
  end

  Then "remove the 'Command' constant" do
    expect(Taylor.removed_constants).to_equal([:Commands])
  end
end

@unit.describe "Run - folder" do
  Given "we're in some folders" do
    setup_folders
  end

  When "we pass a relative folder" do
    @run_command = Taylor::Commands::Run.new(
      "./run_test/game/server.rb",
      Taylor::Config.new(file: "run_test/game/taylor-config.json")
    )
  end

  Then "we require that file" do
    expect(@run_command.require_list.size).to_equal(1)
    expect(@run_command.require_list.first.end_with?("/run_test/game/server.rb")).to_be_true
  end
ensure
  delete_dir("run_test")
end

@unit.describe "Run - relative parent folder" do
  Given "we're in some folders" do
    setup_folders
  end

  When "we pass a relative folder elsewhere" do
    Dir.chdir("run_test/nested/deeply_nested") do
      config = Taylor::Config.new(file: "../../game/taylor-config.json")
      @run_command = Taylor::Commands::Run.new("../../game", config)
    end
  end

  Then "we require that file" do
    expect(@run_command.require_list.size).to_equal(1)
    expect(@run_command.require_list.first.end_with?("/run_test/game/game.rb")).to_be_true
  end
ensure
  delete_dir("run_test")
end

@unit.describe "Run - absolute folder" do
  Given "we're in some folders" do
    setup_folders
  end

  When "we pass an absolute folder" do
    @run_command = Taylor::Commands::Run.new(
      File.absolute_path("./run_test/game"),
      Taylor::Config.new(file: "./run_test/game/taylor-config.json")
    )
  end

  Then "we require that file" do
    expect(@run_command.require_list.size).to_equal(1)
    expect(@run_command.require_list.first.end_with?("/run_test/game/game.rb")).to_be_true
  end
ensure
  delete_dir("run_test")
end

@unit.describe "Run - file" do
  Given "we're in some folders" do
    setup_folders
  end

  When "we pass a filename" do
    @run_command = Taylor::Commands::Run.new(
      "./run_test/game/game.rb",
      Taylor::Config.new(file: "./run_test/game/taylor-config.json")
    )
  end

  Then "we require that file" do
    expect(@run_command.require_list.size).to_equal(1)
    expect(@run_command.require_list.first.end_with?("/run_test/game/game.rb")).to_be_true
  end
ensure
  delete_dir("run_test")
end

@unit.describe "Run - relative parent file" do
  Given "we're in some folders" do
    setup_folders
  end

  When "we pass a relative file elsewhere" do
    Dir.chdir("run_test/nested/deeply_nested") do
      @run_command = Taylor::Commands::Run.new(
        "../../game/server.rb",
        Taylor::Config.new(file: "../../game/taylor-config.json")
      )
    end
  end

  Then "we require that file" do
    expect(@run_command.require_list.size).to_equal(1)
    expect(@run_command.require_list.first.end_with?("/run_test/game/server.rb")).to_be_true
  end
ensure
  delete_dir("run_test")
end

@unit.describe "Run - absolute file" do
  Given "we're in some folders" do
    setup_folders
  end

  When "we pass an absolute file" do
    @run_command = Taylor::Commands::Run.new(
      File.absolute_path("./run_test/game/game.rb"),
      Taylor::Config.new(file: "./run_test/game/taylor-config.json")
    )
  end

  Then "we require that file" do
    expect(@run_command.require_list.size).to_equal(1)
    expect(@run_command.require_list.first.end_with?("/run_test/game/game.rb")).to_be_true
  end
ensure
  delete_dir("run_test")
end

@unit.describe "Run - no args" do
  Given "we're in the game folder" do
    setup_folders
  end

  When "we don't pass a filename" do
    Dir.chdir("./run_test/game") do
      @run_command = Taylor::Commands::Run.new(
        [],
        Taylor::Config.new(file: "./taylor-config.json")
      )
    end
  end

  Then "require the file in the options" do
    expect(@run_command.require_list.size).to_equal(1)
    expect(@run_command.require_list.first.end_with?("/run_test/game/game.rb")).to_be_true
  end
ensure
  delete_dir("run_test")
end

@unit.describe "Run - entrypoint flag" do
  When "we pass a file by entrypoint" do
    @run_command = Taylor::Commands::Run.new(["--entrypoint", "test/test.rb"], Taylor::Config.new(file: ""))
  end

  Then "require the file in the options" do
    expect(@run_command.require_list.size).to_equal(1)
    expect(@run_command.require_list.first.end_with?("test/test.rb")).to_be_true
  end
end

@unit.describe "Run - non-existant file" do
  When "we pass a file that doesn't exist" do
    @run_command = Taylor::Commands::Run.new("./non_existant.rb", Taylor::Config.new)
  end

  Then "we exit with an error" do
    expect(@run_command.exit_status).to_equal(1)
  end
end

@unit.describe "Run - with arguments for the game" do
  When "we pass specify arguments for the entrypoint via --" do
    @run_command = Taylor::Commands::Run.new(
      ["--entrypoint", "test/test.rb", "--", "-a", "arg1", "arg2"],
      Taylor::Config.new(file: "")
    )
  end

  Then "ARGV is manipulated for the entrypoint after we've parsed the run opts" do
    expect(@run_command.require_list.size).to_equal(1)
    expect(@run_command.require_list.first.end_with?("test/test.rb")).to_be_true
    expect(ARGV).to_equal(["-a", "arg1", "arg2"])
    expect(@run_command.options[:entrypoint]).to_equal("test/test.rb")
  end
end

@unit.describe "Run - with arguments Taylor" do
  When "we pass specify arguments for the entrypoint via -- without any options for the command" do
    @run_command = Taylor::Commands::Run.new(["--", "--entrypoint", "arg1", "-h"], Taylor::Config.new)
  end

  Then "ARGV is manipulated to contain all the args" do
    expect(ARGV).to_equal(["--entrypoint", "arg1", "-h"])
    expect(@run_command.options[:help]).to_be_false
    expect(@run_command.options[:entrypoint].end_with?("cli.rb")).to_be_true
    expect(@run_command.require_list.size).to_equal(1)
    expect(@run_command.require_list.first.end_with?("cli.rb")).to_be_true
  end
end
