require "json"
require "fileutils"
require "rake/clean"
require 'rake/loaders/makefile'


CLEAN.include("./build/*")
CLEAN.include("./dist/*")
CLEAN.include("./releases/*")

task :default => "linux:build"

require_relative 'rakelib/helpers.rb'

rule ".o" => ->(file){ source_for(file) } do |task|
  FileUtils.mkdir_p(File.dirname(task.name))
  sh Builder.o_command_for(task)
end

rule ".mf" => ->(file){ source_for(file) } do |task|
  data = `#{Builder.mf_command_for(task)}`

  file, deps = data.split(':')
  deps = deps.split.select{ |dep| File.exist? dep }

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
