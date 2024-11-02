# Sets the main loop for web exports.
# @param method [String]
# @return [nil]
# @raise [PlatformSpecificMethodCalledOnWrongPlatformError] If run on the wrong platform.
def set_main_loop(method)
  # mrb_set_main_loop
  # src/web.cpp
  nil
end

# Cancels the main loop for web exports.
# @return [nil]
# @raise [PlatformSpecificMethodCalledOnWrongPlatformError] If run on the wrong platform.
def cancel_main_loop(method)
  # mrb_cancel_main_loop
  # src/web.cpp
  nil
end
