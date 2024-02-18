#include "mruby.h"

#include "mruby_integration/core/cursor.hpp"
#include "mruby_integration/core/drawing.hpp"
#include "mruby_integration/core/files.hpp"
#include "mruby_integration/core/gestures.hpp"
#include "mruby_integration/core/input.hpp"
#include "mruby_integration/core/misc.hpp"
#include "mruby_integration/core/timing.hpp"
#include "mruby_integration/core/window.hpp"

#include "ruby/core/buildkite_analytics.hpp"

void
append_core(mrb_state* mrb)
{
  append_core_cursor(mrb);
  append_core_drawing(mrb);
  append_core_files(mrb);
  append_core_gestures(mrb);
  append_core_input(mrb);
  append_core_misc(mrb);
  append_core_timing(mrb);
  append_core_window(mrb);

  load_ruby_core_buildkite_analytics(mrb);
}
