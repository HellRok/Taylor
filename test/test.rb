require "mtest_overrides"
require "mtest_extensions"

require "base"

require "fixtures/web"

require "core/drawing_test"
require "core_test"
require "models/audio_test"
require "models/camera2d_test"
require "models/colour_test"
require "models/cursor_test"
require "models/font_test"
require "models/image_test"
require "models/key_test"
require "models/music_test"
require "models/mouse_test"
require "models/rectangle_test"
require "models/render_texture_test"
require "models/shader_test"
require "models/sound_test"
require "models/texture2d_test"
require "models/vector2_test"
require "models/window_test"
# require "shapes/circle_test"
# require "shapes/collision_test"
# require "shapes/line_test"
# require "shapes/pixel_test"
# require "shapes/rectangle_test"
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
