require "mtest_overrides"
require "mtest_extensions"
require "helpers"
require "support/x_do"

require "base"

require "fixtures/core"
require "fixtures/font"
require "fixtures/shader"
require "fixtures/shapes"
require "fixtures/texture"
require "fixtures/models"
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
# require "models/vector2_test"
# require "models/window_test"
# require "platform"
# require "shader_test"
# require "shapes/circle_test"
# require "shapes/collision_test"
# require "shapes/ellipse_test"
# require "shapes/line_test"
# require "shapes/pixel_test"
# require "shapes/rectangle_test"
# require "shapes/ring_test"
# require "shapes/triangle_test"
# require "texture_test"
# require "web"

result = MTest::Unit.new.run.positive?

exit! 1 if result
# reset_window if use_window?
#
# $started = false
# def main
#  result = MTest::Unit.new.run.positive?
#  Window.close if use_window?
#
#  persist_buildkite_test_analytics unless browser?
#
#  # The browser version doesn't exit cleanly unless specifically told to.
#  if browser?
#    puts "ANALYTICS: #{$buildkite_test_analytics.to_json}"
#    puts "EXIT CODE: #{result ? 1 : 0}"
#    cancel_main_loop
#    set_main_loop "noop"
#    exit!
#  elsif result
#    exit! 1
#  end
# end
#
# if browser?
#  set_main_loop "main"
# else
#  main
# end
