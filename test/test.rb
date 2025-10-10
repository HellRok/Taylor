@unit = Neospec::Suite.new(runner: Neospec::Runner::Basic.new)
@browser = Neospec::Suite.new(runner: Neospec::Runner::Basic.new)

@unit.after do
  if Taylor::Raylib.mocks.any?
    puts "Mocks left behind:"
    Taylor::Raylib.mocks.each { |mock| puts "  - #{mock}" }
    raise StandardError, "Mocks left behind"
  end

  GC.start
  unless ReferenceCounter.tracked_objects_count.zero?
    raise StandardError, "Objects not cleaned up"
  end

  Logging.level = Logging::INFO # Reset the cvars
  Window.close # We need this to reset the cvars
  Taylor::Raylib.reset_calls
  Taylor::Raylib.clear_mocks
end

neospec = Neospec.new(
  logger: Neospec::Logger::Basic.new,
  reporters: [Neospec::Report::Basic],
  suites: [@unit]
)

require "input/gamepad_test"
require "input/gesture_test"
require "input/key_test"
require "input/mouse_test"
require "input/touch_test"

require "models/audio_test"
require "models/browser_test"
require "models/camera2d_test"
require "models/circle_test"
require "models/clipboard_test"
require "models/colour_test"
require "models/cursor_test"
require "models/dropped_files"
require "models/font_test"
require "models/image_test"
require "models/line_test"
require "models/local_storage_test"
require "models/logging_test"
require "models/monitor_test"
require "models/music_test"
require "models/rectangle_test"
require "models/render_texture_test"
require "models/shader_test"
require "models/sound_test"
require "models/texture2d_test"
require "models/vector2_test"
require "models/window_test"
require "modules/reference_counting_test"
require "taylor/platform_test"
require "taylor_test"

if Taylor::Platform.browser?
  success = neospec.run
  puts "EXIT CODE: #{success ? 0 : 1}"
  Browser.cancel_main_loop
  Browser.main_loop = "noop"
else

  neospec.run!
end
