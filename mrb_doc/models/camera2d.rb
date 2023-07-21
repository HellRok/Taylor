class Camera2D
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

  def rotation=(rotate)
    # mrb_Camera2D_set_rotation
    # src/mruby_integration/models/camera2d.cpp
  end

  def zoom=(zoom)
    # mrb_Camera2D_set_zoom
    # src/mruby_integration/models/camera2d.cpp
  end
end
