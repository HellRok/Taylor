#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/models/image.hpp"
#include "mruby_integration/struct_types.hpp"

mrb_value mrb_load_image(mrb_state *mrb, mrb_value) {
  char *path;
  mrb_get_args(mrb, "z", &path);

  Image *image = (Image *)malloc(sizeof(Image));
  *image = LoadImage(path);

  mrb_value obj = mrb_obj_value(Data_Wrap_Struct(mrb, Image_class, &Image_type, image));

  setup_Image(mrb, obj, image, image->width, image->height, image->mipmaps, image->format);

  return obj;
}

mrb_value mrb_unload_image(mrb_state *mrb, mrb_value) {
  Image *image;
  mrb_get_args(mrb, "d", &image, &Image_type);

  UnloadImage(*image);

  return mrb_nil_value();
}

mrb_value mrb_export_image(mrb_state *mrb, mrb_value) {
  Image *image;
  char *path;
  mrb_get_args(mrb, "dz", &image, &Image_type, &path);

  ExportImage(*image, path);

  return mrb_nil_value();
}

mrb_value mrb_generate_image_colour(mrb_state *mrb, mrb_value) {
  mrb_int width, height;
  Color *colour;
  mrb_get_args(mrb, "iid", &width, &height, &colour, &Colour_type);

  Image *image = (Image *)malloc(sizeof(Image));
  *image = GenImageColor(width, height, *colour);

  mrb_value obj = mrb_obj_value(Data_Wrap_Struct(mrb, Image_class, &Image_type, image));

  setup_Image(mrb, obj, image, image->width, image->height, image->mipmaps, image->format);

  return obj;
}

mrb_value mrb_get_screen_data(mrb_state *mrb, mrb_value) {
  Image *image = (Image *)malloc(sizeof(Image));
  *image = GetScreenData();

  mrb_value obj = mrb_obj_value(Data_Wrap_Struct(mrb, Image_class, &Image_type, image));

  setup_Image(mrb, obj, image, image->width, image->height, image->mipmaps, image->format);

  return obj;
}

void append_images(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "load_image", mrb_load_image, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "unload_image", mrb_unload_image, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "export_image", mrb_export_image, MRB_ARGS_REQ(2));

  mrb_define_method(mrb, mrb->kernel_module, "generate_image_colour", mrb_generate_image_colour, MRB_ARGS_REQ(3));

  mrb_define_method(mrb, mrb->kernel_module, "get_screen_data", mrb_get_screen_data, MRB_ARGS_NONE());
}
