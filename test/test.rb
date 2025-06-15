require "mtest_overrides"
require "mtest_extensions"

require "base"

require "core/drawing_test"
require "core_test"
require "models/audio_test"
require "input/key_test"
require "input/mouse_test"
require "input/touch_test"
require "models/camera2d_test"
require "models/circle_test"
require "models/colour_test"
require "models/cursor_test"
require "models/font_test"
require "models/image_test"
require "models/line_test"
require "models/monitor_test"
require "models/music_test"
require "models/rectangle_test"
require "models/render_texture_test"
require "models/shader_test"
require "models/sound_test"
require "models/texture2d_test"
require "models/vector2_test"
require "models/window_test"
require "taylor_test"
require "taylor/platform_test"
require "web_test"

result = MTest::Unit.new.run.positive?

if Taylor::Platform.browser?
  puts "ANALYTICS: #{$buildkite_test_analytics.to_json}"
  puts "EXIT CODE: #{result ? 1 : 0}"
  cancel_main_loop
  set_main_loop "noop"
else
  persist_buildkite_test_analytics
end

exit! 1 if result
exit!
