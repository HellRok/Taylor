VARIANTS = %w[debug release]

PLATFORMS = %w[linux windows osx/intel osx/apple web android]
VERSION = File.read("./include/version.hpp").each_line.to_a.last.split('"')[1]

def ephemeral_files_for_ruby
  Rake::FileList["#{SRC_FOLDER}/**/*.cpp"].flat_map { |file|
    File.read(file)
      .lines
      .map(&:strip)
      .select { _1.start_with?("#include") }
      .map { _1.split('"').last }
      .select { _1.start_with?("ruby") }
  }
end

SRC_FOLDER = "src"
SRC = (
  Rake::FileList["#{SRC_FOLDER}/**/*.cpp"] +
  ephemeral_files_for_ruby.map { "src/#{_1.ext(".cpp")}" }
).uniq

def source_for(o_file)
  SRC.detect { |file|
    file.ext("").gsub(SRC_FOLDER, "") == o_file.ext("").gsub(/^build\/(#{PLATFORMS.join('|')})\/(#{VARIANTS.join('|')})/, "")
  }
end

def objects(objects_folder)
  SRC.ext(".o").map { |file| file.gsub(SRC_FOLDER, objects_folder) }
end

def depends(objects_folder)
  SRC.ext(".mf").map { |file| file.gsub(SRC_FOLDER, objects_folder) }
end

def write_hpp_file(hpp_file)
  write_if_changed_or_new("include/#{hpp_file}", <<~HPP)
    #pragma once

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
