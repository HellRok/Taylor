@unit.describe "Taylor::Config.new" do
  Given "We have no config file in the directory" do
    Dir.mkdir("config_test")
    Dir.chdir("config_test")

    expect(File.exist?("./taylor-config.json")).to_be_false
  end

  Then "we return the default configuration" do
    config = Taylor::Config.new
    expect(config.name).to_equal("Taylor Game")
    expect(config.version).to_equal("v0.0.1")
    expect(config.entrypoint).to_equal("game.rb")
    expect(config.export_directory).to_equal("./exports")
    expect(config.export_targets).to_equal(["linux", "windows", "osx/apple", "osx/intel", "web"])
    expect(config.load_paths).to_equal(["./", "./vendor"])
    expect(config.copy_paths).to_equal(["./assets"])
    expect(config.web.shell_path).to_be_nil
    expect(config.web.total_memory).to_equal(64)
    expect(config.debugging.raylib.mock_implementation?).to_be_false
    expect(config.debugging.mruby.debug_symbols?).to_be_false
  end

  But "When we have a taylor-config.json file" do
    config = File.open("taylor-config.json", "w")
    config.write({
      "name" => "name",
      "version" => "version",
      "entrypoint" => "entrypoint",
      "export_directory" => "export_directory",
      "export_targets" => ["export", "targets"],
      "load_paths" => ["load", "paths"],
      "copy_paths" => ["copy", "paths"],
      "web" => {
        "shell_path" => "shell_path",
        "total_memory" => 128
      },
      "debugging" => {
        "raylib" => {
          "mock_implementation" => true
        },
        "mruby" => {
          "debug_symbols" => true
        }
      }
    }.to_json)
    config.close
  end

  Then "we return the configuration" do
    config = Taylor::Config.new
    expect(config.name).to_equal("name")
    expect(config.version).to_equal("version")
    expect(config.entrypoint).to_equal("entrypoint")
    expect(config.export_directory).to_equal("export_directory")
    expect(config.export_targets).to_equal(["export", "targets"])
    expect(config.load_paths).to_equal(["load", "paths"])
    expect(config.copy_paths).to_equal(["copy", "paths"])
    expect(config.web.shell_path).to_equal("shell_path")
    expect(config.web.total_memory).to_equal(128)
    expect(config.debugging.raylib.mock_implementation?).to_be_true
    expect(config.debugging.mruby.debug_symbols?).to_be_true
  end

  When "we override the options" do
    @config = Taylor::Config.new

    @config.name = "manual name"
    @config.version = "manual version"
    @config.entrypoint = "manual entrypoint"
    @config.export_directory = "manual export_directory"
    @config.export_targets = ["manual", "export", "targets"]
    @config.load_paths = ["manual", "load", "paths"]
    @config.copy_paths = ["manual", "copy", "paths"]
    @config.web.shell_path = "manual shell_path"
    @config.web.total_memory = 256
    @config.debugging.raylib.mock_implementation = false
    @config.debugging.mruby.debug_symbols = false
  end

  Then "we return the overridden configuration" do
    expect(@config.name).to_equal("manual name")
    expect(@config.version).to_equal("manual version")
    expect(@config.entrypoint).to_equal("manual entrypoint")
    expect(@config.export_directory).to_equal("manual export_directory")
    expect(@config.export_targets).to_equal(["manual", "export", "targets"])
    expect(@config.load_paths).to_equal(["manual", "load", "paths"])
    expect(@config.copy_paths).to_equal(["manual", "copy", "paths"])
    expect(@config.web.shell_path).to_equal("manual shell_path")
    expect(@config.web.total_memory).to_equal(256)
    expect(@config.debugging.raylib.mock_implementation?).to_be_false
    expect(@config.debugging.mruby.debug_symbols?).to_be_false
  end

  But "when we have the old keys" do
    config = File.open("taylor-config.json", "w")
    config.write({
      "export-directory" => "export-directory",
      "export-targets" => ["export-targets"],
      "load-paths" => ["load-paths"],
      "copy-paths" => ["copy-paths"]
    }.to_json)
    config.close
  end

  Then "we load the data" do
    @config = Taylor::Config.new

    expect(@config.export_directory).to_equal("export-directory")
    expect(@config.export_targets).to_equal(["export-targets"])
    expect(@config.load_paths).to_equal(["load-paths"])
    expect(@config.copy_paths).to_equal(["copy-paths"])
  end

  But "we warn the user" do
    calls = Taylor::Raylib.calls
    expect(calls.size).to_equal(4)
    expect(calls[0]).to_equal("(TraceLog) { logLevel: 4 text: 'Old key 'export-directory' used, please use 'export_directory'' }")
    expect(calls[1]).to_equal("(TraceLog) { logLevel: 4 text: 'Old key 'export-targets' used, please use 'export_targets'' }")
    expect(calls[2]).to_equal("(TraceLog) { logLevel: 4 text: 'Old key 'load-paths' used, please use 'load_paths'' }")
    expect(calls[3]).to_equal("(TraceLog) { logLevel: 4 text: 'Old key 'copy-paths' used, please use 'copy_paths'' }")
  end
ensure
  Dir.chdir("..")
  File.delete("config_test/taylor-config.json") if File.exist?("config_test/taylor-config.json")
  Dir.delete("config_test")
end

@unit.describe "Taylor::Config#entrypoint" do
  Given "We have no config file in the directory" do
    Dir.mkdir("config_test")
    Dir.chdir("config_test")

    expect(File.exist?("./taylor-config.json")).to_be_false
  end

  Then "we return the default configuration" do
    config = Taylor::Config.new
    expect(config.entrypoint).to_equal("game.rb")
  end

  But "When we have a taylor-config.json file that defines entrypoint" do
    config = File.open("taylor-config.json", "w")
    config.write({
      "entrypoint" => "entrypoint"
    }.to_json)
    config.close
  end

  Then "we return the entrypoint" do
    config = Taylor::Config.new
    expect(config.entrypoint).to_equal("entrypoint")
  end

  But "When we have a taylor-config.json file that defines input" do
    config = File.open("taylor-config.json", "w")
    config.write({
      "input" => "input"
    }.to_json)
    config.close
  end

  Then "we return the input" do
    config = Taylor::Config.new
    expect(config.entrypoint).to_equal("input")
  end

  But "When we have a taylor-config.json file that defines both entrypoint and input" do
    config = File.open("taylor-config.json", "w")
    config.write({
      "entrypoint" => "entrypoint",
      "input" => "input"
    }.to_json)
    config.close
  end

  Then "we return the entrypoint" do
    config = Taylor::Config.new
    expect(config.entrypoint).to_equal("entrypoint")
  end

  When "we set the entrypoint" do
    @config = Taylor::Config.new
    @config.entrypoint = "manual entrypoint"
  end

  Then "we return the overridden entrypoint" do
    expect(@config.entrypoint).to_equal("manual entrypoint")
  end
ensure
  Dir.chdir("..")
  File.delete("config_test/taylor-config.json") if File.exist?("config_test/taylor-config.json")
  Dir.delete("config_test")
end
