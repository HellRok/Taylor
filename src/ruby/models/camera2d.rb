# Camera2D is used for simply moving a viewport around.
class Camera2D
  # @return [Vector2]
  attr_reader :offset, :target

  # @return [Float]
  attr_reader :rotation, :zoom

  # Update the x and y values of the offset to match the passed in [Vector2]
  # @param other [Vector2]
  # @return [Vector2]
  def offset=(other)
    offset.x = other.x
    offset.y = other.y
    offset
  end

  # Update the x and y values of the target to match the passed in [Vector2]
  # @param other [Vector2]
  # @return [Vector2]
  def target=(other)
    target.x = other.x
    target.y = other.y
    target
  end

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    {
      offset: offset.to_h,
      target: target.to_h,
      rotation: rotation,
      zoom: zoom
    }
  end

  # Draws the world through the lens of the camera
  # @yield The block that calls your rendering logic
  # @return [nil]
  def drawing(&block)
    begin_mode2D(self)
    block.call
  ensure
    end_mode2D
  end

  # Pass in a vector with world coordinates to see what that translates to in
  # the camera's viewport.
  # @param vector [Vector2]
  # @return [Vector2]
  def as_in_viewport(vector)
    get_world_to_screen2D(vector, self)
  end

  # Pass in a vector with camera viewport coordinates to see what that
  # translates to in the world.
  # @param vector [Vector2]
  # @return [Vector2]
  def as_in_world(vector)
    get_screen_to_world2D(vector, self)
  end
end
