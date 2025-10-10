#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"

#include "mruby_integration/exceptions.hpp"
#include "mruby_integration/helpers.hpp"
#include "mruby_integration/models/rectangle.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/texture2d.hpp"

struct RClass* Texture2D_class;

void
setup_Texture2D(mrb_state* mrb,
                mrb_value object,
                Texture2D* texture,
                int id,
                int width,
                int height,
                int mipmaps,
                int format)
{
  ivar_attr_int(mrb, object, texture->id, id);
  ivar_attr_int(mrb, object, texture->width, width);
  ivar_attr_int(mrb, object, texture->height, height);
  ivar_attr_int(mrb, object, texture->mipmaps, mipmaps);
  ivar_attr_int(mrb, object, texture->format, format);
}

auto
mrb_Texture2D_value(mrb_state* mrb, Texture2D* texture) -> mrb_value
{
  mrb_value obj = mrb_obj_value(
    Data_Wrap_Struct(mrb, Texture2D_class, &Texture2D_type, texture));

  setup_Texture2D(mrb,
                  obj,
                  texture,
                  texture->id,
                  texture->width,
                  texture->height,
                  texture->mipmaps,
                  texture->format);

  return obj;
}

auto
mrb_Texture2D_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  char* path;
  mrb_get_args(mrb, "z", &path);

  if (!FileExists(path)) {
    raise_not_found_error(mrb, Texture2D_class, path);
  }

  Texture2D* texture;
  mrb_self_ptr(mrb, self, Texture2D, texture);

  *texture = LoadTexture(path);

  setup_Texture2D(mrb,
                  self,
                  texture,
                  texture->id,
                  texture->width,
                  texture->height,
                  texture->mipmaps,
                  texture->format);

  mrb_iv_set(mrb,
             self,
             mrb_intern_cstr(mrb, "@filter"),
             mrb_int_value(mrb, TEXTURE_FILTER_POINT));

  mrb_data_init(self, texture, &Texture2D_type);
  return self;
}

auto
mrb_Texture2D_unload(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Texture2D, texture);

  UnloadTexture(*texture);

  return mrb_nil_value();
}

auto
mrb_Texture2D_valid(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Texture2D, texture);

  return mrb_bool_value(IsTextureValid(*texture));
}

auto
mrb_Texture2D_set_filter(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_int filter;
  mrb_get_args(mrb, "i", &filter);

  if (filter < 0 || filter > 5) {
    mrb_raise(mrb,
              E_ARGUMENT_ERROR,
              "Filter must be one of: Texture2D::NO_FILTER, "
              "Texture2D::BILINEAR, Texture2D::TRILINEAR, "
              "Texture2D::ANISOTROPIC_4X, Texture2D::ANISOTROPIC_8X, "
              "or Texture2D::ANISOTROPIC_16X");
  }

  mrb_get_self(mrb, self, Texture2D, texture);

  SetTextureFilter(*texture, filter);
  mrb_iv_set(
    mrb, self, mrb_intern_cstr(mrb, "@filter"), mrb_int_value(mrb, filter));

  return mrb_nil_value();
}

auto
mrb_Texture2D_generate_mipmaps(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Texture2D, texture);

  GenTextureMipmaps(texture);

  return mrb_nil_value();
}

auto
mrb_Texture2D_draw(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Texture2D, texture);

  // def draw(source: Rectangle[0, 0, width, height], position: nil,
  // destination: nil, origin: Vector2[width / 2.0, height / 2.0], rotation: 0,
  // colour: Colour::WHITE)

  const mrb_int kw_num = 6;
  const mrb_int kw_required = 0;
  const mrb_sym kw_names[] = {
    mrb_intern_lit(mrb, "source"),      mrb_intern_lit(mrb, "position"),
    mrb_intern_lit(mrb, "destination"), mrb_intern_lit(mrb, "origin"),
    mrb_intern_lit(mrb, "rotation"),    mrb_intern_lit(mrb, "colour")
  };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  if (!mrb_undef_p(kw_values[1]) && !mrb_undef_p(kw_values[2])) {
    mrb_raise(
      mrb, E_ARGUMENT_ERROR, "Can't specify both position and destination");
  }

  Rectangle* source;
  if (mrb_undef_p(kw_values[0])) {
    auto default_rectangle = Rectangle{ 0,
                                        0,
                                        static_cast<float>(texture->width),
                                        static_cast<float>(texture->height) };
    source = &default_rectangle;
  } else {
    source = &static_cast<struct Rektangle*> DATA_PTR(kw_values[0])->rectangle;
  }

  Vector2* position;
  if (mrb_undef_p(kw_values[1])) {
    auto default_position = Vector2{ 0, 0 };
    position = &default_position;
  } else {
    position = static_cast<struct Vector2*> DATA_PTR(kw_values[1]);
  }

  Rectangle* destination;
  if (mrb_undef_p(kw_values[2])) {
    auto default_destination =
      Rectangle{ position->x, position->y, source->width, source->height };
    destination = &default_destination;
  } else {
    destination =
      &static_cast<struct Rektangle*> DATA_PTR(kw_values[2])->rectangle;
  }

  Vector2* origin;
  if (mrb_undef_p(kw_values[3])) {
    auto default_origin =
      Vector2{ (destination->width / 2.0f), (destination->height / 2.0f) };
    origin = &default_origin;
  } else {
    origin = static_cast<struct Vector2*> DATA_PTR(kw_values[3]);
  }

  float rotation = 0;
  if (!mrb_undef_p(kw_values[4])) {
    rotation = mrb_as_float(mrb, kw_values[4]);
  }

  Color* colour;
  if (mrb_undef_p(kw_values[5])) {
    auto default_colour = Color{ 255, 255, 255, 255 };
    colour = &default_colour;
  } else {
    colour = static_cast<struct Color*> DATA_PTR(kw_values[5]);
  }

  DrawTexturePro(*texture, *source, *destination, *origin, rotation, *colour);

  return mrb_nil_value();
}

void
append_models_Texture2D(mrb_state* mrb)
{
  Texture2D_class = mrb_define_class(mrb, "Texture2D", mrb->object_class);
  MRB_SET_INSTANCE_TT(Texture2D_class, MRB_TT_DATA);
  mrb_define_method(mrb,
                    Texture2D_class,
                    "initialize",
                    mrb_Texture2D_initialize,
                    MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Texture2D_class, "unload", mrb_Texture2D_unload, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Texture2D_class, "valid?", mrb_Texture2D_valid, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Texture2D_class, "filter=", mrb_Texture2D_set_filter, MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    Texture2D_class,
                    "generate_mipmaps",
                    mrb_Texture2D_generate_mipmaps,
                    MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Texture2D_class, "draw", mrb_Texture2D_draw, MRB_ARGS_REQ(1));

  load_ruby_models_texture2d(mrb);
}
