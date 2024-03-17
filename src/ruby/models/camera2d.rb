# {Camera2D} is used for drawing the world through a viewport.
#
# TODO: A full code example
class Camera2D
  # @return [Vector2]
  attr_reader :offset, :target

  # @return [Float]
  attr_reader :rotation, :zoom

  # Update the x and y values of the offset to match the passed in [Vector2].
  # @param other [Vector2]
  # @return [Vector2]
  def offset=(other)
    offset.x = other.x
    offset.y = other.y
    offset
  end

  # Update the x and y values of the target to match the passed in [Vector2].
  # @param other [Vector2]
  # @return [Vector2]
  def target=(other)
    target.x = other.x
    target.y = other.y
    target
  end

  # Return the object represented by a Hash.
  # @return [Hash]
  def to_h
    {
      offset: offset.to_h,
      target: target.to_h,
      rotation: rotation,
      zoom: zoom
    }
  end
end
