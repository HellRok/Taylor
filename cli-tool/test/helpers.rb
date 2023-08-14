def delete_project(path)
  File.delete(File.join(path, "game.rb"))
  File.delete(File.join(path, "taylor-config.json"))
  File.delete(File.join(path, "assets", ".keep"))
  Dir.rmdir(File.join(path, "assets"))
  File.delete(File.join(path, "vendor", ".keep"))
  Dir.rmdir(File.join(path, "vendor"))
  Dir.rmdir(path)
end

$exited = false
def exit(status)
  $exited = true
end

def exit!(status)
  $exited = true
end
