class Gesture
  # Enable only specific gestures for detection. By default all gestures are enabled.
  #
  # @example Basic usage
  #   Gesture.enabled = Gesture::TAP | Gesture::SWIPE_UP
  #
  # @param flags [Integer]
  # @return [nil]
  def self.enabled=(gestures)
    # mrb_Gesture_set_enabled
    # src/mruby_integration/models/gestures.cpp
    nil
  end

  # Returns which {Gesture} is currently happening.
  #
  # @example Basic usage
  #   gesture = Gesture.detect
  #
  #   player.x += 1 if gesture == Gesture::SWIPE_RIGHT
  #   player.x -= 1 if gesture == Gesture::SWIPE_LEFT
  #   player.y += 1 if gesture == Gesture::SWIPE_UP
  #   player.y -= 1 if gesture == Gesture::SWIPE_DOWN
  #
  # @return [Integer]
  def self.detected
    # mrb_Gesture_detected
    # src/mruby_integration/models/gestures.cpp
    Gesture::NONE
  end

  # Is this {Gesture} currently detected?
  #
  # @example Basic usage
  #   player.x += 1 if Gesture.detected? Gesture::SWIPE_RIGHT
  #   player.x -= 1 if Gesture.detected? Gesture::SWIPE_LEFT
  #   player.y += 1 if Gesture.detected? Gesture::SWIPE_UP
  #   player.y -= 1 if Gesture.detected? Gesture::SWIPE_DOWN
  #
  # @return [Integer]
  def self.detected?
    # mrb_Gesture_detected_question
    # src/mruby_integration/models/gestures.cpp
    Gesture::TAP
  end

  # Returns how long has the current {Gesture} been happening for.
  #
  # @example Basic usage
  #   puts Gesture.duration #=> 1.54
  #
  # @return [Float]
  def self.duration
    # mrb_Gesture_duration
    # src/mruby_integration/models/gestures.cpp
    1.54
  end

  # Returns how far has the {Gesture} been dragged
  #
  # @example Basic usage
  #   puts Gesture.dragged #=> Vector2[1.34, -2.44]
  #
  # @return [Vector2]
  def self.dragged
    # mrb_Gesture_dragged
    # src/mruby_integration/models/gestures.cpp
    Vector2[1.34, -2.44]
  end

  # Returns the angle of the {Gesture} drag
  #
  # This will return `0` when being dragged exactly right
  #
  # @example Basic usage
  #   puts Gesture.drag_angle #=> 178.23
  #
  # @return [Vector2]
  def self.drag_angle
    # mrb_Gesture_drag_angle
    # src/mruby_integration/models/gestures.cpp
    178.23
  end

  # Returns the distance between the two pinch points
  #
  # @example Basic usage
  #   puts Gesture.pinched #=> Vector2[1.34, -2.44]
  #
  # @return [Vector2]
  def self.pinched
    # mrb_Gesture_pinched
    # src/mruby_integration/models/gestures.cpp
    Vector2[1.34, -2.44]
  end

  # What's the angle of the {Gesture} pinch
  #
  # This will return `0` when the pinch is perfectly horizontal
  #
  # @example Basic usage
  #   puts Gesture.pinch_angle #=> 178.23
  #
  # @return [Vector2]
  def self.pinch_angle
    # mrb_Gesture_pinch_angle
    # src/mruby_integration/models/gestures.cpp
    178.23
  end
end
