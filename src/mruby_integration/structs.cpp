#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"

#include "mruby_integration/struct_types.hpp"

mrb_value MrbColourInitialize(mrb_state *mrb, mrb_value self) {
  mrb_int red, green, blue, alpha;
  mrb_get_args(mrb, "iiii", &red, &green, &blue, &alpha);

  Color *colour = (struct Color *)DATA_PTR(self);
  if (colour) { mrb_free(mrb, colour); }
  mrb_data_init(self, nullptr, &Colour_type);
  colour = (Color *)malloc(sizeof(Color));

  colour->r = red;
  colour->g = green;
  colour->b = blue;
  colour->a = alpha;

  mrb_data_init(self, colour, &Colour_type);

  return self;
}

mrb_value MrbColourGetRed(mrb_state *mrb, mrb_value self) {
  Color *colour;

  Data_Get_Struct(mrb, self, &Colour_type, colour);
  mrb_assert(colour != nullptr);

  return mrb_int_value(mrb, colour->r);
}

mrb_value MrbColourSetRed(mrb_state *mrb, mrb_value self) {
  mrb_int red;
  mrb_get_args(mrb, "i", &red);
  Color *colour;

  Data_Get_Struct(mrb, self, &Colour_type, colour);
  mrb_assert(colour != nullptr);

  colour->r = red;

  return mrb_int_value(mrb, colour->r);
}

mrb_value MrbColourGetGreen(mrb_state *mrb, mrb_value self) {
  Color *colour;

  Data_Get_Struct(mrb, self, &Colour_type, colour);
  mrb_assert(colour != nullptr);

  return mrb_int_value(mrb, colour->g);
}

mrb_value MrbColourSetGreen(mrb_state *mrb, mrb_value self) {
  mrb_int green;
  mrb_get_args(mrb, "i", &green);
  Color *colour;

  Data_Get_Struct(mrb, self, &Colour_type, colour);
  mrb_assert(colour != nullptr);

  colour->g = green;

  return mrb_int_value(mrb, colour->g);
}

mrb_value MrbColourGetBlue(mrb_state *mrb, mrb_value self) {
  Color *colour;

  Data_Get_Struct(mrb, self, &Colour_type, colour);
  mrb_assert(colour != nullptr);

  return mrb_int_value(mrb, colour->b);
}

mrb_value MrbColourSetBlue(mrb_state *mrb, mrb_value self) {
  mrb_int blue;
  mrb_get_args(mrb, "i", &blue);
  Color *colour;

  Data_Get_Struct(mrb, self, &Colour_type, colour);
  mrb_assert(colour != nullptr);

  colour->b = blue;

  return mrb_int_value(mrb, colour->b);
}

mrb_value MrbColourGetAlpha(mrb_state *mrb, mrb_value self) {
  Color *colour;

  Data_Get_Struct(mrb, self, &Colour_type, colour);
  mrb_assert(colour != nullptr);

  return mrb_int_value(mrb, colour->a);
}

mrb_value MrbColourSetAlpha(mrb_state *mrb, mrb_value self) {
  mrb_int alpha;
  mrb_get_args(mrb, "i", &alpha);
  Color *colour;

  Data_Get_Struct(mrb, self, &Colour_type, colour);
  mrb_assert(colour != nullptr);

  colour->a = alpha;

  return mrb_int_value(mrb, colour->a);
}

void appendStructs(mrb_state *mrb) {
  struct RClass *colour_class;
  colour_class = mrb_define_class(mrb, "Colour", mrb->object_class);
  MRB_SET_INSTANCE_TT(colour_class, MRB_TT_DATA);
  mrb_define_method(mrb, colour_class, "initialize", MrbColourInitialize, MRB_ARGS_REQ(4));
  mrb_define_method(mrb, colour_class, "red", MrbColourGetRed, MRB_ARGS_NONE());
  mrb_define_method(mrb, colour_class, "red=", MrbColourSetRed, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, colour_class, "green", MrbColourGetGreen, MRB_ARGS_NONE());
  mrb_define_method(mrb, colour_class, "green=", MrbColourSetGreen, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, colour_class, "blue", MrbColourGetBlue, MRB_ARGS_NONE());
  mrb_define_method(mrb, colour_class, "blue=", MrbColourSetBlue, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, colour_class, "alpha", MrbColourGetAlpha, MRB_ARGS_NONE());
  mrb_define_method(mrb, colour_class, "alpha=", MrbColourSetAlpha, MRB_ARGS_REQ(1));
}
