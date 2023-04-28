TOP_LEVEL = self

module ::Garak
  extend self

  require "garak/ansi"
  require "garak/repl"

  GAME_FILE = "game.rb"

  def Garak.boot()
    return false if @@booted ||= false
    @@booted = true

    init_window(1280, 720, "Game")

    set_window_state(FLAG_VSYNC_HINT | FLAG_WINDOW_RESIZABLE)
    set_window_min_size(100, 100)

    set_target_fps get_monitor_refresh_rate get_current_monitor

    init_audio_device

    require GAME_FILE
  end

  begin :logs
    def log(*msgs) = puts(*msgs)
  end

  def ohai() = "hey there! :-)"

  begin :reload
    def game_file_changed?(path=GAME_FILE)
      @game_file_stat ||= {}

      old_stat = @game_file_stat[path]
      new_stat = @game_file_stat[path] = File.stat(path)

      old_stat and old_stat.mtime != new_stat.mtime
    end

    def reloadable_files
      [*$", __FILE__].uniq
    end

    def reload_changed_files!
      for file in reloadable_files
        reload!(file) if game_file_changed?(file)
      end
    end

    def reload!(path=GAME_FILE)
      log ANSI.yellow "=> Reload #{path}"
      clear_tick_error
      TOP_LEVEL.load path
    end
  end

  begin :frame_count
    @@frame_count ||= 0
    
    def frame_count() = @@frame_count
    def first_frame?() = (@@frame_count == 1)
    def advance_frame_count() = @@frame_count += 1
  end

  begin :repl
    @@repl ||= REPL.new(prompt: "Garak|> ")

    def repl
      @@repl
    end

    def repl=(repl)
      @@repl = repl
    end
  end

  def play
    return set_main_loop 'tick!' if browser?

    @@repl&.prompt!
    until window_should_close?
      reload_changed_files!
      @@repl&.tick!

      if get_tick_error
        draw_tick_error!
      else
        tick!
      end
    end

    shutdown
  end

  def tick!
    advance_frame_count
    init if first_frame?
    TOP_LEVEL.tick
  rescue SystemExit
    raise
  rescue Exception => ex
    backtrace = ex.backtrace[..-4].map do |line|
      line.delete_prefix(Dir.pwd).delete_prefix("/")
    end

    msg = <<~msg
      #{ex.message}
      #{backtrace.map! { "   #{_1}" }.join "\n"}
    msg

    log ANSI.red msg
    set_tick_error msg
    draw_tick_error! msg
  end

  def draw_tick_error!(msg=get_tick_error)
    drawing {
      clear_background(BLACK)
      draw_text_ex(default_font, msg, Vector2.new(20, 20), 20, 2, RED)
    }
  end

  def get_tick_error() = @__tick_error__
  def set_tick_error(msg) = @__tick_error__ = msg
  def clear_tick_error() = set_tick_error(nil)

  def shutdown(exit=true)
    log ANSI.yellow "Shutdown"

    close_audio_device
    close_window
    Kernel.exit if exit
  end
end

module ::Garak
  module Numeric
    def hertz() = 1.0 / self
    alias :hz :hertz
  end

  ::Numeric.include Numeric
end

module ::Garak
  module Throttle
    @@times = {}

    def throttle(interval=1.0, task=caller[0])
      last = @@times[task]
      now  = get_time

      if !last || last <= (now - interval)
        @@times[task] = now
        yield
      end
    end
  end

  ::Object.include Throttle
end

# Showtime.

begin
  ::Garak.boot
  ::Garak.play
rescue SystemExit
  return
end

