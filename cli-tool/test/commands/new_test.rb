@unit.describe "New --help" do
  Given "We have run `taylor new --help`" do
    @new_command = Taylor::Commands::New.new(["--help"], {})
  end

  Then "we return useful information" do
    expect(@new_command.puts_data).to_include("Taylor #{TAYLOR_VERSION}")
    expect(@new_command.puts_data).to_include("taylor new [options] <folder>")
    expect(@new_command.puts_data).to_include("-h, --help")
    expect(@new_command.puts_data).to_include("-n, --name")
    expect(@new_command.puts_data).to_include("-v, --version")
    expect(@new_command.puts_data).to_include("-i, --input")
    expect(@new_command.puts_data).to_include("-d, --export-directory")
    expect(@new_command.puts_data).to_include("-t, --export-targets")
    expect(@new_command.puts_data).to_include("-l, --load-paths")
    expect(@new_command.puts_data).to_include("-c, --copy-paths")
    expect(@new_command.puts_data).to_include("The folder to create the new game in (defaults to the taylor_game)")
  end

  And "we don't create a directory" do
    expect(Dir.exist?("./exports")).to_be_false
  end
end

@unit.describe "New" do
  When "we run `taylor new`" do
    Taylor::Commands::New.new([], {})
  end

  Then "we create the project" do
    data = JSON.parse(File.read("./taylor_game/taylor-config.json"))
    expect(data["name"]).to_equal("Taylor Game")
    expect(data["version"]).to_equal("v0.0.1")
    expect(data["input"]).to_equal("game.rb")
    expect(File.exist?("./taylor_game/game.rb")).to_be_true
    expect(data["export-directory"]).to_equal("./exports")
    expect(data["export-targets"]).to_equal(["linux", "windows", "osx/apple", "osx/intel", "web"])
    expect(data["load-paths"]).to_equal(["./", "./vendor"])
    expect(Dir.exist?("./taylor_game/vendor")).to_be_true
    expect(File.exist?("./taylor_game/vendor/.keep")).to_be_true
    expect(data["copy-paths"]).to_equal(["./assets"])
    expect(Dir.exist?("./taylor_game/assets")).to_be_true
    expect(File.exist?("./taylor_game/assets/.keep")).to_be_true
  ensure
    delete_project("./taylor_game")
  end

  When "we run `taylor new` with flags" do
    Taylor::Commands::New.new(
      [
        "--name", "Test Game",
        "--version", "final_v2_for_real",
        "--input", "app.rb",
        "--export-directory", "./releases",
        "--export-targets", "web,windows",
        "--load-paths", "./,./third_party",
        "--copy-paths", "./resources,./music"
      ],
      {}
    )
  end

  Then "we create the project with all the options" do
    data = JSON.parse(File.read("./test_game/taylor-config.json"))
    expect(data["name"]).to_equal("Test Game")
    expect(data["version"]).to_equal("final_v2_for_real")
    expect(data["input"]).to_equal("app.rb")
    expect(File.exist?("./test_game/app.rb")).to_be_true
    expect(data["export-directory"]).to_equal("./releases")
    expect(data["export-targets"]).to_equal(["web", "windows"])
    expect(data["load-paths"]).to_equal(["./", "./third_party"])
    expect(Dir.exist?("./test_game/third_party")).to_be_true
    expect(File.exist?("./test_game/third_party/.keep")).to_be_true
    expect(data["copy-paths"]).to_equal(["./resources", "./music"])
    expect(Dir.exist?("./test_game/resources")).to_be_true
    expect(File.exist?("./test_game/resources/.keep")).to_be_true
    expect(Dir.exist?("./test_game/music")).to_be_true
    expect(File.exist?("./test_game/music/.keep")).to_be_true
  ensure
    delete_project("./test_game")
  end
end

@unit.describe "New <folder>" do
  Given "we call `taylor test/folder-name`" do
    Taylor::Commands::New.new(["./test/folder-name"], {})
    @data = File.read("./test/folder-name/game.rb").lines
  end

  Then "the directory is created" do
    expect(Dir.exist?("./test/folder-name")).to_be_true
  ensure
    delete_project("./test/folder-name")
  end

  And "the name is set to the final folder" do
    expect(@data[4]).to_equal(
      %(Window.open(width: 800, height: 480, title: "folder-name")\n)
    )
  end

  When "we call with --name" do
    Taylor::Commands::New.new(["--name", "Test Game"], {})
    @data = File.read("./test_game/game.rb").lines
  end

  Then "the directory is created" do
    expect(Dir.exist?("./test_game")).to_be_true
  ensure
    delete_project("./test_game")
  end

  And "the name is set" do
    expect(@data[4]).to_equal(
      %(Window.open(width: 800, height: 480, title: "Test Game")\n)
    )
  end

  When "if the directory already exists" do
    expect(Dir.exist?("./test")).to_be_true
  end

  Then "raise an error" do
    expect {
      Taylor::Commands::New.new(["./test"], {})
    }.to_raise(RuntimeError)
  end
end

@unit.describe "New --load-paths" do
  Given "we call `taylor --load-paths`" do
    Taylor::Commands::New.new(
      ["--load-paths", "./,./third_party,./black_box"],
      {}
    )
    @data = File.read("./taylor_game/game.rb").lines
  end

  Then "the directories are created" do
    expect(Dir.exist?("./taylor_game/third_party")).to_be_true
    expect(Dir.exist?("./taylor_game/black_box")).to_be_true
  ensure
    delete_project("./taylor_game")
  end

  And "we put in all the load paths" do
    expect(@data[1]).to_equal("$: << './third_party'\n")
    expect(@data[2]).to_equal("$: << './black_box'\n")
  end
end

class Test
  class Commands
    class New_Test
      def test_setup_game_structure_overrides
        Taylor::Commands::New.new(
          [
            "--name", "./test/test_game_the_sequel",
            "--load-paths", "./,./third_party,./black_box"
          ],
          {}
        )
        data = File.read("./test/test_game_the_sequel/game.rb").lines
        assert_equal "$: << './third_party'\n", data[1]
        assert_equal "$: << './black_box'\n", data[2]
        assert_equal %(Window.open(width: 800, height: 480, title: "./test/test_game_the_sequel")\n), data[5]
      ensure
        File.delete(File.join("./test", "test_game_the_sequel", "game.rb"))
        File.delete(File.join("./test", "test_game_the_sequel", "taylor-config.json"))
        File.delete(File.join("./test", "test_game_the_sequel", "assets", ".keep"))
        Dir.rmdir(File.join("./test", "test_game_the_sequel", "assets"))
        File.delete(File.join("./test", "test_game_the_sequel", "third_party", ".keep"))
        Dir.rmdir(File.join("./test", "test_game_the_sequel", "third_party"))
        File.delete(File.join("./test", "test_game_the_sequel", "black_box", ".keep"))
        Dir.rmdir(File.join("./test", "test_game_the_sequel", "black_box"))
        Dir.rmdir(File.join("./test", "test_game_the_sequel"))
      end
    end
  end
end
