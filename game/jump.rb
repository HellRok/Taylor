$state ||= OpenStruct.new

WIN_SIZE = 90

def init
  $state.platforms = [platform!()] #, platform!(y: 300)]
  $state.gravity   = -2.5
  $state.player = OpenStruct.new
  $state.player.platforms_cleared = 0
  $state.player.x  = get_screen_width / 2 - 275
  $state.player.y  = 100
  $state.player.w  = 16
  $state.player.h  = 64
  $state.player.dy = 9
  $state.player.dx = 35
  $state.player_jump_power           = 45
  $state.player_jump_power_duration  = 0
  $state.player_max_run_speed        = 18
  $state.player_speed_slowdown_rate  = 0.7
  $state.player_acceleration         = 7
  $state.player.color                = Color[rand(255), rand(255), rand(255)]
  $state.camera = { y: -100 }

  jump_sound
end

include Garak

def tick
  init if key_pressed? KEY_R
  exit if key_pressed? KEY_Q

  input
  calc

  drawing do
    clear_background Colour[
      Math.sin(Garak.frame_count / 77.0).+(1)./(2).*(120).round,
      Math.sin(Garak.frame_count.+(30) / 66.0).+(1)./(2).*(120).round,
      Math.sin(Garak.frame_count.-(70) / 55.0).+(1)./(2).*(120).round,
    ].tap { |c| c.red = [25, c.red].max; c.green = [25, c.green].max; c.blue = [25, c.blue].max }

    for p in $state.platforms
      min_alpha = 255 - p.i * 25
      min_alpha = 50 if min_alpha < 50
      alpha = min_alpha + (Math.sin(p.i*p.i + frame_count/60.0*p.i).+(1) / 2) * (255 - min_alpha)
      draw_rectangle(p.x-1, get_screen_height - p.y + $state.camera[:y] - 1, p.w+2, p.h+2, Color[255, 255, 255, alpha])
      draw_rectangle(p.x, get_screen_height - p.y + $state.camera[:y], p.w, p.h, Color[0,0,0, 255])
    end

    player = $state.player

    draw_text(player.platforms_cleared.to_s, 25, 25, 32, YELLOW)
    # draw_rectangle($state.player.x - 1, get_screen_height - $state.player.y - $state.player.h + $state.camera[:y] - 1, $state.player.w+2, $state.player.h+2, Color[255, 255, 255, 200])
    # draw_rectangle($state.player.x, get_screen_height - $state.player.y - $state.player.h + $state.camera[:y], $state.player.w, $state.player.h, $state.player.color)

    # draw_rectangle_rounded(Rectangle.new(player.x - 1, get_screen_height - player.y - player.h + $state.camera[:y] - 1, player.w+2, player.h+2), 0.5, 1, Color[255, 255, 255, 200])
    draw_rectangle_rounded(Rectangle.new(player.x, get_screen_height - player.y - player.h + $state.camera[:y], player.w, player.h), 0.3, 1, Color[195, 35, 10, 200])
  end
end

def platform! opts={}
  OpenStruct.new({
    x: get_screen_width / 2 - 350 + (rand * [-250, 250].sample).round, y: 0,
    w: get_screen_width * 0.4, h: get_screen_height / 20,
    dx: 1,
    speed: 1,
    rect: nil,
    i: 0,
  }.merge! opts)
end

def jump!
  jump_sound.pitch = ($state.player.platforms_cleared || 0).+(1) * 0.05
  jump_sound.play
  $state.player.dy = $state.player_jump_power
end

def grow!(w=2)
  $state.player.w += w
  $state.player.x -= w/2.0
end

def input
  player = $state.player

  if key_pressed?(KEY_SPACE) # or key_pressed?(KEY_A) or key_pressed?(KEY_D)
    player.jumped_at ||= frame_count
    if (player.jumped_at ||= frame_count) == frame_count
      grow!
      jump!
    end

    if (frame_count-player.jumped_at) <= $state.player_jump_power_duration && !player.falling
      jump!
    end
  end

  if key_released?(KEY_SPACE)
    player.falling = true
  end

  if player.falling
    jump_sound.stop
  end

  if key_down?(KEY_A)
    player.dx -= $state.player_acceleration
    player.dx = [player.dx, -$state.player_max_run_speed].max
  elsif key_down?(KEY_D)
    player.dx += $state.player_acceleration
    player.dx = [player.dx, $state.player_max_run_speed].min
  else
    player.dx *= $state.player_speed_slowdown_rate
  end
end

def calc
  camera = $state.camera
  platforms = $state.platforms
  player = $state.player
  gravity = $state.gravity

  platforms.each do |p|
    # p.rect = [p.x, p.y, p.w, p.h]
    p.rect = Rectangle.new(p.x, p.y, p.w, p.h)
  end

  # player.point = [player.x + player.w.half, player.y]
  player.rect = Rectangle.new(player.x, player.y, player.w, player.h)

  # collision = platforms.find { |p| player.point.inside_rect? p.rect }
  collision = platforms.find do |p|
    check_collision_recs(player.rect, p.rect)
  end

  if collision && player.dy <= 0
    player.dy = 0 if player.dy < 0
    player.y = collision.rect.y
    if !player.platform
      player.dx = 0
    end
    player.x += collision.dx * collision.speed
    player.platform = collision
    player.platforms_cleared = collision.i
    if player.falling
      player.dx = 0
    end
    player.falling = false
    player.jumped_at = nil

    if collision.w <= WIN_SIZE
      win!
    else
      # grow!
      # jump!
    end
  else
    player.platform = nil
    player.y  += player.dy
    player.dy += gravity
  end

  platforms.each do |p|
    p.x += p.dx * p.speed
    if p.x < 0
      p.dx *= -1
      p.x = 0
    elsif p.x > (get_screen_width - p.w)
      p.dx *= -1
      p.x = (get_screen_width - p.w)
    end
  end

  delta = (player.y - camera[:y] - 150)

  if delta > -400
    camera[:y] += delta * 0.03
    player.x  += player.dx
    has_platforms = platforms.find { |p| p.y > (player.y + 300) }

    if !has_platforms
      last_platform = platforms[-1]

      width = last_platform.w * 0.9
      # width = (get_screen_width * 0.75) - player.platforms_cleared * 50

      # player.platforms_cleared += 1

      unless last_platform.w <= WIN_SIZE
        platforms << platform!(
          x: (get_screen_width - width) * rand,
          y: last_platform.y + 300,
          w: width,
          dx: [-1, 1].sample,
          i: last_platform.i + 1,
          speed: 1.3 * player.platforms_cleared)
      end
    end
  else
    init
  end
end

def win!
  jump_sound.pitch.tap do |prev_pitch|
    jump_sound.pitch = 0.5
    jump_sound.play
    jump_sound.pitch = prev_pitch || 1
  end

  init
end

def jump_sound
  @jump_sound ||= load_sound("jump.wav")
end
