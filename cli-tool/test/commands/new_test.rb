class Test
  class Commands
    class New_Test < MTest::Unit::TestCaseWithAnalytics
      def test_help
        new_command = Taylor::Commands::New.new(['--help'], {})
        assert_include new_command.puts_data, TAYLOR_VERSION
        assert_include new_command.puts_data, 'Usage:'
        assert_include new_command.puts_data, 'Options:'
      end

      def test_create_directory_already_exist
        assert_raise(RuntimeError) {
          Taylor::Commands::New.new(['./test'], {})
        }
      end

      def test_create_directory_success
        Taylor::Commands::New.new(['./test/folder_test_game'], {})
        assert_true Dir.exists?('./test/folder_test_game')
      ensure
        delete_project('./test/folder_test_game')
      end

      def test_create_directory_by_name_success
        Taylor::Commands::New.new(['--name', './test/test_game'], {})
        assert_true Dir.exists?('./test/test_game')
      ensure
        delete_project('./test/test_game')
      end

      def test_create_config_defaults
        Taylor::Commands::New.new([], {})
        data = JSON.parse(File.read('./taylor_game/taylor-config.json'))
        assert_equal 'taylor_game', data['name']
        assert_equal 'v0.0.1', data['version']
        assert_equal 'game.rb', data['input']
        assert_true File.exists?('./taylor_game/game.rb')
        assert_equal './exports', data['export_directory']
        assert_equal ['linux', 'windows', 'osx/intel', 'osx/apple', 'web'], data['export_targets']
        assert_equal ['./', './vendor'], data['load_paths']
        assert_true Dir.exists?('./taylor_game/vendor')
        assert_true File.exists?('./taylor_game/vendor/.keep')
        assert_equal ['./assets'], data['copy_paths']
        assert_true Dir.exists?('./taylor_game/assets')
        assert_true File.exists?('./taylor_game/assets/.keep')
      ensure
        delete_project('./taylor_game')
      end

      def test_create_config_overrides
        Taylor::Commands::New.new(
          [
            '--name', './test/test_game',
            '--version', 'final_v2_for_real',
            '--input', 'app.rb',
            '--export_directory', './releases',
            '--export_targets', 'web,windows',
            '--load_paths', './,./third_party',
            '--copy_paths', './resources,./music',
          ],
          {}
        )

        data = JSON.parse(File.read('./test/test_game/taylor-config.json'))
        assert_equal './test/test_game', data['name']
        assert_equal 'final_v2_for_real', data['version']
        assert_equal 'app.rb', data['input']
        assert_true File.exists?('./test/test_game/app.rb')
        assert_equal './releases', data['export_directory']
        assert_equal ['web', 'windows'], data['export_targets']
        assert_equal ['./', './third_party'], data['load_paths']
        assert_true Dir.exists?('./test/test_game/third_party')
        assert_true File.exists?('./test/test_game/third_party/.keep')
        assert_equal ['./resources', './music'], data['copy_paths']
        assert_true Dir.exists?('./test/test_game/resources')
        assert_true File.exists?('./test/test_game/resources/.keep')
        assert_true Dir.exists?('./test/test_game/music')
        assert_true File.exists?('./test/test_game/music/.keep')
      ensure
        File.delete(File.join('test', 'test_game', 'app.rb'))
        File.delete(File.join('test', 'test_game', 'taylor-config.json'))
        File.delete(File.join('test', 'test_game', 'music', '.keep'))
        Dir.rmdir(File.join('test', 'test_game', 'music'))
        File.delete(File.join('test', 'test_game', 'resources', '.keep'))
        Dir.rmdir(File.join('test', 'test_game', 'resources'))
        File.delete(File.join('test', 'test_game', 'third_party', '.keep'))
        Dir.rmdir(File.join('test', 'test_game', 'third_party'))
        Dir.rmdir(File.join('test', 'test_game'))
      end

      def test_setup_game_structure_defaults
        Taylor::Commands::New.new(['--name', './test/test_game'], {})
        data = File.read('./test/test_game/game.rb').lines
        assert_equal "$: << './vendor'\n", data[1]
        assert_equal "init_window(800, 480, \"./test/test_game\")\n", data[4]
      ensure
        delete_project('./test/test_game')
      end

      def test_setup_game_structure_overrides
        Taylor::Commands::New.new(
          [
            '--name', './test/test_game_the_sequel',
            '--load_paths', './,./third_party,./black_box',
          ],
          {}
        )
        data = File.read('./test/test_game_the_sequel/game.rb').lines
        assert_equal "$: << './third_party'\n", data[1]
        assert_equal "$: << './black_box'\n", data[2]
        assert_equal "init_window(800, 480, \"./test/test_game_the_sequel\")\n", data[5]
      ensure
        File.delete(File.join('./test', 'test_game_the_sequel', 'game.rb'))
        File.delete(File.join('./test', 'test_game_the_sequel', 'taylor-config.json'))
        File.delete(File.join('./test', 'test_game_the_sequel', 'assets', '.keep'))
        Dir.rmdir(File.join('./test', 'test_game_the_sequel', 'assets'))
        File.delete(File.join('./test', 'test_game_the_sequel', 'third_party', '.keep'))
        Dir.rmdir(File.join('./test', 'test_game_the_sequel', 'third_party'))
        File.delete(File.join('./test', 'test_game_the_sequel', 'black_box', '.keep'))
        Dir.rmdir(File.join('./test', 'test_game_the_sequel', 'black_box'))
        Dir.rmdir(File.join('./test', 'test_game_the_sequel'))
      end
    end
  end
end
