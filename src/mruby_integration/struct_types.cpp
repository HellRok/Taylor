#include "mruby.h"
#include "mruby/data.h"

mrb_data_type Colour_type =    { "Color",     mrb_free };
mrb_data_type Texture2D_type = { "Texture2D", mrb_free };
mrb_data_type Vector2_type =   { "Vector2",   mrb_free };
