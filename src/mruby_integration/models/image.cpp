#include "mruby.h"
#include "mruby/array.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"
#include <cstdlib>

#include "mruby_integration/exceptions.hpp"
#include "mruby_integration/helpers.hpp"
#include "mruby_integration/models/colour.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/image.hpp"

struct RClass* Image_class;

void
setup_Image(mrb_state* mrb,
            mrb_value object,
            Image* image,
            int width,
            int height,
            int mipmaps,
            int format)
{
  ivar_attr_int(mrb, object, image->width, width);
  ivar_attr_int(mrb, object, image->height, height);
  ivar_attr_int(mrb, object, image->mipmaps, mipmaps);
  ivar_attr_int(mrb, object, image->format, format);
}

auto
mrb_Image_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  char* path;
  mrb_get_args(mrb, "z", &path);

  if (!FileExists(path)) {
    raise_not_found_error(mrb, Image_class);
  }

  Image* image = static_cast<Image*> DATA_PTR(self);
  if (image) {
    mrb_free(mrb, image);
  }
  mrb_data_init(self, nullptr, &Image_type);
  image = static_cast<Image*>(malloc(sizeof(Image)));
  *image = LoadImage(path);

  setup_Image(mrb,
              self,
              image,
              image->width,
              image->height,
              image->mipmaps,
              image->format);

  mrb_data_init(self, image, &Image_type);
  return self;
}

auto
mrb_Image_unload(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Image* image;

  Data_Get_Struct(mrb, self, &Image_type, image);
  mrb_assert(image != nullptr);

  UnloadImage(*image);

  return mrb_nil_value();
}

auto
mrb_Image_export(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Image* image;

  Data_Get_Struct(mrb, self, &Image_type, image);
  mrb_assert(image != nullptr);

  char* path;
  mrb_get_args(mrb, "z", &path);

  ExportImage(*image, path);

  return mrb_nil_value();
}

auto
mrb_Image_get_data(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Image* image;

  Data_Get_Struct(mrb, self, &Image_type, image);
  mrb_assert(image != nullptr);

  Color* colours = LoadImageColors(*image);

  int size = image->width * image->height;

  mrb_value return_array = mrb_ary_new(mrb);

  for (int i = 0; i < size; i++) {
    mrb_value obj = mrb_obj_value(
      Data_Wrap_Struct(mrb, Colour_class, &Colour_type, &colours[i]));
    setup_Colour(mrb,
                 obj,
                 &colours[i],
                 colours[i].r,
                 colours[i].g,
                 colours[i].b,
                 colours[i].a);
    mrb_ary_push(mrb, return_array, obj);
    add_owned_object(&colours[i]);
  }

  return return_array;
}

void
append_models_Image(mrb_state* mrb)
{
  Image_class = mrb_define_class(mrb, "Image", mrb->object_class);
  MRB_SET_INSTANCE_TT(Image_class, MRB_TT_DATA);
  mrb_define_method(
    mrb, Image_class, "initialize", mrb_Image_initialize, MRB_ARGS_REQ(5));
  mrb_define_method(
    mrb, Image_class, "unload", mrb_Image_unload, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Image_class, "export", mrb_Image_export, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Image_class, "data", mrb_Image_get_data, MRB_ARGS_NONE());

  load_ruby_models_image(mrb);
}
