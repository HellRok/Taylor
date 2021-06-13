set_trace_log_level 5

require './mtest_extensions'
require './helpers'

require './fixtures/core'
require './fixtures/shapes'

require './core'
require './shapes/circle'
require './shapes/collision'
require './shapes/line'
require './shapes/pixel'
require './shapes/rectangle'
require './shapes/triangle'
require './models/camera2d'
require './models/colour'
require './models/image'
require './models/music'
require './models/rectangle'
require './models/sound'
require './models/texture2d'
require './models/vector2'

MTest::Unit.new.run
