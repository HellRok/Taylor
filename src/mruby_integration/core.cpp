#include "mruby.h"

#include "ruby/core/buildkite_analytics.hpp"

void
append_core(mrb_state* mrb)
{
  load_ruby_core_buildkite_analytics(mrb);
}
