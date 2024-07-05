require "json"
require "fileutils"
require "rake/clean"
require "rake/loaders/makefile"

CLEAN.include("./build/*")
CLEAN.include("./dist/*")
CLEAN.include("./releases/*")
CLEAN.include("./src/ruby/**/*.cpp")
CLEAN.include("./include/ruby")

task default: "linux:build"

require_relative "rakelib/helpers"

ephemeral_files_for_ruby.each do |file|
  task file do
    FileUtils.mkdir_p("include/#{File.dirname(file)}")

    cpp_file = "src/#{file.ext}.cpp"
    ruby_code = File.read("src/#{file.ext}.rb")

    write_hpp_file(file)
    write_cpp_file(file, cpp_file, ruby_code)
  end
end

multitask setup_ephemeral_files: ephemeral_files_for_ruby

task "lint:check" => [:setup_ephemeral_files] do
  sh Builder.builders["linux"].lint
end

task "lint:fix" => [:setup_ephemeral_files] do
  sh Builder.builders["linux"].lint(fix: true)
end

task "format:check" do
  sh "clang-format --dry-run -Werror $(git ls-files *.cpp)"
  sh "clang-format --dry-run -Werror $(git ls-files *.hpp)"
end

task "format:fix" do
  sh "echo $(git ls-files *.{cpp,hpp}) | clang-format"
end

task pretty: ["format:fix", "lint:fix"] do
  # I do this because loading the gem breaks a lot of the build and I don't
  # want to add ruby-dev everywhere.
  sh "bundle exec standardrb --fix"
end

rule ".o" => ->(file) { source_for(file) } do |task|
  FileUtils.mkdir_p(File.dirname(task.name))
  sh Builder.o_command_for(task)
end

rule ".mf" => ->(file) { source_for(file) } do |task|
  data = `#{Builder.mf_command_for(task)}`

  file, deps = data.split(":")
  deps = deps.split.select { |dep| File.exist? dep }

  Rake::Task[file].enhance deps
end

PLATFORMS.each { |platform|
  VARIANTS.each { |variant|
    task "build:#{platform}:#{variant}" do |task|
      FileUtils.mkdir_p("./dist/#{platform}/#{variant}")
      Builder.builders[platform].variant = variant
      sh Builder.builders[platform].compile
    end
  }
}
