#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"
#include <cstdlib>

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/rectangle.hpp"

struct RClass* Rectangle_class;

auto
mrb_Rectangle_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_float x, y, width, height;
  mrb_get_args(mrb, "ffff", &x, &y, &width, &height);

  Rectangle* rectangle = static_cast<struct Rectangle*> DATA_PTR(self);
  if (rectangle) {
    mrb_free(mrb, rectangle);
  }
  mrb_data_init(self, nullptr, &Rectangle_type);
  rectangle = static_cast<Rectangle*>(malloc(sizeof(Rectangle)));

  ivar_attr_float(mrb, self, rectangle->x, x);
  ivar_attr_float(mrb, self, rectangle->y, y);
  ivar_attr_float(mrb, self, rectangle->width, width);
  ivar_attr_float(mrb, self, rectangle->height, height);

  mrb_data_init(self, rectangle, &Rectangle_type);
  return self;
}

auto
mrb_Rectangle_set_x(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_float(mrb, self, Rectangle_type, Rectangle, x, x);
}

auto
mrb_Rectangle_set_y(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_float(mrb, self, Rectangle_type, Rectangle, y, y);
}

auto
mrb_Rectangle_set_width(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_float(mrb, self, Rectangle_type, Rectangle, width, width);
}

auto
mrb_Rectangle_set_height(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_float(mrb, self, Rectangle_type, Rectangle, height, height);
}

void
append_models_Rectangle(mrb_state* mrb)
{
  Rectangle_class = mrb_define_class(mrb, "Rectangle", mrb->object_class);
  MRB_SET_INSTANCE_TT(Rectangle_class, MRB_TT_DATA);
  mrb_define_method(mrb,
                    Rectangle_class,
                    "initialize",
                    mrb_Rectangle_initialize,
                    MRB_ARGS_REQ(4));
  mrb_define_method(
    mrb, Rectangle_class, "x=", mrb_Rectangle_set_x, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Rectangle_class, "y=", mrb_Rectangle_set_y, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Rectangle_class, "width=", mrb_Rectangle_set_width, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Rectangle_class, "height=", mrb_Rectangle_set_height, MRB_ARGS_REQ(1));

  load_ruby_models_rectangle(mrb);
}
