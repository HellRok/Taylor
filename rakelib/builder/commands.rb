class Builder
  module Commands
    def objects_folder(variant = nil)
      "build/#{@platform}/#{variant || @variant}"
    end

    def objects(variant = nil)
      Builder.base.source_files.ext(".o").map { |file| file.gsub(SRC_FOLDER, objects_folder(variant)) }
    end

    def depends(variant = nil)
      Builder.base.source_files.ext(".mf").map { |file| file.gsub(SRC_FOLDER, objects_folder(variant)) }
    end

    def source_files
      return @source_files if @source_files

      @source_files = (
        Rake::FileList["#{SRC_FOLDER}/**/*.cpp"] +
        ephemeral_files_for_ruby.map { |file| "src/#{file.ext(".cpp")}" }
      ).uniq

      if mock_raylib?
        @source_files += Rake::FileList["src/raylib.cpp"]
      else
        @source_files -= Rake::FileList["src/raylib.cpp"]
      end

      # uniq! is for some reason returning nil?
      @source_files = @source_files.uniq
    end

    def generate_mf_for(task)
      <<-CMD.squeeze(" ").strip
      #{@cxx} #{@cxxflags} #{includes} #{defines} -c #{task.source} \
        #{@ldflags} \
        -MM \
        -MT #{task.name.gsub(SRC_FOLDER, objects_folder).ext(".o")}
      CMD
    end

    def generate_o_for(task)
      <<-CMD.squeeze(" ").strip
    #{@cxx} #{@cxxflags} #{includes} #{defines} -c #{task.source} \
      -o #{task.name} \
      #{@ldflags}
      CMD
    end

    def compile
      <<-CMD.squeeze(" ").strip
      #{@cxx} \
        -o "./dist/#{@platform}/#{@variant}/#{name}" \
        #{@cxxflags} \
        #{(variant == "release") ? @release_optimisation : @debug_optimisation} \
        #{defines} \
        #{includes} \
        #{objects.join " "} \
        #{static_links} \
        #{@ldflags}
      CMD
    end
  end

  include Commands
end
