#include "mruby.h"

#include "mruby_integration/shapes/collision.hpp"

void
append_shapes(mrb_state* mrb)
{
  append_shapes_collision(mrb);
}
