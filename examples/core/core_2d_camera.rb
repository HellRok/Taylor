# Adapted from https://github.com/raysan5/raylib/blob/master/examples/core/core_2d_camera.c

MAX_BUILDINGS = 100

# Initialization
screen_width = 800
screen_height = 450

init_window(screen_width, screen_height, "raylib [core] example - 2d camera")

player = Rectangle.new(400, 280, 40, 40)
buildings = []
building_colours = []

spacing = 0

MAX_BUILDINGS.times do |i|
  height = rand(700) + 100
  buildings[i] = Rectangle.new(
    -6000.0 + spacing,
    screen_height - 130.0 - height,
    rand(150) + 50,
    height
  )

  spacing += buildings[i].width

  building_colours[i] = Colour.new(rand(40) + 200, rand(40) + 200, rand(50) + 200, 255)
end

camera = Camera2D.new(
  Vector2.new(player.x + 20, player.y + 20),
  Vector2.new(screen_width / 2.0, screen_height / 2.0),
  0, 1
)

set_target_fps(60) # Set our game to run at 60 frames-per-second

# Main game loop
until window_should_close? # Detect window close button or ESC key
  # Update

  # Player movement
  player.x += 2 if is_key_down(KEY_RIGHT)
  player.x -= 2 if is_key_down(KEY_LEFT)

  # Camera target follows player
  camera.target.x = player.x + 20
  camera.target.y = player.y + 20

  # Camera rotation controls
  camera.rotation -= 1 if is_key_down(KEY_A)
  camera.rotation += 1 if is_key_down(KEY_S)

  # Limit camera rotation to 80 degrees (-40 to 40)
  camera.rotation = 40 if camera.rotation > 40
  camera.rotation = -40 if camera.rotation < -40

  # Camera zoom controls
  camera.zoom += get_mouse_wheel_move * 0.05

  camera.zoom = 3.0 if camera.zoom > 3.0
  camera.zoom = 0.1 if camera.zoom < 0.1

  # Camera reset (zoom and rotation)
  if is_key_pressed(KEY_R)
    camera.zoom = 1
    camera.rotation = 0
  end

  # Draw
  begin_drawing

  clear_background(RAYWHITE)

  begin_mode2D(camera);
  #p camera.to_h

  draw_rectangle(-6000, 320, 13000, 8000, DARKGRAY);

  MAX_BUILDINGS.times { |i| draw_rectangle_rec(buildings[i], building_colours[i]) }

  draw_rectangle_rec(player, RED)

  draw_line(camera.target.x, -screen_height * 10, camera.target.x, screen_height * 10, GREEN)
  draw_line(-screen_width * 10, camera.target.y, screen_width * 10, camera.target.y, GREEN)

  end_mode2D

  draw_text("SCREEN AREA", 640, 10, 20, RED)

  draw_rectangle(0, 0, screen_width, 5, RED)
  draw_rectangle(0, 5, 5, screen_height - 10, RED)
  draw_rectangle(screen_width - 5, 5, 5, screen_height - 10, RED)
  draw_rectangle(0, screen_height - 5, screen_width, 5, RED)

  draw_rectangle(10, 10, 250, 113, fade(SKYBLUE, 0.5))
  draw_rectangle_lines(10, 10, 250, 113, BLUE)

  draw_text("Free 2d camera controls:", 20, 20, 10, BLACK)
  draw_text("- Right/Left to move Offset", 40, 40, 10, DARKGRAY)
  draw_text("- Mouse Wheel to Zoom in-out", 40, 60, 10, DARKGRAY)
  draw_text("- A / S to Rotate", 40, 80, 10, DARKGRAY)
  draw_text("- R to reset Zoom and Rotation", 40, 100, 10, DARKGRAY)

  end_drawing
end

# De-Initialization
close_window # Close window and OpenGL context
