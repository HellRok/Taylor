class Gesture
  # Enable only specific gestures for detection. By default all gestures are enabled.
  #
  # @example Basic usage
  #   Gesture.enabled = GESTURE_TAP | GESTURE_SWIPE_UP
  #
  # @param flags [Integer]
  # @return [nil]
  def self.enabled=(gestures)
    # mrb_Gesture_set_enabled
    # src/mruby_integration/models/gestures.cpp
    nil
  end
end
