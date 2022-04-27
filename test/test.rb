set_trace_log_level 5

require 'ta_mtest'
require 'mtest_overrides'
require 'mtest_extensions'
require 'helpers'

require 'fixtures/core'
require 'fixtures/image'
require 'fixtures/shapes'
require 'fixtures/text'
require 'fixtures/texture'
require 'fixtures/models'

require 'core'
require 'core/drawing'
require 'images'
require 'text'
require 'textures'
require 'shapes/circle'
require 'shapes/ellipse'
require 'shapes/collision'
require 'shapes/line'
require 'shapes/pixel'
require 'shapes/rectangle'
require 'shapes/ring'
require 'shapes/triangle'
require 'models/camera2d'
require 'models/colour'
require 'models/font'
require 'models/image'
require 'models/music'
require 'models/rectangle'
require 'models/sound'
require 'models/texture2d'
require 'models/vector2'

init_window(10, 10, 'blah') if !ENV.fetch('DISPLAY', '').empty? || browser? || windows?
exit 1 if MTest::Unit.new.run.positive?
close_window if !ENV.fetch('DISPLAY', '').empty? || browser? || windows?

# The browser version doesn't exit cleanly unless specifically told to.
exit
