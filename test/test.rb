set_trace_log_level 5

require 'mtest_overrides'
require 'mtest_extensions'
require 'helpers'

require 'fixtures/core'
require 'fixtures/image'
require 'fixtures/shader'
require 'fixtures/shapes'
require 'fixtures/text'
require 'fixtures/texture'
require 'fixtures/models'
require 'fixtures/web'

require 'core_test'
require 'core/drawing_test'
require 'image_test'
require 'shader_test'
require 'text_test'
require 'texture_test'
require 'shapes/circle_test'
require 'shapes/collision_test'
require 'shapes/ellipse_test'
require 'shapes/line_test'
require 'shapes/pixel_test'
require 'shapes/rectangle_test'
require 'shapes/ring_test'
require 'shapes/triangle_test'
require 'models/camera2d_test'
require 'models/colour_test'
require 'models/font_test'
require 'models/image_test'
require 'models/music_test'
require 'models/rectangle_test'
require 'models/render_texture_test'
require 'models/shader_test'
require 'models/sound_test'
require 'models/texture2d_test'
require 'models/vector2_test'
require 'web'

init_window(10, 10, 'blah') if !ENV.fetch('DISPLAY', '').empty? || browser? || windows?
result = MTest::Unit.new.run.positive?
close_window if !ENV.fetch('DISPLAY', '').empty? || browser? || windows?

upload_buildkite_test_analytics

exit! 1 if result

# The browser version doesn't exit cleanly unless specifically told to.
if browser?
  puts "EXIT CODE: #{result ? 1 : 0}"
  exit!
end
