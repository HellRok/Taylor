@unit.describe "Export --help" do
  Given "We have run `taylor export --help`" do
    @export_command = Taylor::Commands::Export.new(["--help"], {})
  end

  Then "we return useful information" do
    expect(@export_command.puts_data).to_include("Taylor #{TAYLOR_VERSION}")
    expect(@export_command.puts_data).to_include("taylor export [options]")
    expect(@export_command.puts_data).to_include("-h, --help")
    expect(@export_command.puts_data).to_include("-r, --dry-run")
    expect(@export_command.puts_data).to_include("-d, --export-directory")
    expect(@export_command.puts_data).to_include("-t, --export-targets")
    expect(@export_command.puts_data).to_include("-b, --build-cache")
  end

  And "we don't create a directory" do
    expect { Dir.exist?("./exports") }.to_be_false
  end
end

@unit.describe "Export" do
  Given "we are in a directory with a taylor-config.json" do
    expect { File.exist?("taylor-config.json") }.to_be_true
  end

  Then "exporting creates an 'exports' directory" do
    @export_command = Taylor::Commands::Export.new([], {})
    expect { Dir.exist?("./exports") }.to_be_true
  ensure
    Dir.rmdir("./exports")
  end

  And "the expected amount of commands are run" do
    expect(@export_command.backtick_data.size).to_equal(5)
  end

  And "a linux docker command is run" do
    expect(@export_command.backtick_data[0]).to_equal(
      [
        "docker run",
        "--mount type=bind,source=#{Dir.pwd},target=/app/game",
        "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
        "--env USER_ID=$(id -u ${USER})",
        "--env GROUP_ID=$(id -g ${USER})",
        "hellrok/taylor:linux-v#{TAYLOR_VERSION}"
      ].join(" ")
    )
  end

  And "a windows docker command is run" do
    expect(@export_command.backtick_data[1]).to_equal(
      [
        "docker run",
        "--mount type=bind,source=#{Dir.pwd},target=/app/game",
        "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
        "--env USER_ID=$(id -u ${USER})",
        "--env GROUP_ID=$(id -g ${USER})",
        "hellrok/taylor:windows-v#{TAYLOR_VERSION}"
      ].join(" ")
    )
  end

  And "a OSX Apple docker command is run" do
    expect(@export_command.backtick_data[3]).to_equal(
      [
        "docker run",
        "--mount type=bind,source=#{Dir.pwd},target=/app/game",
        "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
        "--env USER_ID=$(id -u ${USER})",
        "--env GROUP_ID=$(id -g ${USER})",
        "--env EXPORT=osx/apple",
        "hellrok/taylor:osx-v#{TAYLOR_VERSION}"
      ].join(" ")
    )
  end

  And "a OSX Intel docker command is run" do
    expect(@export_command.backtick_data[2]).to_equal(
      [
        "docker run",
        "--mount type=bind,source=#{Dir.pwd},target=/app/game",
        "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
        "--env USER_ID=$(id -u ${USER})",
        "--env GROUP_ID=$(id -g ${USER})",
        "--env EXPORT=osx/intel",
        "hellrok/taylor:osx-v#{TAYLOR_VERSION}"
      ].join(" ")
    )
  end

  And "a web docker command is run" do
    expect(@export_command.backtick_data[4]).to_equal(
      [
        "docker run",
        "--mount type=bind,source=#{Dir.pwd},target=/app/game",
        "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
        "--env USER_ID=$(id -u ${USER})",
        "--env GROUP_ID=$(id -g ${USER})",
        "hellrok/taylor:web-v#{TAYLOR_VERSION}"
      ].join(" ")
    )
  end

  But "if there is no taylor-config.json" do
    @original_path = Dir.pwd
    Dir.chdir("./test")
    expect { File.exist?("taylor-config.json") }.to_be_false
  end

  Then "exporting does raise an error " do
    expect {
      Taylor::Commands::Export.new([], {})
    }.to_raise(RuntimeError)
  ensure
    Dir.chdir(@original_path)
  end
end

@unit.describe "Export --dry-run" do
  When "called with --dry-run" do
    @export_command = Taylor::Commands::Export.new(["--dry-run"], {})
  end

  Then "no 'exports' directory is created" do
    expect { Dir.exist?("./exports") }.to_be_false
  end

  And "no commands are run" do
    expect(@export_command.backtick_data).to_be_nil
  end

  And "a linux docker command is output" do
    expect(
      @export_command.puts_data
    ).to_include(
      [
        "docker run",
        "--mount type=bind,source=#{Dir.pwd},target=/app/game",
        "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
        "--env USER_ID=$(id -u ${USER})",
        "--env GROUP_ID=$(id -g ${USER})",
        "hellrok/taylor:linux-v#{TAYLOR_VERSION}"
      ].join(" ")
    )
  end

  And "a windows docker command is output" do
    expect(
      @export_command.puts_data
    ).to_include(
      [
        "docker run",
        "--mount type=bind,source=#{Dir.pwd},target=/app/game",
        "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
        "--env USER_ID=$(id -u ${USER})",
        "--env GROUP_ID=$(id -g ${USER})",
        "hellrok/taylor:windows-v#{TAYLOR_VERSION}"
      ].join(" ")
    )
  end

  And "a OSX Apple docker command is output" do
    expect(
      @export_command.puts_data
    ).to_include(
      [
        "docker run",
        "--mount type=bind,source=#{Dir.pwd},target=/app/game",
        "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
        "--env USER_ID=$(id -u ${USER})",
        "--env GROUP_ID=$(id -g ${USER})",
        "--env EXPORT=osx/apple",
        "hellrok/taylor:osx-v#{TAYLOR_VERSION}"
      ].join(" ")
    )
  end

  And "a OSX Intel docker command is output" do
    expect(
      @export_command.puts_data
    ).to_include(
      [
        "docker run",
        "--mount type=bind,source=#{Dir.pwd},target=/app/game",
        "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
        "--env USER_ID=$(id -u ${USER})",
        "--env GROUP_ID=$(id -g ${USER})",
        "--env EXPORT=osx/intel",
        "hellrok/taylor:osx-v#{TAYLOR_VERSION}"
      ].join(" ")
    )
  end

  And "a web docker command is output" do
    expect(
      @export_command.puts_data
    ).to_include(
      [
        "docker run",
        "--mount type=bind,source=#{Dir.pwd},target=/app/game",
        "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
        "--env USER_ID=$(id -u ${USER})",
        "--env GROUP_ID=$(id -g ${USER})",
        "hellrok/taylor:web-v#{TAYLOR_VERSION}"
      ].join(" ")
    )
  end
