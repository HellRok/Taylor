require "local_ci"

LocalCI::Rake.setup(self)

def ruby_files
  files = ENV["RUBY_FILES"]&.split
  files || `git ls-files --no-deleted $(find . -name "Rakefile") *.rb *.rake`.lines.map(&:chomp)
end

def xpp_files
  files = ENV["XPP_FILES"]&.split
  files || `git ls-files --no-deleted *.cpp *.hpp`.lines.map(&:chomp)
end

setup do
  job "Clean", "bundle exec rake clean"
end

flow "Documentation" do
  job "Test", "bin/test-documentation"
end

flow "Formatting" do
  setup do
    job "Ephemeral Files", "bundle exec rake setup_ephemeral_files"
  end

  job "Standard" do
    run "bundle exec standardrb", *ruby_files
  end

  job "Clang Format" do
    run "clang-format", "--dry-run", "-Werror", *xpp_files
  end
end

flow "Linting" do
  setup do
    job "Ephemeral Files", "bundle exec rake setup_ephemeral_files"
  end

  xpp_files
    .each_slice(10)
    .with_index do |batch, i|
      job "Chunk ##{i + 1}" do
        run [
          "clang-tidy",
          "--warnings-as-errors=*",
          *batch,
          "--",
          "-std=c++17",
          "-I ./include/",
          "-I ./vendor/",
          "-I ./vendor/raylib/include/",
          "-I ./vendor/mruby/"
        ].join(" ")
      end
    end
end

flow "Testing" do
  setup do
    job "Build Taylor - Linux", "MOCK_RAYLIB=1 bundle exec rake linux:release:build"
    job "Build Taylor - Windows", "MOCK_RAYLIB=1 bundle exec rake windows:release:build" if local?
  end

  teardown do
    job "Clean", "bundle exec rake clean"
  end

  job "CLI Tests" do
    run "cd cli-tool && ../dist/linux/release/taylor", "./cli.rb", "test/test.rb"
    run ".buildkite/scripts/tests/upload_test_analytics.sh cli-tool/test-analytics.json $CLI_TEST_ANALYTICS_KEY" if ci?
  end

  if local?
    job "Linux Taylor Tests" do
      run "cd test && ../dist/linux/release/taylor", "../cli-tool/cli.rb", "test.rb"
    end

    job "Windows Taylor Tests" do
      run "cd test && wine ../dist/windows/release/taylor.exe", "../cli-tool/cli.rb", "test.rb"
    end
  end
end

flow "Docker Images", parallel: false do
  setup do
    job "Build Base Image", "bundle exec rake docker:build:export:base"
  end

  job "Build Android Image", "bundle exec rake docker:build:export:android"
  job "Build Linux Image", "bundle exec rake docker:build:export:linux"
  job "Build OSX Image", "bundle exec rake docker:build:export:osx"
  job "Build Windows Image", "bundle exec rake docker:build:export:windows"
  job "Build Web Image", "bundle exec rake docker:build:export:web"
end

flow "Export Test" do
  taylor_dir = Dir.pwd
  tmp_dir = Dir.mktmpdir("taylor-")

  setup do
    job "Export Test Suite" do
      run "cp -r test #{tmp_dir}"
      run "bundle exec rake linux:release:build"
      run(
        "cd #{tmp_dir}/test && #{taylor_dir}/dist/linux/release/taylor",
        "#{taylor_dir}/cli-tool/cli.rb",
        "export",
        "--export-directory",
        tmp_dir
      )
    end
  end

  job "Linux" do
    run "mkdir -p #{tmp_dir}/linux"
    run "cd #{tmp_dir}/linux && unzip ../*-linux-*.zip"
    run "#{tmp_dir}/linux/taylor-test-suite"
    run ".buildkite/scripts/tests/upload_test_analytics.sh #{File.join(tmp_dir, "linux", "test-analytics.json")} $LINUX_TEST_ANALYTICS_KEY" if ci?
  end

  job "Windows" do
    run "mkdir -p #{tmp_dir}/windows"
    run "cd #{tmp_dir}/windows && unzip ../*-windows-*.zip"
    run "wine #{tmp_dir}/windows/taylor-test-suite.exe"
    run ".buildkite/scripts/tests/upload_test_analytics.sh #{File.join(tmp_dir, "windows", "test-analytics.json")} $WINDOWS_TEST_ANALYTICS_KEY" if ci?
  end

  job "Web" do
    run "mkdir -p #{tmp_dir}/web"
    run "cd #{tmp_dir}/web && unzip ../*-web-*.zip"
    run "cd #{tmp_dir}/web && #{File.join(taylor_dir, ".buildkite", "scripts", "tests", "web_test.rb")}"
    run ".buildkite/scripts/tests/upload_test_analytics.sh #{File.join(tmp_dir, "web", "test-analytics.json")} $WEB_TEST_ANALYTICS_KEY" if ci?
  end
end
