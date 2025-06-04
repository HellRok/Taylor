#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "mruby/string.h"
#include "raylib.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/models/colour.hpp"
#include "mruby_integration/models/texture2d.hpp"
#include "mruby_integration/struct_types.hpp"

auto
mrb_set_texture_filter(mrb_state* mrb, mrb_value) -> mrb_value
{
  Texture2D* texture;
  mrb_int filter;

  mrb_get_args(mrb, "di", &texture, &Texture2D_type, &filter);

  SetTextureFilter(*texture, filter);

  return mrb_nil_value();
}

auto
mrb_gen_texture_mipmaps(mrb_state* mrb, mrb_value) -> mrb_value
{
  Texture2D* texture;

  mrb_get_args(mrb, "d", &texture, &Texture2D_type);

  GenTextureMipmaps(texture);

  return mrb_nil_value();
}

auto
mrb_draw_texture(mrb_state* mrb, mrb_value) -> mrb_value
{
  Texture2D* texture;
  mrb_int x, y;
  Color* colour;

  mrb_get_args(
    mrb, "diid", &texture, &Texture2D_type, &x, &y, &colour, &Colour_type);

  DrawTexture(*texture, x, y, *colour);

  return mrb_nil_value();
}

auto
mrb_draw_texture_pro(mrb_state* mrb, mrb_value) -> mrb_value
{
  Texture2D* texture;
  Vector2* origin;
  Rectangle *source, *destination;
  mrb_float rotation;
  Color* colour;

  mrb_get_args(mrb,
               "ddddfd",
               &texture,
               &Texture2D_type,
               &source,
               &Rectangle_type,
               &destination,
               &Rectangle_type,
               &origin,
               &Vector2_type,
               &rotation,
               &colour,
               &Colour_type);

  DrawTexturePro(*texture, *source, *destination, *origin, rotation, *colour);

  return mrb_nil_value();
}

auto
mrb_fade(mrb_state* mrb, mrb_value) -> mrb_value
{
  Color* colour;
  mrb_float alpha;
  mrb_get_args(mrb, "df", &colour, &Colour_type, &alpha);

  auto* return_colour = static_cast<Color*>(malloc(sizeof(Color)));
  *return_colour = Fade(*colour, alpha);

  mrb_value obj = mrb_obj_value(
    Data_Wrap_Struct(mrb, Colour_class, &Colour_type, return_colour));

  setup_Colour(mrb,
               obj,
               return_colour,
               return_colour->r,
               return_colour->g,
               return_colour->b,
               return_colour->a);

  return obj;
}

void
append_textures(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_texture_filter",
                    mrb_set_texture_filter,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "generate_texture_mipmaps",
                    mrb_gen_texture_mipmaps,
                    MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, mrb->kernel_module, "draw_texture", mrb_draw_texture, MRB_ARGS_REQ(4));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "draw_texture_pro",
                    mrb_draw_texture_pro,
                    MRB_ARGS_REQ(6));

  mrb_define_method(mrb, mrb->kernel_module, "fade", mrb_fade, MRB_ARGS_REQ(2));
}
