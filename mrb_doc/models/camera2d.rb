class Camera2D
  # Creates a new instance of {Camera2D}.
  #
  # ```ruby
  # player = Vector2[400, 240]
  #
  # camera = Camera2D.new(offset: player)
  #
  # player.x = 200
  # player.y = 120
  #
  # camera.offset = player
  # ```
  #
  # @param offset [Vector2]
  # @param target [Vector2]
  # @param rotation [Float]
  # @param zoom [Float]
  # @return [Camera2D]
  def initialize(target: Vector2[0, 0], offset: Vector2[0, 0], rotation: 0, zoom: 1)
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
