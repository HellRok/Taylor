class Touch
  # Returns the {Touch} position for that index.
  #
  # @example Basic usage
  #   puts Touch.position_for(0)
  #   # => Vector2[123, 345]
  #
  # @return [Vector2]
  def self.position_for(index)
    # mrb_Touch_position_for
    # src/mruby_integration/models/touch.cpp
    Vector2[123, 345]
  end
end
