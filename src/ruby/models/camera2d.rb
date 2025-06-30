# {Camera2D} is used for drawing the world through a viewport.
#
# TODO: A full code example
class Camera2D
  # @note If you access the instance variable `@offset` directly and assign it
  #   to a different variable, it will be corrupted when Ruby cleans up the
  #   memory of the parent {Camera2D} object.
  #
  # Returns {Camera2D#offset}.
  #
  # @return [Vector2]
  def offset = @offset # standard:disable Style/TrivialAccessors

  # Update the {Vector2#x} and {Vector2#y} values of the offset to match the
  # passed in {Vector2}.
  # @param other [Vector2]
  # @return [Vector2]
  def offset=(other)
    @offset.x = other.x
    @offset.y = other.y
    offset
  end

  # @note If you access the instance variable `@target` directly and assign it
  #   to a different variable, it will be corrupted when Ruby cleans up the
  #   memory of the parent {Camera2D} object.
  #
  # Returns {Camera2D#target}.
  #
  # @return [Vector2]
  def target = @target # standard:disable Style/TrivialAccessors

  # Update the {Vector2#x} and {Vector2#y} values of the target to match the
  # passed in {Vector2}.
  # @param other [Vector2]
  # @return [Vector2]
  def target=(other)
    @target.x = other.x
    @target.y = other.y
    target
  end

  # Return the object represented by a Hash.
  # @return [Hash]
  def to_h
    {
      offset: @offset.to_h,
      target: @target.to_h,
      rotation: rotation,
      zoom: zoom
    }
  end
end
