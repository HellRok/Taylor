#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

void appendStructs(mrb_state *mrb) {
  appendModelsColour(mrb);
  appendModelsTexture2D(mrb);
}
