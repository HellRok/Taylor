class Test
  class Commands
    class Run_Test < MTest::Unit::TestCaseWithAnalytics
      def test_help
        export_command = Taylor::Commands::Run.new("./cli.rb", ["--help"], {})
        assert_include export_command.puts_data, TAYLOR_VERSION
        assert_include export_command.puts_data, "Usage:"
        assert_include export_command.puts_data, "Options:"
      end

      def test_unload_taylor_cli
        $removed_const = nil
        Taylor::Commands::Run.new("./cli.rb", [], {})
        assert_equal :Commands, $removed_const
      ensure
        $removed_const = nil
      end

      def test_requires_the_command
        File.open("./test/app.rb", "w") { |io| io.write "puts :hi" }

        run_command = Taylor::Commands::Run.new("./test/app.rb", [], {})
        assert_equal ["./test/app.rb"], run_command.require_list
      ensure
        File.delete("./test/app.rb")
      end

      def test_requires_from_config
        run_command = Taylor::Commands::Run.new(nil, [], {"input" => "./cli.rb"})
        assert_equal ["./cli.rb"], run_command.require_list
      end

      def test_exits_for_invalid_command
        Taylor::Commands::Run.new("./nonexistant.rb", [], {})

        assert $exited
      ensure
        $exited = false
      end
    end
  end
end
