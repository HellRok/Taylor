module Taylor
  # Set the working directory to the presumed root of the project.
  #
  # @example Basic usage
  #   Taylor.setup
  #
  # @return [nil]
  def self.setup
    set_working_directory(
      path: Taylor::Config.new.game_dir
    )
  end

  # Set the working directory to the path.
  #
  # @example Basic usage
  #   Taylor.set_working_directory(path: "./sub-game/")
  #
  # @param path [String]
  # @return [nil]
  def self.set_working_directory(path:)
    Dir.chdir(path)
  end
end
