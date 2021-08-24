def delete_project(path)
  File.delete(File.join(path, 'game.rb'))
  File.delete(File.join(path, 'taylor-config.json'))
  Dir.rmdir(File.join(path, 'assets'))
  Dir.rmdir(File.join(path, 'vendor'))
  Dir.rmdir(path)
end
