#include "mruby.h"
#include "mruby/string.h"
#include "mruby/variable.h"
#include "raylib.h"

#include "mruby_integration/models/image.hpp"
#include "mruby_integration/struct_types.hpp"

auto
mrb_image_colour_tint(mrb_state* mrb, mrb_value) -> mrb_value
{
  Image* image;
  Color* colour;
  mrb_get_args(mrb, "dd", &image, &Image_type, &colour, &Colour_type);

  ImageColorTint(image, *colour);

  return mrb_nil_value();
}

auto
mrb_image_colour_invert(mrb_state* mrb, mrb_value) -> mrb_value
{
  Image* image;
  mrb_get_args(mrb, "d", &image, &Image_type);

  ImageColorInvert(image);

  return mrb_nil_value();
}

auto
mrb_image_colour_grayscale(mrb_state* mrb, mrb_value) -> mrb_value
{
  Image* image;
  mrb_get_args(mrb, "d", &image, &Image_type);

  ImageColorGrayscale(image);

  return mrb_nil_value();
}

auto
mrb_image_colour_contrast(mrb_state* mrb, mrb_value) -> mrb_value
{
  Image* image;
  mrb_float contrast;
  mrb_get_args(mrb, "df", &image, &Image_type, &contrast);

  ImageColorContrast(image, contrast);

  return mrb_nil_value();
}

auto
mrb_image_colour_brightness(mrb_state* mrb, mrb_value) -> mrb_value
{
  Image* image;
  mrb_int brightness;
  mrb_get_args(mrb, "di", &image, &Image_type, &brightness);

  ImageColorBrightness(image, brightness);

  return mrb_nil_value();
}

auto
mrb_image_colour_replace(mrb_state* mrb, mrb_value) -> mrb_value
{
  Image* image;
  Color *old_colour, *new_colour;
  mrb_get_args(mrb,
               "ddd",
               &image,
               &Image_type,
               &old_colour,
               &Colour_type,
               &new_colour,
               &Colour_type);

  ImageColorReplace(image, *old_colour, *new_colour);

  return mrb_nil_value();
}

auto
mrb_image_draw(mrb_state* mrb, mrb_value) -> mrb_value
{
  Image *destination, *source;
  Rectangle *destination_rectangle, *source_rectangle;
  Color* colour;
  mrb_get_args(mrb,
               "ddddd",
               &destination,
               &Image_type,
               &source,
               &Image_type,
               &source_rectangle,
               &Rectangle_type,
               &destination_rectangle,
               &Rectangle_type,
               &colour,
               &Colour_type);

  ImageDraw(
    destination, *source, *source_rectangle, *destination_rectangle, *colour);

  return mrb_nil_value();
}

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
                    "image_colour_tint!",
                    mrb_image_colour_tint,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "image_colour_invert!",
                    mrb_image_colour_invert,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "image_colour_grayscale!",
                    mrb_image_colour_grayscale,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "image_colour_contrast!",
                    mrb_image_colour_contrast,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "image_colour_brightness!",
                    mrb_image_colour_brightness,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "image_colour_replace!",
                    mrb_image_colour_replace,
                    MRB_ARGS_REQ(3));

  mrb_define_method(
    mrb, mrb->kernel_module, "image_draw!", mrb_image_draw, MRB_ARGS_REQ(5));

  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_screen_data",
                    mrb_get_screen_data,
                    MRB_ARGS_NONE());
}
