class TestCommandsExport < MTest::Unit::TestCase
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

  def test_check_in_taylor_project_success
    export_command = Taylor::Commands::Export.new(['--dry-run'], {})
    assert_include export_command.puts_data, 'docker run'
    assert_include export_command.puts_data, Dir.pwd
    assert_include export_command.puts_data, "hellrok/taylor:v#{TAYLOR_VERSION}"
  end
end
