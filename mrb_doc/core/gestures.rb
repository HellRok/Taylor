# Enable only specific gestures.
# @example Passing multiple flags.
#   set_gestures_enabled(GESTURE_TAP | GESTURE_SWIPE_UP)
# @param flags [Integer]
# @return [nil]
def set_gestures_enabled(flags)
  # mrb_set_gestures_enabled
  # src/mruby_integration/core/gestures.cpp
  nil
end

# Returns the detected gestures based on their constant.
# @return [Integer]
def get_gesture_detected
  # mrb_get_gesture_detected
  # src/mruby_integration/core/gestures.cpp
  GESTURE_TAP
end
