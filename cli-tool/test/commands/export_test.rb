class Test
  class Commands
    class Export_Test < MTest::Unit::TestCaseWithAnalytics
      def test_help
        export_command = Taylor::Commands::Export.new(['--help'], {})
        assert_include export_command.puts_data, TAYLOR_VERSION
        assert_include export_command.puts_data, 'Usage:'
        assert_include export_command.puts_data, 'Options:'
      end

      def test_check_in_taylor_project_error
        original_path = Dir.pwd
        Dir.chdir('./test')

        assert_raise(RuntimeError) {
          Taylor::Commands::Export.new(['--dry-run'], {})
        }

      ensure
        Dir.chdir(original_path)
      end

      def test_check_in_taylor_project_success
        Taylor::Commands::Export.new(['--dry-run'], {})
        assert_true true
      rescue RuntimeError
        assert_true false
      end

      def test_create_export_folder_dry_run
        Taylor::Commands::Export.new(['--dry-run'], {})
        assert_false Dir.exists?('./exports')
      end

      def test_create_build_cache_folder
        Taylor::Commands::Export.new(['--dry-run'], { 'build_cache' => '/tmp/build/' })
        assert_false Dir.exists?('./exports')
      end

      def test_check_docker_command_default_options
        export_command = Taylor::Commands::Export.new(['--dry-run'], {})
        assert_include export_command.puts_data, 'docker run'
        assert_include export_command.puts_data, File.join(Dir.pwd, 'exports')
        assert_include export_command.puts_data, "hellrok/taylor:linux-v#{TAYLOR_VERSION}"
        assert_include export_command.puts_data, "hellrok/taylor:windows-v#{TAYLOR_VERSION}"
        assert_include export_command.puts_data, "hellrok/taylor:osx-v#{TAYLOR_VERSION}"
        assert_include export_command.puts_data, "hellrok/taylor:web-v#{TAYLOR_VERSION}"
      end

      def test_check_docker_command_override_export_directory
        export_command = Taylor::Commands::Export.new(['--dry-run'], { 'export_directory' => '/tmp/exports' })
        assert_include export_command.puts_data, 'docker run'
        assert_include export_command.puts_data, '/tmp/exports'
        assert_include export_command.puts_data, "hellrok/taylor:linux-v#{TAYLOR_VERSION}"
        assert_include export_command.puts_data, "hellrok/taylor:windows-v#{TAYLOR_VERSION}"
        assert_include export_command.puts_data, "hellrok/taylor:osx-v#{TAYLOR_VERSION}"
        assert_include export_command.puts_data, "hellrok/taylor:web-v#{TAYLOR_VERSION}"
      end

      def test_check_docker_command_override_targets
        export_command = Taylor::Commands::Export.new(['--dry-run'], { 'export_targets' => 'linux,web' })
        assert_include export_command.puts_data, 'docker run'
        assert_include export_command.puts_data, File.join(Dir.pwd, 'exports')
        assert_include export_command.puts_data, "hellrok/taylor:linux-v#{TAYLOR_VERSION}"
        assert_false export_command.puts_data.include? "hellrok/taylor:windows-v#{TAYLOR_VERSION}"
        assert_false export_command.puts_data.include?  "hellrok/taylor:osx-v#{TAYLOR_VERSION}"
        assert_include export_command.puts_data, "hellrok/taylor:web-v#{TAYLOR_VERSION}"
      end

      def test_check_docker_command_set_build_cache
        # Because this isn't specified by the taylor-config.json we have to pass it
        # in via the ARGV
        export_command = Taylor::Commands::Export.new(['--dry-run', '--build_cache', '/tmp/build'], {})
        assert_include export_command.puts_data, 'docker run'
        assert_include export_command.puts_data, File.join(Dir.pwd, 'exports')
        assert_include export_command.puts_data, '/tmp/build'
        assert_include export_command.puts_data, "hellrok/taylor:linux-v#{TAYLOR_VERSION}"
        assert_include export_command.puts_data, "hellrok/taylor:windows-v#{TAYLOR_VERSION}"
        assert_include export_command.puts_data, "hellrok/taylor:osx-v#{TAYLOR_VERSION}"
        assert_include export_command.puts_data, "hellrok/taylor:web-v#{TAYLOR_VERSION}"
      end
    end
  end
end
