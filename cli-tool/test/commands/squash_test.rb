@unit.describe "Squash --help" do
  When "we call `taylor squash --help`" do
    @squash_command = Taylor::Commands::Squash.new(["--help"], {})
  end

  Then "we get useful information" do
    expect(@squash_command.puts_data).to_include("Taylor #{TAYLOR_VERSION}")
    expect(@squash_command.puts_data).to_include("taylor squash [options]")

    expect(@squash_command.puts_data).to_include("taylor squash [options]")

    expect(@squash_command.puts_data).to_include("-h, --help")
    expect(@squash_command.puts_data).to_include("-s, --stdout")
    expect(@squash_command.puts_data).to_include("-i, --input")
    expect(@squash_command.puts_data).to_include("-l, --load-paths")
  end
end

@unit.describe "Squash" do
  Given "we have a project with some files" do
    Taylor::Commands::New.new(["./test/test_game"], {})
    Dir.chdir "./test/test_game" do
      File.open("game.rb", "w") { |file| file.write "puts :game_content\nrequire 'other_file.rb'" }
      File.open("other_file.rb", "w") { |file| file.write "Other file content" }
    end
  end

  When "we call squash" do
    Dir.chdir "./test/test_game" do
      Taylor::Commands::Squash.new([], {})
      @output = File.read("./output.rb")
    end
  end

  Then "output.rb contains the new code" do
    expect(@output).to_equal(<<~OUT)
      # Start game.rb
      puts :game_content
      # Start ./other_file.rb
      Other file content
      # End ./other_file.rb
      # End game.rb
    OUT
  end

  When "we have a file with an non-existant require" do
    Dir.chdir "./test/test_game" do
      File.open("game.rb", "w") { |file| file.write "require 'doesnt_exist'" }
    end
  end

  Then "raise an error" do
    Dir.chdir "./test/test_game" do
      expect {
        Taylor::Commands::Squash.new([], {})
      }.to_raise(
        RuntimeError,
        "No matching file for doesnt_exist.rb"
      )
    end
  end

  When "we call squash with a specific file" do
    Dir.chdir "./test/test_game" do
      File.open("beep.rb", "w") { |file| file.write "BEEP" }
      @squash_command = Taylor::Commands::Squash.new(["--input", "beep.rb"], {})
    end
  end

  Then "we only have `beep.rb` contents" do
    Dir.chdir "./test/test_game" do
      expect(File.read("output.rb")).to_equal(<<~OUT)
        # Start beep.rb
        BEEP
        # End beep.rb
      OUT
    end
  end

  When "we call squash with the input option" do
    Dir.chdir "./test/test_game" do
      File.open("boop.rb", "w") { |file| file.write "BOOP" }
      @squash_command = Taylor::Commands::Squash.new([], {"input" => "boop.rb"})
    end
  end

  Then "we only have `boop.rb` contents" do
    Dir.chdir "./test/test_game" do
      expect(File.read("output.rb")).to_equal(<<~OUT)
        # Start boop.rb
        BOOP
        # End boop.rb
      OUT
    end
  end

  When "we have a library in our vendor folder" do
    Dir.chdir "./test/test_game" do
      Dir.mkdir("vendor/cool_plugin")
      File.open("vendor/cool_plugin/other_file.rb", "w") { |file| file.write "Other file content" }
    end
  end

  And "we import it without 'vendor'" do
    Dir.chdir "./test/test_game" do
      File.open("game.rb", "w") { |file| file.write "require 'cool_plugin/other_file'" }
      @squash_command = Taylor::Commands::Squash.new([], {})
    end
  end

  Then "we get the right file" do
    Dir.chdir "./test/test_game" do
      expect(File.read("output.rb")).to_equal(<<~OUT)
        # Start game.rb
        # Start ./vendor/cool_plugin/other_file.rb
        Other file content
        # End ./vendor/cool_plugin/other_file.rb
        # End game.rb
      OUT
    end
  end

  When "we have a file in the passed in load path" do
    Dir.chdir "./test/test_game" do
      Dir.mkdir("third-party")
      File.open("third-party/another_file.rb", "w") { |file| file.write "Other file content" }
    end
  end

  And "we import it without 'third-party'" do
    Dir.chdir "./test/test_game" do
      File.open("game.rb", "w") { |file| file.write "require 'another_file'" }
      @squash_command = Taylor::Commands::Squash.new(["--load-paths", "./,./third-party"], {})
    end
  end

  Then "we get the right file" do
    Dir.chdir "./test/test_game" do
      expect(File.read("output.rb")).to_equal(<<~OUT)
        # Start game.rb
        # Start ./third-party/another_file.rb
        Other file content
        # End ./third-party/another_file.rb
        # End game.rb
      OUT
    end
  end

  When "the require is commented out" do
    Dir.chdir "./test/test_game" do
      File.open("game.rb", "w") { |file|
        file.write <<~OUT
           #  require 'other_file'
          #require 'other_file'
        OUT
      }
      @squash_command = Taylor::Commands::Squash.new([], {})
    end
  end

  Then "we ignore it" do
    Dir.chdir "./test/test_game" do
      expect(File.read("output.rb")).to_equal(<<~OUT)
        # Start game.rb
         #  require 'other_file'
        #require 'other_file'
        # End game.rb
      OUT
    end
  end

  When "the file doesn't end with new line" do
    Dir.chdir "./test/test_game" do
      File.open("game.rb", "w") { |file| file.write "require 'other_file'" }
      File.open("other_file.rb", "w") { |file| file.write "Other file content" }
      @squash_command = Taylor::Commands::Squash.new([], {})
    end
  end

  Then "we add a new line" do
    Dir.chdir "./test/test_game" do
      expect(File.read("output.rb")).to_equal(<<~OUT)
        # Start game.rb
        # Start ./other_file.rb
        Other file content
        # End ./other_file.rb
        # End game.rb
      OUT
    end
  end

  When "the require is in a loop" do
    Dir.chdir "./test/test_game" do
      File.open("game.rb", "w") { |file| file.write "Dir.entries('mods').each { require File.join('mods', _1) }" }
      @squash_command = Taylor::Commands::Squash.new([], {})
    end
  end

  Then "we don't replace it" do
    Dir.chdir "./test/test_game" do
      expect(File.read("output.rb")).to_equal(<<~OUT)
        # Start game.rb
        Dir.entries('mods').each { require File.join('mods', _1) }
        # End game.rb
      OUT
    end
  end

  When "the require is interpolated" do
    Dir.chdir "./test/test_game" do
      File.open("game.rb", "w") { |file| file.write "variable = 'test'\nrequire \"./vendor/\#{variable}\"" }
      @squash_command = Taylor::Commands::Squash.new([], {})
    end
  end

  Then "we don't replace it" do
    Dir.chdir "./test/test_game" do
      expect(File.read("output.rb")).to_equal(<<~OUT)
        # Start game.rb
        variable = 'test'
        require "./vendor/\#{variable}"
        # End game.rb
      OUT
    end
  end
ensure
  delete_project("./test/test_game")
end
