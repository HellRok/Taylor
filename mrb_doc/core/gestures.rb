# When no gesture has happened
GESTURE_NONE        = 0
# When the tap gesture was triggered
GESTURE_TAP         = 1
# When the doubletap was triggered
GESTURE_DOUBLETAP   = 2
# When the hold was triggered
GESTURE_HOLD        = 4
# When the drag was triggered
GESTURE_DRAG        = 8
# When the swipe_right was triggered
GESTURE_SWIPE_RIGHT = 16
# When the swipe_left was triggered
GESTURE_SWIPE_LEFT  = 32
# When the swipe_up was triggered
GESTURE_SWIPE_UP    = 64
# When the swipe_down was triggered
GESTURE_SWIPE_DOWN  = 128
# When the pinch_in was triggered
GESTURE_PINCH_IN    = 256
# When the pinch_out was triggered
GESTURE_PINCH_OUT   = 512

# Enable only specific gestures, to pass in multiple you can do so like:
#   `set_gestures_enabled(GESTURE_TAP | GESTURE_SWIPE_UP)`
# @param flags [Integer]
# @return [nil]
def set_gestures_enabled(flags)
  # mrb_set_gestures_enabled
  # src/mruby_integration/core/gestures.cpp
  nil
end

# Returns the detected gestures based on their constant
# @return [Integer]
def get_gestures_detected()
  # mrb_get_gesture_detected
  # src/mruby_integration/core/gestures.cpp
  GESTURE_TAP
end
