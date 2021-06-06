# Have their been files dropped that haven't been dealt with?
# @return [nil]
def files_dropped?()
  # mrb_files_dropped
  # src/mruby_integration/core/files.cpp
  true
end

# Return an array of the files that were last dropped on the window, will
# return an empty array if no files have been dropped since the program started
# or this method was last called.
# @return [Array<String>]
def get_dropped_files()
  # mrb_get_dropped_files
  # src/mruby_integration/core/files.cpp
  [
    '/home/taylor/Gemfile',
    '/home/taylor/src/main.cpp',
    '/home/taylor/README.md',
  ]
end
