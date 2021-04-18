#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

void append_structs(mrb_state *mrb) {
  append_models_Colour(mrb);
  append_models_Texture2D(mrb);
}
