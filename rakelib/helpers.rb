VARIANTS = %w(debug release)

PLATFORMS = %w(linux windows osx/intel osx/apple web android)
VERSION = File.read("./include/version.hpp").each_line.to_a.last.split('"')[1]

SRC_FOLDER = "src"
SRC = Rake::FileList["#{SRC_FOLDER}/**/*.cpp"]

def source_for(o_file)
  SRC.detect{ |file|
    file.ext('').gsub(SRC_FOLDER, '') == o_file.ext('').gsub(/^build\/(#{PLATFORMS.join('|')})\/(#{VARIANTS.join('|')})/, '')
  }
end

def objects(objects_folder)
  SRC.ext('.o').map { |file| file.gsub(SRC_FOLDER, objects_folder) }
end

def depends(objects_folder)
  SRC.ext('.mf').map { |file| file.gsub(SRC_FOLDER, objects_folder) }
end
