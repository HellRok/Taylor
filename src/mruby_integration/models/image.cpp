#include "mruby.h"
#include "mruby/array.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"
#include <cstdlib>
#include <cstring>

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
mrb_Image_generate(mrb_state* mrb, mrb_value) -> mrb_value
{
  // def self.generate(width:, height:, colour: Colour::BLANK)
  mrb_int kw_num = 3;
  mrb_int kw_required = 2;
  mrb_sym kw_names[] = { mrb_intern_lit(mrb, "width"),
                         mrb_intern_lit(mrb, "height"),
                         mrb_intern_lit(mrb, "colour") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  int width = 0;
  if (!mrb_undef_p(kw_values[0])) {
    width = mrb_as_int(mrb, kw_values[0]);
  }

  int height = 0;
  if (!mrb_undef_p(kw_values[1])) {
    height = mrb_as_int(mrb, kw_values[1]);
  }

  Color* colour;
  if (mrb_undef_p(kw_values[2])) {
    auto default_colour = Color{ 0, 0, 0, 0 };
    colour = &default_colour;
  } else {
    colour = static_cast<struct Color*> DATA_PTR(kw_values[2]);
  }

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
mrb_Image_copy(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Image* image;

  Data_Get_Struct(mrb, self, &Image_type, image);
  mrb_assert(image != nullptr);

  // def copy(source: Rectangle[0, 0, width, height])
  mrb_int kw_num = 1;
  mrb_int kw_required = 0;
  mrb_sym kw_names[] = { mrb_intern_lit(mrb, "source") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  Rectangle* source;
  if (mrb_undef_p(kw_values[0])) {
    auto default_source = Rectangle{
      0, 0, static_cast<float>(image->width), static_cast<float>(image->height)
    };
    source = &default_source;
  } else {
    source = static_cast<struct Rectangle*> DATA_PTR(kw_values[0]);
  }

  auto* result = static_cast<Image*>(malloc(sizeof(Image)));
  *result = ImageFromImage(*image, *source);

  mrb_value obj =
    mrb_obj_value(Data_Wrap_Struct(mrb, Image_class, &Image_type, result));

  setup_Image(mrb,
              obj,
              result,
              result->width,
              result->height,
              result->mipmaps,
              result->format);

  return obj;
}

auto
mrb_Image_resize_bang(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Image* image;

  Data_Get_Struct(mrb, self, &Image_type, image);
  mrb_assert(image != nullptr);

  // def resize!(width:, height:, sizing: :nearest_neighbour)
  mrb_int kw_num = 3;
  mrb_int kw_required = 2;
  mrb_sym kw_names[] = {
    mrb_intern_lit(mrb, "width"),
    mrb_intern_lit(mrb, "height"),
    mrb_intern_lit(mrb, "scaler"),
  };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  int width = 0;
  if (!mrb_undef_p(kw_values[0])) {
    width = mrb_as_int(mrb, kw_values[0]);
  }

  int height = 0;
  if (!mrb_undef_p(kw_values[1])) {
    height = mrb_as_int(mrb, kw_values[1]);
  }

  const char* scaler;
  if (mrb_undef_p(kw_values[2])) {
    scaler = "nearest_neighbour";
  } else {
    mrb_sym sym = mrb_obj_to_sym(mrb, kw_values[2]);
    scaler = mrb_sym_name(mrb, sym);
  }

  if (strcmp(scaler, "nearest_neighbour") == 0) {
    ImageResizeNN(image, width, height);
  } else if (strcmp(scaler, "bicubic") == 0) {
    ImageResize(image, width, height);
  } else {
    mrb_raise(mrb,
              E_ARGUMENT_ERROR,
              "Invalid scaler provided, you must provide :bicubic or "
              ":nearest_neighbour");
  }

  mrb_iv_set(
    mrb, self, mrb_intern_cstr(mrb, "@width"), mrb_int_value(mrb, width));
  mrb_iv_set(
    mrb, self, mrb_intern_cstr(mrb, "@height"), mrb_int_value(mrb, height));

  return self;
}

auto
mrb_Image_crop_bang(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Image* image;

  Data_Get_Struct(mrb, self, &Image_type, image);
  mrb_assert(image != nullptr);

  // def crop!(source:)
  mrb_int kw_num = 1;
  mrb_int kw_required = 1;
  mrb_sym kw_names[] = {
    mrb_intern_lit(mrb, "source"),
  };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  Rectangle* source;
  if (mrb_undef_p(kw_values[0])) {
    auto default_source = Rectangle{
      0, 0, static_cast<float>(image->width), static_cast<float>(image->height)
    };
    source = &default_source;
  } else {
    source = static_cast<struct Rectangle*> DATA_PTR(kw_values[0]);
  }

  ImageCrop(image, *source);

  mrb_iv_set(mrb,
             self,
             mrb_intern_cstr(mrb, "@width"),
             mrb_int_value(mrb, source->width));
  mrb_iv_set(mrb,
             self,
             mrb_intern_cstr(mrb, "@height"),
             mrb_int_value(mrb, source->height));

  return self;
}

auto
mrb_Image_alpha_mask_bang(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Image *image, *alpha_mask;

  Data_Get_Struct(mrb, self, &Image_type, image);
  mrb_assert(image != nullptr);

  mrb_get_args(mrb, "d", &alpha_mask, &Image_type);

  ImageAlphaMask(image, *alpha_mask);

  return self;
}

auto
mrb_Image_flip_vertically_bang(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Image* image;

  Data_Get_Struct(mrb, self, &Image_type, image);
  mrb_assert(image != nullptr);

  ImageFlipVertical(image);

  return self;
}

auto
mrb_Image_flip_horizontally_bang(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Image* image;

  Data_Get_Struct(mrb, self, &Image_type, image);
  mrb_assert(image != nullptr);

  ImageFlipHorizontal(image);

  return self;
}

auto
mrb_Image_rotate_clockwise_bang(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Image* image;

  Data_Get_Struct(mrb, self, &Image_type, image);
  mrb_assert(image != nullptr);

  ImageRotateCW(image);

  return self;
}

auto
mrb_Image_rotate_counter_clockwise_bang(mrb_state* mrb, mrb_value self)
  -> mrb_value
{
  Image* image;

  Data_Get_Struct(mrb, self, &Image_type, image);
  mrb_assert(image != nullptr);

  ImageRotateCCW(image);

  return self;
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
  mrb_define_class_method(
    mrb, Image_class, "generate", mrb_Image_generate, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Image_class, "initialize", mrb_Image_initialize, MRB_ARGS_REQ(5));
  mrb_define_method(
    mrb, Image_class, "unload", mrb_Image_unload, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Image_class, "export", mrb_Image_export, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Image_class, "copy", mrb_Image_copy, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Image_class, "resize!", mrb_Image_resize_bang, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Image_class, "crop!", mrb_Image_crop_bang, MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    Image_class,
                    "alpha_mask!",
                    mrb_Image_alpha_mask_bang,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    Image_class,
                    "flip_vertically!",
                    mrb_Image_flip_vertically_bang,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    Image_class,
                    "flip_horizontally!",
                    mrb_Image_flip_horizontally_bang,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    Image_class,
                    "rotate_clockwise!",
                    mrb_Image_rotate_clockwise_bang,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    Image_class,
                    "rotate_counter_clockwise!",
                    mrb_Image_rotate_counter_clockwise_bang,
                    MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Image_class, "data", mrb_Image_get_data, MRB_ARGS_NONE());

  load_ruby_models_image(mrb);
}
