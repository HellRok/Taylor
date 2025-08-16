require "mtest_overrides"
require "mtest_extensions"

require "base"

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

result = MTest::Unit.new.run.positive?

MTest.persist_buildkite_test_analytics

if Taylor::Platform.browser?
  puts "EXIT CODE: #{result ? 1 : 0}"
  Browser.cancel_main_loop
  Browser.main_loop = "noop"
else

  exit! 1 if result
  exit!
end
