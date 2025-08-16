#include "mruby.h"

#include "mruby_integration/core/drawing.hpp"
#include "mruby_integration/core/misc.hpp"

#include "ruby/core/buildkite_analytics.hpp"

void
append_core(mrb_state* mrb)
{
  append_core_drawing(mrb);
  append_core_misc(mrb);

  load_ruby_core_buildkite_analytics(mrb);
}
