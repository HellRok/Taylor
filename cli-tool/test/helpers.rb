def delete_project(path)
  delete_dir(path)
end

def delete_dir(dir)
  Dir.entries(dir).each do |file|
    next if (file == ".") || (file == "..")
    full_path = File.join(dir, file)

    if Dir.exist?(full_path)
      delete_dir(full_path)
    elsif File.exist?(full_path)
      File.delete(full_path)
    else
      raise "Could not find '#{full_path}'"
    end
  end

  Dir.rmdir(dir)
end
