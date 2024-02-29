#include "mruby.h"
#include "mruby/string.h"
#include "mruby/variable.h"
#include "raylib.h"

#include "mruby_integration/models/image.hpp"
#include "mruby_integration/struct_types.hpp"

auto
mrb_generate_image_colour(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int width, height;
  Color* colour;
  mrb_get_args(mrb, "iid", &width, &height, &colour, &Colour_type);

  auto* image = static_cast<Image*>(malloc(sizeof(Image)));
  *image = GenImageColor(width, height, *colour);

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

auto
mrb_image_resize(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_value image_obj;
  mrb_int width, height;
  mrb_get_args(mrb, "oii", &image_obj, &width, &height);

  auto* image =
    static_cast<Image*>(mrb_data_get_ptr(mrb, image_obj, &Image_type));

  ImageResize(image, width, height);

  mrb_iv_set(
    mrb, image_obj, mrb_intern_cstr(mrb, "@width"), mrb_int_value(mrb, width));
  mrb_iv_set(mrb,
             image_obj,
             mrb_intern_cstr(mrb, "@height"),
             mrb_int_value(mrb, height));

  return mrb_nil_value();
}

auto
mrb_image_crop(mrb_state* mrb, mrb_value) -> mrb_value
{
  Rectangle* rectangle;
  mrb_value image_obj;
  mrb_get_args(mrb, "od", &image_obj, &rectangle, &Rectangle_type);

  auto* image =
    static_cast<Image*>(mrb_data_get_ptr(mrb, image_obj, &Image_type));

  ImageCrop(image, *rectangle);

  mrb_iv_set(mrb,
             image_obj,
             mrb_intern_cstr(mrb, "@width"),
             mrb_int_value(mrb, rectangle->width));
  mrb_iv_set(mrb,
             image_obj,
             mrb_intern_cstr(mrb, "@height"),
             mrb_int_value(mrb, rectangle->height));

  return mrb_nil_value();
}

auto
mrb_image_alpha_mask(mrb_state* mrb, mrb_value) -> mrb_value
{
  Image *image, *alpha_mask;
  mrb_get_args(mrb, "dd", &image, &Image_type, &alpha_mask, &Image_type);

  ImageAlphaMask(image, *alpha_mask);

  return mrb_nil_value();
}

auto
mrb_image_alpha_premultiply(mrb_state* mrb, mrb_value) -> mrb_value
{
  Image* image;
  mrb_get_args(mrb, "d", &image, &Image_type);

  ImageAlphaPremultiply(image);

  return mrb_nil_value();
}

auto
mrb_image_flip_vertical(mrb_state* mrb, mrb_value) -> mrb_value
{
  Image* image;
  mrb_get_args(mrb, "d", &image, &Image_type);

  ImageFlipVertical(image);

  return mrb_nil_value();
}

auto
mrb_image_mipmaps(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_value image_obj;
  mrb_get_args(mrb, "o", &image_obj);

  auto* image =
    static_cast<Image*>(mrb_data_get_ptr(mrb, image_obj, &Image_type));

  ImageMipmaps(image);

  mrb_iv_set(mrb,
             image_obj,
             mrb_intern_cstr(mrb, "@mipmaps"),
             mrb_int_value(mrb, image->mipmaps));

  return mrb_nil_value();
}

auto
mrb_image_flip_horizontal(mrb_state* mrb, mrb_value) -> mrb_value
{
  Image* image;
  mrb_get_args(mrb, "d", &image, &Image_type);

  ImageFlipHorizontal(image);

  return mrb_nil_value();
}

auto
mrb_image_rotate_cw(mrb_state* mrb, mrb_value) -> mrb_value
{
  Image* image;
  mrb_get_args(mrb, "d", &image, &Image_type);

  ImageRotateCW(image);

  return mrb_nil_value();
}

auto
mrb_image_rotate_ccw(mrb_state* mrb, mrb_value) -> mrb_value
{
  Image* image;
  mrb_get_args(mrb, "d", &image, &Image_type);

  ImageRotateCCW(image);

  return mrb_nil_value();
}

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
mrb_image_resize_nearest_neighbour(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_value image_obj;
  mrb_int width, height;
  mrb_get_args(mrb, "oii", &image_obj, &width, &height);

  auto* image =
    static_cast<Image*>(mrb_data_get_ptr(mrb, image_obj, &Image_type));

  ImageResizeNN(image, width, height);

  mrb_iv_set(
    mrb, image_obj, mrb_intern_cstr(mrb, "@width"), mrb_int_value(mrb, width));
  mrb_iv_set(mrb,
             image_obj,
             mrb_intern_cstr(mrb, "@height"),
             mrb_int_value(mrb, height));

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
  mrb_define_method(
    mrb, mrb->kernel_module, "image_crop!", mrb_image_crop, MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "image_alpha_mask!",
                    mrb_image_alpha_mask,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "image_alpha_premultiply!",
                    mrb_image_alpha_premultiply,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "image_mipmaps!",
                    mrb_image_mipmaps,
                    MRB_ARGS_REQ(1));

  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "image_resize!",
                    mrb_image_resize,
                    MRB_ARGS_REQ(3));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "image_resize_nearest_neighbour!",
                    mrb_image_resize_nearest_neighbour,
                    MRB_ARGS_REQ(3));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "image_flip_vertical!",
                    mrb_image_flip_vertical,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "image_flip_horizontal!",
                    mrb_image_flip_horizontal,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "image_rotate_cw!",
                    mrb_image_rotate_cw,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "image_rotate_ccw!",
                    mrb_image_rotate_ccw,
                    MRB_ARGS_REQ(1));

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

  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "generate_image_colour",
                    mrb_generate_image_colour,
                    MRB_ARGS_REQ(3));

  mrb_define_method(
    mrb, mrb->kernel_module, "image_draw!", mrb_image_draw, MRB_ARGS_REQ(5));

  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_screen_data",
                    mrb_get_screen_data,
                    MRB_ARGS_NONE());
}
