class DroppedFiles
  # Have there been files dropped that haven't been dealt with?
  #
  # @example Basic usage
  #   if DroppedFiles.any?
  #     deal_with_files(DroppedFiles.all)
  #   end
  #
  # @return [Boolean]
  def self.any?
    # mrb_DroppedFiles_any
    # src/mruby_integration/model/dropped_files.cpp
    true
  end

  # Return an array of the files that were last dropped on the window, will
  # return an empty array if no files have been dropped since the program started
  # or this method was last called.
  #
  # @example Basic usage
  #   if DroppedFiles.any?
  #     deal_with_files(DroppedFiles.all)
  #   end
  #
  # @return [Array<String>]
  def self.all
    # mrb_DroppedFiles_all
    # src/mruby_integration/model/dropped_files.cpp
    [
      "/home/taylor/Gemfile",
      "/home/taylor/src/main.cpp",
      "/home/taylor/README.md"
    ]
  end
end
