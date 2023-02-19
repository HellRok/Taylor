# Is the current platform Android?
# @return [Boolean]
def android?
  # mrb_android
  # src/platform.cpp
  false
end

# Is the current platform Linux?
# @return [Boolean]
def linux?
  # mrb_linux
  # src/platform.cpp
  true
end

# Is the current platform Windows?
# @return [Boolean]
def windows?
  # mrb_windows
  # src/platform.cpp
  false
end

# Is the current platform OSX?
# @return [Boolean]
def osx?
  # mrb_osx
  # src/platform.cpp
  false
end

# Is the current platform a web browser?
# @return [Boolean]
def browser?
  # mrb_browser
  # src/platform.cpp
  false
end
