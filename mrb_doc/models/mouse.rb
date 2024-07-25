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
  def self.pressed?(button)
    # mrb_Mouse_pressed?
    # src/mruby_integration/models/mouse.cpp
    true
  end

  # Returns true if the button is being held down.
  #
  # @example Basic usage
  #   puts Mouse.down?(Mouse::LEFT) #=> false
  #
  #   # User holds down their left mouse button
  #   puts Mouse.down?(Mouse::LEFT) #=> true
  #
  #   # One frame passes, left mouse button still held down
  #   puts Mouse.down?(Mouse::LEFT) #=> true
  #
  #   # User releases the button and one frame passes
  #   puts Mouse.down?(Mouse::LEFT) #=> false
  #
  # @param button [Integer]
  # @return [Boolean]
  def self.down?(button)
    # mrb_Mouse_down?
    # src/mruby_integration/models/mouse.cpp
    true
  end

  # Returns true the frame after the {Mouse} button has been released, but will
  # return false for the following frames until the button is released again.
  #
  # @example Basic usage
  #   puts Mouse.released?(Mouse::LEFT) #=> false
  #
  #   # User releases their left mouse button
  #   puts Mouse.released?(Mouse::LEFT) #=> true
  #
  #   # One frame passes, left mouse button still released
  #   puts Mouse.released?(Mouse::LEFT) #=> false
  #
  # @param button [Integer]
  # @return [Boolean]
  def self.released?(button)
    # mrb_Mouse_released?
    # src/mruby_integration/models/mouse.cpp
    true
  end

  # Returns true if the button is not being held down.
  #
  # @example Basic usage
  #   puts Mouse.up?(Mouse::LEFT) #=> true
  #
  #   # User holds down their left mouse button
  #   puts Mouse.up?(Mouse::LEFT) #=> false
  #
  #   # One frame passes, left mouse button still held down
  #   puts Mouse.up?(Mouse::LEFT) #=> false
  #
  #   # User releases the button and one frame passes
  #   puts Mouse.up?(Mouse::LEFT) #=> true
  #
  # @param button [Integer]
  # @return [Boolean]
  def self.up?(button)
    # mrb_Mouse_up?
    # src/mruby_integration/models/mouse.cpp
    true
  end
end
