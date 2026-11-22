@unit.describe "Taylor::Config::Finder.call" do
  Given "We have a mess of directories" do
    Dir.mkdir("config_test")
    Dir.mkdir("config_test/game_1")
    Dir.mkdir("config_test/game_1/app")
    Dir.mkdir("config_test/game_1/app/lib")
    Dir.mkdir("config_test/code")
    Dir.mkdir("config_test/code/game_2")
    File.open("config_test/game_1/taylor-config.json", "w") { |file|
      file.puts({entrypoint: "game_1.rb"}.to_json)
    }
    File.open("config_test/code/game_2/taylor-config.json", "w") { |file|
      file.puts({entrypoint: "game_2.rb"}.to_json)
    }
  end

  Then "we can find the config by folder" do
    expect(
      Taylor::Config::Finder.call("./config_test/game_1").entrypoint
    ).to_equal("game_1.rb")
  end

  And "we can find the config by file" do
    expect(
      Taylor::Config::Finder.call("./config_test/code/game_2/taylor-config.json").entrypoint
    ).to_equal("game_2.rb")
  end

  And "we can find the config in a parent folder" do
    expect(
      Taylor::Config::Finder.call("./config_test/game_1/app/lib").entrypoint
    ).to_equal("game_1.rb")
  end

  When "we are in one game" do
    Dir.chdir("config_test/code/game_2")
  end

  Then "we can find the config with a relative folder" do
    expect(
      Taylor::Config::Finder.call("../../game_1").entrypoint
    ).to_equal("game_1.rb")
  ensure
    Dir.chdir("../../../")
  end
ensure
  delete_dir("config_test")
end