end

@unit.describe "Export { export_directory }" do
  When "called with export_directory in the config" do
    @export_command = Taylor::Commands::Export.new([], {"export_directory" => "releases_option"})
  end

  Then "we create the directory, not 'exports'" do
    expect { Dir.exist?("./exports") }.to_be_false
    expect { Dir.exist?("./releases_option") }.to_be_true
  ensure
    Dir.rmdir("./releases_option")
  end

  And "the docker commands contain the new directory" do
    @export_command.backtick_data.each do |backtick|
      expect(backtick).to_include(
        "--mount type=bind,source=#{File.join(Dir.pwd, "releases_option")},target=/app/game/exports"
      )
    end
  end
end

@unit.describe "Export --export-directory" do
  When "called with --export-directory" do
    @export_command = Taylor::Commands::Export.new(["--export-directory", "releases_flag"], {})
  end

  Then "we create the directory, not 'exports'" do
    expect { Dir.exist?("./exports") }.to_be_false
    expect { Dir.exist?("./releases_flag") }.to_be_true
  ensure
    Dir.rmdir("./releases_flag")
  end

  And "the docker commands contain the new directory" do
    @export_command.backtick_data.each do |backtick|
      expect(backtick).to_include(
        "--mount type=bind,source=#{File.join(Dir.pwd, "releases_flag")},target=/app/game/exports"
      )
    end
  end
end

@unit.describe "Export { export_targets }" do
  When "called with export_targets in the config" do
    @export_command = Taylor::Commands::Export.new([], {"export_targets" => ["linux", "web"]})
  ensure
    Dir.rmdir("exports")
  end

  Then "the expected amount of commands are run" do
    expect(@export_command.backtick_data.size).to_equal(2)
  end

  And "a linux export command is run" do
    expect(@export_command.backtick_data[0]).to_equal(
      [
        "docker run",
        "--mount type=bind,source=#{Dir.pwd},target=/app/game",
        "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
        "--env USER_ID=$(id -u ${USER})",
        "--env GROUP_ID=$(id -g ${USER})",
        "hellrok/taylor:linux-v#{TAYLOR_VERSION}"
      ].join(" ")
    )
  end

  And "a web export command is run" do
    expect(@export_command.backtick_data[1]).to_equal(
      [
        "docker run",
        "--mount type=bind,source=#{Dir.pwd},target=/app/game",
        "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
        "--env USER_ID=$(id -u ${USER})",
        "--env GROUP_ID=$(id -g ${USER})",
        "hellrok/taylor:web-v#{TAYLOR_VERSION}"
      ].join(" ")
    )
  end
end

@unit.describe "Export --export-targets" do
  When "called with --export-targets" do
    @export_command = Taylor::Commands::Export.new(["--export-targets", "linux,web"], {})
  ensure
    Dir.rmdir("exports")
  end

  Then "the expected amount of commands are run" do
    expect(@export_command.backtick_data.size).to_equal(2)
  end

  And "a linux export command is run" do
    expect(@export_command.backtick_data[0]).to_equal(
      [
        "docker run",
        "--mount type=bind,source=#{Dir.pwd},target=/app/game",
        "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
        "--env USER_ID=$(id -u ${USER})",
        "--env GROUP_ID=$(id -g ${USER})",
        "hellrok/taylor:linux-v#{TAYLOR_VERSION}"
      ].join(" ")
    )
  end

  And "a web export command is run" do
    expect(@export_command.backtick_data[1]).to_equal(
      [
        "docker run",
        "--mount type=bind,source=#{Dir.pwd},target=/app/game",
        "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
        "--env USER_ID=$(id -u ${USER})",
        "--env GROUP_ID=$(id -g ${USER})",
        "hellrok/taylor:web-v#{TAYLOR_VERSION}"
      ].join(" ")
    )
  end
end

@unit.describe "Export --build-cache" do
  When "called with --build-cache and --dry-run" do
    @export_command = Taylor::Commands::Export.new(["--dry-run", "--build-cache", "build_cache"], {})
  end

  Then "we don't create a directory or execute commands" do
    expect(Dir.exist?("./build_cache")).to_be_false
    expect(@export_command.backtick_data).to_be_nil
  end

  When "called with --build-cache" do
    @export_command = Taylor::Commands::Export.new(["--build-cache", "build_cache_flag"], {})
  ensure
    Dir.rmdir("exports")
  end

  Then "a directory is created" do
    expect(Dir.exist?("./build_cache_flag")).to_be_true
  ensure
    Dir.rmdir("build_cache_flag")
  end

  And "the commands use the build cache" do
    @export_command.backtick_data.each do |backtick|
      expect(backtick).to_include(
        "--mount type=bind,source=#{File.join(Dir.pwd, "build_cache_flag")},target=/app/taylor/build/"
      )
    end
  end
end
