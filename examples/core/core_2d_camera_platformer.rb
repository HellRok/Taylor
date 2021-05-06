# Adapted from https://github.com/raysan5/raylib/blob/master/examples/core/core_2d_camera_platformer.c
GRAVITY = 400
PLAYER_JUMP_SPD = 350.0
PLAYER_HOR_SPD = 200.0

class Player
  attr_accessor :position, :speed, :can_jump
  alias :can_jump? :can_jump

  def initialize(position, speed)
    @position = position
    @speed = speed
    @can_jump = false
  end
end

class EnvItem
  attr_accessor :rectangle, :blocking, :colour

  def initialize(rectangle, blocking, colour)
    @rectangle = rectangle
    @blocking = blocking
    @colour = colour
  end
end


def update_player(player, env_items, delta)
  player.position.x -= PLAYER_HOR_SPD * delta if is_key_down(KEY_LEFT)
  player.position.x += PLAYER_HOR_SPD*delta if is_key_down(KEY_RIGHT)
  if (is_key_down(KEY_SPACE) && player.can_jump?)
    player.speed = -PLAYER_JUMP_SPD
    player.can_jump = false
  end

  hit_obstacle = false
  env_items.each { |item|
    if (item.blocking &&
        item.rectangle.x <= player.position.x &&
        item.rectangle.x + item.rectangle.width >= player.position.x &&
        item.rectangle.y >= player.position.y &&
        item.rectangle.y < player.position.y + player.speed * delta)
      hit_obstacle = true
      player.speed = 0
      player.position.y = item.rectangle.y
    end
  }

  if hit_obstacle
    player.can_jump = true
  else
    player.position.y += player.speed * delta
    player.speed += GRAVITY * delta
    player.can_jump = false
  end
end

# Initialization
screen_width = 800;
screen_height = 450;

init_window(screen_width, screen_height, "raylib [core] example - 2d camera platformer");

player = Player.new(Vector2.new(400, 280), 0)

env_items = [
  EnvItem.new(Rectangle.new(0, 0, 1000, 400   ), 0, LIGHTGRAY),
  EnvItem.new(Rectangle.new(0, 400, 1000, 200 ), 1, GRAY),
  EnvItem.new(Rectangle.new(300, 200, 400, 10 ), 1, GRAY),
  EnvItem.new(Rectangle.new(250, 300, 100, 10 ), 1, GRAY),
  EnvItem.new(Rectangle.new(650, 300, 100, 10 ), 1, GRAY),
]

camera = Camera2D.new(
  player.position,
  Vector2.new(screen_width/2.0, screen_height/2.0),
  0, 1,
)

def update_camera_center(camera, player, envItems, delta, width, height)
  camera.offset.x = width / 2.0
  camera.offset.y = height / 2.0
  camera.target.x = player.position.x
  camera.target.y = player.position.y
end

def update_camera_inside_map(camera, player, env_items, delta, width, height)
  camera.target.x = player.position.x
  camera.target.y = player.position.y
  camera.offset.x = width / 2.0
  camera.offset.y = height / 2.0

  min_x = env_items.map { |item| item.rectangle.x }.min
  min_y = env_items.map { |item| item.rectangle.y }.min
  max_x = env_items.map { |item| item.rectangle.x + item.rectangle.width }.max
  max_y = env_items.map { |item| item.rectangle.y + item.rectangle.height }.max

  max = get_world_to_screen2D(Vector2.new(max_x, max_y), camera)
  min = get_world_to_screen2D(Vector2.new(min_x, min_y), camera)

  camera.offset.x = width - (max.x - width / 2)   if (max.x < width)
  camera.offset.y = height - (max.y - height / 2) if (max.y < height)
  camera.offset.x = width / 2 - min.x             if (min.x > 0)
  camera.offset.y = height / 2 - min.y            if (min.y > 0)
end

def update_camera_smooth_follow(camera, player, envItems, delta, width, height)
  min_speed = 30
  min_effect_length = 10
  fraction_speed = 0.8

  camera.offset.x = width / 2.0
  camera.offset.y = height / 2.0
  diff = player.position - camera.target
  length = diff.length

  if (length > min_effect_length)
    speed = [fraction_speed * length, min_speed].max
    camera.target += diff.scale(speed * delta / length)
  end
end

EVEN_OUT_SPEED = 700
EVENING_OUT = false
EVEN_OUT_TARGET = player.position.y

