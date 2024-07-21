class Mouse
  # Returns true the frame after the {Mouse} button has been pressed, but will
  # return false for the following frames until the button is re-pressed.
  #
  # @example Basic usage
  #   puts Mouse.pressed?(Mouse::LEFT) #=> false
  #
  #   # User holds down their left mouse button
  #   puts Mouse.pressed?(Mouse::LEFT) #=> true
  #
  #   # One frame passes, left mouse button still held down
  #   puts Mouse.pressed?(Mouse::LEFT) #=> false
  #
  # @param button [Integer]
  # @return [Boolean]
  def self.pressed?
    # mrb_Mouse_pressed?
    # src/mruby_integration/models/mouse.cpp
    true
  end
end
