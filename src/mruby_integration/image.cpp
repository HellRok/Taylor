#include "raylib.h"
#include "mruby.h"
#include "mruby/string.h"

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

mrb_value mrb_image_copy(mrb_state *mrb, mrb_value) {
  Image *image;
  mrb_get_args(mrb, "d", &image, &Image_type);

  Image *copy = (Image *)malloc(sizeof(Image));
  *copy = ImageCopy(*image);

  mrb_value obj = mrb_obj_value(Data_Wrap_Struct(mrb, Image_class, &Image_type, copy));

  setup_Image(mrb, obj, copy, copy->width, copy->height, copy->mipmaps, copy->format);

  return obj;
}

mrb_value mrb_image_from_image(mrb_state *mrb, mrb_value) {
  Image *image;
  Rectangle *rectangle;
  mrb_get_args(mrb, "dd", &image, &Image_type, &rectangle, &Rectangle_type);

  Image *result = (Image *)malloc(sizeof(Image));
  *result = ImageFromImage(*image, *rectangle);

  mrb_value obj = mrb_obj_value(Data_Wrap_Struct(mrb, Image_class, &Image_type, result));

  setup_Image(mrb, obj, result, result->width, result->height, result->mipmaps, result->format);

  return obj;
}

mrb_value mrb_image_text_ex(mrb_state *mrb, mrb_value) {
  Font *font;
  mrb_value text;
  mrb_float font_size, spacing;
  Color *colour;
  mrb_get_args(mrb, "dSffd", &font, &Font_type, &text, &font_size, &spacing, &colour, &Colour_type);

  Image *result = (Image *)malloc(sizeof(Image));
  *result = ImageTextEx(*font, mrb_str_to_cstr(mrb, text), font_size, spacing, *colour);

  mrb_value obj = mrb_obj_value(Data_Wrap_Struct(mrb, Image_class, &Image_type, result));

  setup_Image(mrb, obj, result, result->width, result->height, result->mipmaps, result->format);

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

  mrb_define_method(mrb, mrb->kernel_module, "image_copy", mrb_image_copy, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "image_from_image", mrb_image_from_image, MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb->kernel_module, "image_text_ex", mrb_image_text_ex, MRB_ARGS_REQ(5));

  mrb_define_method(mrb, mrb->kernel_module, "generate_image_colour", mrb_generate_image_colour, MRB_ARGS_REQ(3));

  mrb_define_method(mrb, mrb->kernel_module, "get_screen_data", mrb_get_screen_data, MRB_ARGS_NONE());
}