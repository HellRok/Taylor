# Camera2D is used for simply moving a viewport around.
class Camera2D
  # @return [Vector2]
  attr_reader :offset, :target

  # @return [Float]
  attr_reader :rotation, :zoom

  # Creates a new instance of Camera2D
  # @param offset [Vector2]
  # @param target [Vector2]
  # @param rotation [Float]
  # @param zoom [Float]
  # @return [Camera2D]
  def initialize(offset, target, rotation, zoom)
    # mrb_Camera2D_initialize
    # src/mruby_integration/models/camera2d.cpp
    Camera2D.new
  end

  def offset=(other)
    # src/mruby_integration/models/camera2d.cpp
    offset.x = other.x
    offset.y = other.y
    offset
  end

  def target=(other)
    # src/mruby_integration/models/camera2d.cpp
    target.x = other.x
    target.y = other.y
    target
  end

  def rotation=(rotate)
    # mrb_Camera2D_set_rotation
    # src/mruby_integration/models/camera2d.cpp
  end

  def zoom=(zoom)
    # mrb_Camera2D_set_zoom
    # src/mruby_integration/models/camera2d.cpp
  end

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    # src/mruby_integration/models/camera2d.cpp
    {
      offset: offset.to_h,
      target: target.to_h,
      rotation: rotation,
      zoom: zoom,
    }
  end

  # Draws the world through the lens of the camera
  # @yield The block that calls your rendering logic
  # @return [nil]
  def drawing(&block)
    # src/mruby_integration/models/camera2d.cpp
    nil
  end

  # Pass in a vector with world coordinates to see what that translates to in
  # the camera's viewport.
  # @param vector [Vector2]
  # @return [Vector2]
  def as_in_viewport(vector)
    # src/mruby_integration/models/camera2d.cpp
    Vector2.new
  end

  # Pass in a vector with camera viewport coordinates to see what that
  # translates to in the world.
  # @param vector [Vector2]
  # @return [Vector2]
  def as_in_world(vector)
    # src/mruby_integration/models/camera2d.cpp
    Vector2.new
  end
end

