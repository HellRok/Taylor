class Test
  class Commands
    class Squash_Test < MTest::Unit::TestCaseWithAnalytics
      def test_help
        squash_command = Taylor::Commands::Squash.new(["--help"], {})
        assert_include squash_command.puts_data, TAYLOR_VERSION
        assert_include squash_command.puts_data, "Usage:"
        assert_include squash_command.puts_data, "Options:"
      end

      def test_basic_require
        Taylor::Commands::New.new(["./test/test_game"], {})
        Dir.chdir "./test/test_game" do
          File.open("game.rb", "w") { _1.write "require 'other_file.rb'" }
          File.open("other_file.rb", "w") { _1.write "Other file content" }

          squash_command = Taylor::Commands::Squash.new(["--stdout"], {})
          assert_include squash_command.puts_data, "Other file content"
        end
      ensure
        File.delete("./test/test_game/other_file.rb")
        delete_project("./test/test_game")
      end

      def test_basic_comments
        Taylor::Commands::New.new(["./test/test_game"], {})
        Dir.chdir "./test/test_game" do
          File.open("game.rb", "w") { _1.write "Game content\nrequire 'other_file'" }
          File.open("other_file.rb", "w") { _1.write "Other file content\n" }

          squash_command = Taylor::Commands::Squash.new(["--stdout"], {})
          assert_equal squash_command.puts_data, <<~RUBY
            # Start game.rb
            Game content
            # Start ./other_file.rb
            Other file content
            # End ./other_file.rb
            # End game.rb
          RUBY
        end
      ensure
        File.delete("./test/test_game/other_file.rb")
        delete_project("./test/test_game")
      end

      def test_mising_require
        Taylor::Commands::New.new(["./test/test_game"], {})
        Dir.chdir "./test/test_game" do
          File.open("game.rb", "w") { _1.write "require 'other_file'" }

          assert_raise(RuntimeError) {
            Taylor::Commands::Squash.new(["--stdout"], {})
          }
        end
      ensure
        delete_project("./test/test_game")
      end

      def test_specified_input
        Taylor::Commands::New.new(["./test/test_game"], {})
        Dir.chdir "./test/test_game" do
          File.open("beep.rb", "w") { _1.write "BEEP" }

          squash_command = Taylor::Commands::Squash.new(["--stdout", "--input", "beep.rb"], {})
          assert_include squash_command.puts_data, "BEEP"
        end
      ensure
        File.delete("./test/test_game/beep.rb")
        delete_project("./test/test_game")
      end

      def test_config_input
        Taylor::Commands::New.new(["./test/test_game", "--input", "beep.rb"], {})
        Dir.chdir "./test/test_game" do
          File.open("beep.rb", "w") { _1.write "BEEP" }

          squash_command = Taylor::Commands::Squash.new(["--stdout"], {"input" => "beep.rb"})
          assert_include squash_command.puts_data, "BEEP"
        end
      ensure
        delete_project("./test/test_game", input: "beep.rb")
      end

      def test_vendor_require
        Taylor::Commands::New.new(["./test/test_game"], {})
        Dir.chdir "./test/test_game" do
          File.open("game.rb", "w") { _1.write "require 'cool_plugin/other_file'" }
          Dir.mkdir("vendor/cool_plugin")
          File.open("vendor/cool_plugin/other_file.rb", "w") { _1.write "Other file content" }

          squash_command = Taylor::Commands::Squash.new(["--stdout"], {})
          assert_include squash_command.puts_data, "Start ./vendor/cool_plugin/other_file"
          assert_include squash_command.puts_data, "Other file content"
        end
      ensure
        File.delete("./test/test_game/vendor/cool_plugin/other_file.rb")
        Dir.rmdir("./test/test_game/vendor/cool_plugin")
        delete_project("./test/test_game")
      end

      def test_load_path_require
        Taylor::Commands::New.new(["./test/test_game"], {})
        Dir.chdir "./test/test_game" do
          File.open("game.rb", "w") { _1.write "require 'other_file'" }
          Dir.mkdir("third-party")
          File.open("third-party/other_file.rb", "w") { _1.write "Other file content" }

          squash_command = Taylor::Commands::Squash.new(["--stdout", "--load-paths", "./,./third-party"], {})
          assert_include squash_command.puts_data, "Start ./third-party/other_file"
          assert_include squash_command.puts_data, "Other file content"
        end
      ensure
        File.delete("./test/test_game/third-party/other_file.rb")
        Dir.rmdir("./test/test_game/third-party")
        delete_project("./test/test_game")
      end

      def test_commented_out_require
        Taylor::Commands::New.new(["./test/test_game"], {})
        Dir.chdir "./test/test_game" do
          File.open("game.rb", "w") { _1.write "#require 'other_file'\n" }

          squash_command = Taylor::Commands::Squash.new(["--stdout"], {})
          assert_equal squash_command.puts_data, "# Start game.rb\n#require 'other_file'\n# End game.rb\n"
        end
      ensure
        delete_project("./test/test_game")
      end

      def test_file_not_ending_in_new_line
        Taylor::Commands::New.new(["./test/test_game"], {})
        Dir.chdir "./test/test_game" do
          File.open("game.rb", "w") { _1.write "require 'other_file'" }
          File.open("other_file.rb", "w") { _1.write "Other file content" }

          squash_command = Taylor::Commands::Squash.new(["--stdout"], {})
          assert_equal squash_command.puts_data, <<~RUBY
            # Start game.rb
            # Start ./other_file.rb
            Other file content
            # End ./other_file.rb
            # End game.rb
          RUBY
        end
      ensure
        File.delete("./test/test_game/other_file.rb")
        delete_project("./test/test_game")
      end

      def test_require_in_loop
        Taylor::Commands::New.new(["./test/test_game"], {})
        Dir.chdir "./test/test_game" do
          File.open("game.rb", "w") { _1.write "Dir.entries('mods').each { require File.join('mods', _1) }" }

          squash_command = Taylor::Commands::Squash.new(["--stdout"], {})
          assert_equal squash_command.puts_data, <<~RUBY
            # Start game.rb
            Dir.entries('mods').each { require File.join('mods', _1) }
            # End game.rb
          RUBY
        end
      ensure
        delete_project("./test/test_game")
      end

      def test_require_with_interpolation
        Taylor::Commands::New.new(["./test/test_game"], {})
        Dir.chdir "./test/test_game" do
          File.open("game.rb", "w") { _1.write "variable = 'test'\nrequire \"./vendor/\#{variable}\"" }

          squash_command = Taylor::Commands::Squash.new(["--stdout"], {})
          assert_equal squash_command.puts_data, <<~RUBY
            # Start game.rb
            variable = 'test'
            require "./vendor/\#{variable}"
            # End game.rb
          RUBY
        end
      ensure
        delete_project("./test/test_game")
      end
    end
  end
end