def update_camera_even_out_on_landing(camera, player, envItems, delta, width, height)
  camera.offset.x = width / 2.0
  camera.offset.y = height / 2.0
  camera.target.x = player.position.x;

  if EVENING_OUT
    if EVEN_OUT_TARGET > camera.target.y
      camera.target.y += EVEN_OUT_SPEED * delta

      if camera.target.y > EVEN_OUT_TARGET
        camera.target.y = EVEN_OUT_TARGET
        EVENING_OUT = false
      end
    else
      camera.target.y -= EVEN_OUT_SPEED * delta

      if (camera.target.y < EVEN_OUT_TARGET)
        camera.target.y = EVEN_OUT_TARGET
        EVENING_OUT = false
      end
    end
  else
    if player.can_jump? && player.speed == 0 && player.position.y != camera.target.y
      EVENING_OUT = true
      EVEN_OUT_TARGET = player.position.y
    end
  end
end

def update_camera_player_bounds_push(camera, player, envItems, delta, width, height)
  bbox = Vector2.new(0.2, 0.2)

  bbox_world_min = get_screen_to_world2D(Vector2.new((1 - bbox.x) * 0.5 * width, (1 - bbox.y) * 0.5 * height), camera)
  bbox_world_max = get_screen_to_world2D(Vector2.new((1 + bbox.x) * 0.5 * width, (1 + bbox.y) * 0.5 * height), camera)
  camera.offset = Vector2.new((1 - bbox.x) * 0.5 * width, (1 - bbox.y) * 0.5 * height)

  camera.target.x = player.position.x if (player.position.x < bbox_world_min.x)
  camera.target.y = player.position.y if (player.position.y < bbox_world_min.y)
  camera.target.x = bbox_world_min.x + (player.position.x - bbox_world_max.x) if (player.position.x > bbox_world_max.x)
  camera.target.y = bbox_world_min.y + (player.position.y - bbox_world_max.y) if (player.position.y > bbox_world_max.y)
end

# call the currently selected camera option
def camera_updaters(option, camera, player, env_items, delta, width, height)
  case option
  when 0
    update_camera_center(camera, player, env_items, delta, width, height)
  when 1
    update_camera_inside_map(camera, player, env_items, delta, width, height)
  when 2
    update_camera_smooth_follow(camera, player, env_items, delta, width, height)
  when 3
    update_camera_even_out_on_landing(camera, player, env_items, delta, width, height)
  when 4
    update_camera_player_bounds_push(camera, player, env_items, delta, width, height)
  end
end

camera_option = 3

camera_descriptions = [
  "Follow player center",
  "Follow player center, but clamp to map edges",
  "Follow player center; smoothed",
  "Follow player center horizontally; updateplayer center vertically after landing",
  "Player push camera on getting too close to screen edge",
]

set_target_fps(60);

# Main game loop
until window_should_close?
  # Update
  delta = get_frame_time

  update_player(player, env_items, delta)

  camera.zoom += get_mouse_wheel_move * 0.05

  if camera.zoom > 3
    camera.zoom = 3.0
  elsif camera.zoom < 0.25
    camera.zoom = 0.25
  end

  if is_key_pressed(KEY_R)
    camera.zoom = 1.0
    player.position.x = 400
    player.position.y = 280
  end

  if is_key_pressed(KEY_C)
    camera_option += 1
    camera_option = 0 if camera_option >= camera_descriptions.length
  end

  # Call update camera function
  camera_updaters(camera_option, camera, player, env_items, delta, screen_width, screen_height)

  # Draw
  begin_drawing

  clear_background(LIGHTGRAY)

  begin_mode2D(camera)

  env_items.each { |item| draw_rectangle_rec(item.rectangle, item.colour) }

  draw_rectangle(player.position.x - 20, player.position.y - 40, 40, 40, RED)

  end_mode2D

  draw_text("Controls:", 20, 20, 10, BLACK)
  draw_text("- Right/Left to move", 40, 40, 10, DARKGRAY)
  draw_text("- Space to jump", 40, 60, 10, DARKGRAY)
  draw_text("- Mouse Wheel to Zoom in-out, R to reset zoom", 40, 80, 10, DARKGRAY)
  draw_text("- C to change camera mode", 40, 100, 10, DARKGRAY)
  draw_text("Current camera mode:", 20, 120, 10, BLACK)
  draw_text(camera_descriptions[camera_option], 40, 140, 10, DARKGRAY)

  end_drawing
end

# De-Initialization
close_window # Close window and OpenGL context
