VARIANTS = %w[debug release]

PLATFORMS = %w[linux windows osx/intel osx/apple web android]
VERSION = File.read("./include/version.hpp").each_line.to_a.last.split('"')[1]

def ephemeral_files_for_ruby
  Rake::FileList["#{SRC_FOLDER}/**/*.cpp"].flat_map { |file|
    File.read(file)
      .lines
      .map(&:strip)
      .select { |line| line.start_with?("#include") }
      .map { |line| line.split('"').last }
      .select { |line| line.start_with?("ruby") }
  }
end

SRC_FOLDER = "src"

def source_for(o_file)
  Builder.base.source_files.detect { |file|
    file.ext("").gsub(SRC_FOLDER, "") == o_file.ext("").gsub(/^build\/(#{PLATFORMS.join("|")})\/(#{VARIANTS.join("|")})/, "")
  }
end

def write_hpp_file(hpp_file)
  write_if_changed_or_new("include/#{hpp_file}", <<~HPP)
    #pragma once
    #include "mruby.h"

    void load_#{hpp_file.ext.split("/").join("_")}(mrb_state*);
  HPP
end

def write_cpp_file(hpp_file, cpp_file, ruby_code)
  write_if_changed_or_new(cpp_file, <<~CPP)
    #include "mruby/compile.h"

    void load_#{hpp_file.ext.split("/").join("_")}(mrb_state *mrb) {
      mrb_load_string(mrb, R"RUBY(
        #{ruby_code}
      )RUBY");
    }
  CPP
end

def write_if_changed_or_new(file, data)
  if File.exist?(file)
    File.write(file, data) unless File.read(file) == data
  else
    File.write(file, data)
  end
end
