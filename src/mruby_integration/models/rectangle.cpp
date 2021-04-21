#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

struct RClass *Rectangle_class;

mrb_value mrb_Rectangle_initialize(mrb_state *mrb, mrb_value self) {
  mrb_float x, y, width, height;
  mrb_get_args(mrb, "ffff", &x, &y, &width, &height);

  Rectangle *rectangle = (struct Rectangle *)DATA_PTR(self);
  if (rectangle) { mrb_free(mrb, rectangle); }
  mrb_data_init(self, nullptr, &Rectangle_type);
  rectangle = (Rectangle *)malloc(sizeof(Rectangle));

  rectangle->x = x;
  rectangle->y = y;
  rectangle->width = width;
  rectangle->height = height;

  mrb_data_init(self, rectangle, &Rectangle_type);
  return self;
}

mrb_value mrb_Rectangle_get_x(mrb_state *mrb, mrb_value self) {
  attr_reader_float(mrb, self, Rectangle_type, Rectangle, x);
}

mrb_value mrb_Rectangle_set_x(mrb_state *mrb, mrb_value self) {
  attr_setter_float(mrb, self, Rectangle_type, Rectangle, x);
}

mrb_value mrb_Rectangle_get_y(mrb_state *mrb, mrb_value self) {
  attr_reader_float(mrb, self, Rectangle_type, Rectangle, y);
}

mrb_value mrb_Rectangle_set_y(mrb_state *mrb, mrb_value self) {
  attr_setter_float(mrb, self, Rectangle_type, Rectangle, y);
}

mrb_value mrb_Rectangle_get_width(mrb_state *mrb, mrb_value self) {
  attr_reader_float(mrb, self, Rectangle_type, Rectangle, width);
}

mrb_value mrb_Rectangle_set_width(mrb_state *mrb, mrb_value self) {
  attr_setter_float(mrb, self, Rectangle_type, Rectangle, width);
}

mrb_value mrb_Rectangle_get_height(mrb_state *mrb, mrb_value self) {
  attr_reader_float(mrb, self, Rectangle_type, Rectangle, height);
}

mrb_value mrb_Rectangle_set_height(mrb_state *mrb, mrb_value self) {
  attr_setter_float(mrb, self, Rectangle_type, Rectangle, height);
}

void append_models_Rectangle(mrb_state *mrb) {
  Rectangle_class = mrb_define_class(mrb, "Rectangle", mrb->object_class);
  MRB_SET_INSTANCE_TT(Rectangle_class, MRB_TT_DATA);
  mrb_define_method(mrb, Rectangle_class, "initialize", mrb_Rectangle_initialize, MRB_ARGS_REQ(4));
  mrb_define_method(mrb, Rectangle_class, "x", mrb_Rectangle_get_x, MRB_ARGS_NONE());
  mrb_define_method(mrb, Rectangle_class, "x=", mrb_Rectangle_set_x, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Rectangle_class, "y", mrb_Rectangle_get_y, MRB_ARGS_NONE());
  mrb_define_method(mrb, Rectangle_class, "y=", mrb_Rectangle_set_y, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Rectangle_class, "width", mrb_Rectangle_get_width, MRB_ARGS_NONE());
  mrb_define_method(mrb, Rectangle_class, "width=", mrb_Rectangle_set_width, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Rectangle_class, "height", mrb_Rectangle_get_height, MRB_ARGS_NONE());
  mrb_define_method(mrb, Rectangle_class, "height=", mrb_Rectangle_set_height, MRB_ARGS_REQ(1));
}
