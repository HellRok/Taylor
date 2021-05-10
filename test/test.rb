set_trace_log_level 5

require './test/helpers'

require './test/fixtures/core'
require './test/fixtures/shapes'

require './test/core'
require './test/shapes'
require './test/models/camera2d'
require './test/models/colour'
require './test/models/image'
require './test/models/rectangle'
require './test/models/texture2d'
require './test/models/vector2'

MTest::Unit.new.run
