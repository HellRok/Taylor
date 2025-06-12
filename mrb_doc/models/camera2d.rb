class Camera2D
  # @return [Float]
  attr_writer :rotation, :zoom

  # Creates a new instance of {Camera2D}.
  #
  # @example Basic usage
  #   player = Vector2[400, 240]
  #
  #   camera = Camera2D.new(offset: player)
  #
  #   player.x = 200
  #   player.y = 120
  #
  #   camera.offset = player
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

  # Draws the world through the lens of the {Camera2D}.
  #
  # @example Basic usage
  #   rectangle = Rectangle[100, 100, 50, 50]
  #   camera = Camera2D.new(offset: Vector2[100, 150])
  #
  #   camera.draw do
  #       rectangle.draw(colour: RED)
  #   end
  #
  # @yield The block that calls your rendering logic.
  # @return [nil]
  def draw(&block)
    # mrb_Camera2D_set_zoom
    # src/mruby_integration/models/camera2d.cpp
    nil
  end

  # Pass in a vector with world coordinates to see what that translates to in
  # the camera's viewport.
  #
  # @example Basic usage
  #   camera = Camera2D.new(target: Vector2[2, 1], offset: Vector2[3, 2])
  #   vector = Vector2[3, 3]
  #
  #   translated_vector = camera.as_in_viewport(vector)
  #   puts translated_vector.x # => 4
  #   puts translated_vector.y # => 4
  #
  # @param vector [Vector2]
  # @return [Vector2]
  def as_in_viewport(vector)
    # mrb_Camera2D_as_in_viewport
    # src/mruby_integration/models/camera2d.cpp
    Vector2[2, 2]
  end

  # Pass in a vector with screen coordinates to see what that translates to in
  # the world from camera's viewport.
  #
  # @example Basic usage
  #   camera = Camera2D.new(target: Vector2[2, 1], offset: Vector2[3, 2])
  #   vector = Vector2[4, 4]
  #
  #   translated_vector = camera.as_in_world(vector)
  #   puts translated_vector.x # => 3
  #   puts translated_vector.y # => 3
  #
  # @param vector [Vector2]
  # @return [Vector2]
  def as_in_world(vector)
    # mrb_Camera2D_as_in_world
    # src/mruby_integration/models/camera2d.cpp
    Vector2[2, 2]
  end
end
