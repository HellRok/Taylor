#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

struct RClass *Vector2_class;

mrb_value mrb_Vector2_initialize(mrb_state *mrb, mrb_value self) {
  mrb_float x, y;
  mrb_get_args(mrb, "ff", &x, &y);

  Vector2 *vector2 = (struct Vector2 *)DATA_PTR(self);
  if (vector2) { mrb_free(mrb, vector2); }
  mrb_data_init(self, nullptr, &Vector2_type);
  vector2 = (Vector2 *)malloc(sizeof(Vector2));

  vector2->x = x;
  vector2->y = y;

  mrb_data_init(self, vector2, &Vector2_type);
  return self;
}

mrb_value mrb_Vector2_get_x(mrb_state *mrb, mrb_value self) {
  attr_reader_float(mrb, self, Vector2_type, Vector2, x);
}

mrb_value mrb_Vector2_set_x(mrb_state *mrb, mrb_value self) {
  attr_setter_float(mrb, self, Vector2_type, Vector2, x);
}

mrb_value mrb_Vector2_get_y(mrb_state *mrb, mrb_value self) {
  attr_reader_float(mrb, self, Vector2_type, Vector2, y);
}

mrb_value mrb_Vector2_set_y(mrb_state *mrb, mrb_value self) {
  attr_setter_float(mrb, self, Vector2_type, Vector2, y);
}

void append_models_Vector2(mrb_state *mrb) {
  Vector2_class = mrb_define_class(mrb, "Vector2", mrb->object_class);
  MRB_SET_INSTANCE_TT(Vector2_class, MRB_TT_DATA);
  mrb_define_method(mrb, Vector2_class, "initialize", mrb_Vector2_initialize, MRB_ARGS_REQ(4));
  mrb_define_method(mrb, Vector2_class, "x", mrb_Vector2_get_x, MRB_ARGS_NONE());
  mrb_define_method(mrb, Vector2_class, "x=", mrb_Vector2_set_x, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Vector2_class, "y", mrb_Vector2_get_y, MRB_ARGS_NONE());
  mrb_define_method(mrb, Vector2_class, "y=", mrb_Vector2_set_y, MRB_ARGS_REQ(1));
}
