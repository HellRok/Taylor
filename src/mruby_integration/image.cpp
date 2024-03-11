#include "mruby.h"
#include "mruby/string.h"
#include "mruby/variable.h"
#include "raylib.h"

#include "mruby_integration/models/image.hpp"
#include "mruby_integration/struct_types.hpp"

auto
mrb_get_screen_data(mrb_state* mrb, mrb_value) -> mrb_value
{
  auto* image = static_cast<Image*>(malloc(sizeof(Image)));
  *image = LoadImageFromScreen();

  mrb_value obj =
    mrb_obj_value(Data_Wrap_Struct(mrb, Image_class, &Image_type, image));

  setup_Image(mrb,
              obj,
              image,
              image->width,
              image->height,
              image->mipmaps,
              image->format);

  return obj;
}

void
append_images(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_screen_data",
                    mrb_get_screen_data,
                    MRB_ARGS_NONE());
}
