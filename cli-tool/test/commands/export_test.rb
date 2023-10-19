class Test
  class Commands
    class Export_Test < MTest::Unit::TestCaseWithAnalytics
      def test_help
        export_command = Taylor::Commands::Export.new(["--help"], {})
        assert_include export_command.puts_data, TAYLOR_VERSION
        assert_include export_command.puts_data, "Usage:"
        assert_include export_command.puts_data, "Options:"
      end

      def test_check_in_taylor_project_error
        original_path = Dir.pwd
        Dir.chdir("./test")

        assert_raise(RuntimeError) {
          Taylor::Commands::Export.new([], {})
        }
      ensure
        Dir.chdir(original_path)
      end

      def test_check_in_taylor_project_success
        Taylor::Commands::Export.new([], {})
        assert_true true
      rescue RuntimeError
        assert_true false
      end

      def test_create_export_directory_dry_run
        Taylor::Commands::Export.new(["--dry-run"], {})
        assert_false Dir.exist?("./exports")
      end

      def test_create_export_directory_default
        Taylor::Commands::Export.new([], {})
        assert_true Dir.exist?("./exports")
      ensure
        Dir.rmdir("./exports")
      end

      def test_create_export_directory_options
        Taylor::Commands::Export.new([], {"export_directory" => "releases_option"})
        assert_false Dir.exist?("./exports")
        assert_true Dir.exist?("./releases_option")
      ensure
        Dir.rmdir("./releases_option")
      end

      def test_create_export_directory_flag
        Taylor::Commands::Export.new(["--export-directory", "releases_flag"], {})
        assert_false Dir.exist?("./exports")
        assert_true Dir.exist?("./releases_flag")
      ensure
        Dir.rmdir("./releases_flag")
      end

      def test_check_docker_command_default_dry_run
        export_command = Taylor::Commands::Export.new(["--dry-run"], {})
        assert export_command.backtick_data.nil?

        assert_include(
          export_command.puts_data,
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
            "hellrok/taylor:linux-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
        assert_include(
          export_command.puts_data,
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
            "hellrok/taylor:windows-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
        assert_include(
          export_command.puts_data,
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
            "--env EXPORT=osx/intel",
            "hellrok/taylor:osx-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
        assert_include(
          export_command.puts_data,
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
            "--env EXPORT=osx/apple",
            "hellrok/taylor:osx-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
        assert_include(
          export_command.puts_data,
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
            "hellrok/taylor:web-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
      end

      def test_check_docker_command_default
        export_command = Taylor::Commands::Export.new([], {})
        assert export_command.puts_data.nil?

        assert_equal(
          export_command.backtick_data[0],
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
            "hellrok/taylor:linux-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
        assert_equal(
          export_command.backtick_data[1],
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
            "hellrok/taylor:windows-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
        assert_equal(
          export_command.backtick_data[2],
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
            "--env EXPORT=osx/intel",
            "hellrok/taylor:osx-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
        assert_equal(
          export_command.backtick_data[3],
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
            "--env EXPORT=osx/apple",
            "hellrok/taylor:osx-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
        assert_equal(
          export_command.backtick_data[4],
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
            "hellrok/taylor:web-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
      ensure
        Dir.rmdir("exports")
      end

      def test_check_docker_command_export_directory_flag
        export_command = Taylor::Commands::Export.new(["--export-directory", "releases_flag"], {})
        skip "There's a bug in mruby-tiny-opt-parser"
        assert_equal(
          export_command.backtick_data[0],
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "releases_flag")},target=/app/game/exports",
            "hellrok/taylor:linux-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
      ensure
        begin
          Dir.rmdir("releases_flag")
        rescue
          nil
        end
      end

      def test_check_docker_command_export_directory_option
        export_command = Taylor::Commands::Export.new([], {"export_directory" => "releases_option"})
        assert_equal(
          export_command.backtick_data[0],
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "releases_option")},target=/app/game/exports",
            "hellrok/taylor:linux-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
      ensure
        Dir.rmdir("releases_option")
      end

      def test_check_docker_command_export_targets_options
        export_command = Taylor::Commands::Export.new([], {"export_targets" => "linux,web"})

        assert_equal(export_command.backtick_data.size, 2)
        assert_equal(
          export_command.backtick_data[0],
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
            "hellrok/taylor:linux-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
        assert_equal(
          export_command.backtick_data[1],
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
            "hellrok/taylor:web-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
      ensure
        Dir.rmdir("exports")
      end

      def test_check_docker_command_export_targets_flag
        export_command = Taylor::Commands::Export.new(["--export-targets", "linux,web"], {})
        skip "There's a bug in mruby-tiny-opt-parser"

        assert_equal(export_command.backtick_data.size, 2)
        assert_equal(
          export_command.backtick_data[0],
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
            "hellrok/taylor:linux-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
        assert_equal(
          export_command.backtick_data[1],
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
            "hellrok/taylor:web-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
      ensure
        begin
          Dir.rmdir("exports")
        rescue
          nil
        end

        # This is due to the bug, can be removed once fixed
        begin
          Dir.rmdir("linux,web")
        rescue
          nil
        end
      end

      def test_check_docker_command_set_build_cache_dry_run
        export_command = Taylor::Commands::Export.new(["--dry-run", "--build-cache", "build_cache"], {})

        assert_false Dir.exist?("./build_cache")
        assert_true export_command.backtick_data.nil?
      end

      def test_check_docker_command_set_build_cache
        export_command = Taylor::Commands::Export.new(["--build-cache", "build_cache_flag"], {})

        assert_true Dir.exist?("./build_cache_flag")
        assert_equal(
          export_command.backtick_data[0],
          [
            "docker run",
            "-u $(id -u ${USER}):$(id -g ${USER})",
            "--mount type=bind,source=#{Dir.pwd},target=/app/game",
            "--mount type=bind,source=#{File.join(Dir.pwd, "exports")},target=/app/game/exports",
            "--mount type=bind,source=#{File.join(Dir.pwd, "build_cache_flag")},target=/app/taylor/build/",
            "hellrok/taylor:linux-v#{TAYLOR_VERSION}"
          ].join(" ")
        )
      ensure
        Dir.rmdir("build_cache_flag")
        Dir.rmdir("exports")
      end
    end
  end
end
