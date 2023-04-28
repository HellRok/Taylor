#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/compile.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

struct RClass *Rectangle_class;

void setup_Rectangle(mrb_state *mrb, mrb_value object, Rectangle *rectangle, float x, float y, float width, float height)
{
  ivar_attr_float(mrb, object, rectangle->x, x);
  ivar_attr_float(mrb, object, rectangle->y, y);
  ivar_attr_float(mrb, object, rectangle->width, width);
  ivar_attr_float(mrb, object, rectangle->height, height);
}

mrb_value mrb_Rectangle_initialize(mrb_state *mrb, mrb_value self)
{
  mrb_float x, y, width, height;
  mrb_get_args(mrb, "ffff", &x, &y, &width, &height);

  Rectangle *rectangle = (struct Rectangle *)DATA_PTR(self);
  if (rectangle)
  {
    mrb_free(mrb, rectangle);
  }
  mrb_data_init(self, nullptr, &Rectangle_type);
  rectangle = (Rectangle *)malloc(sizeof(Rectangle));

  setup_Rectangle(mrb, self, rectangle, x, y, width, height);

  mrb_data_init(self, rectangle, &Rectangle_type);
  return self;
}

mrb_value mrb_Rectangle_set_x(mrb_state *mrb, mrb_value self)
{
  attr_setter_float(mrb, self, Rectangle_type, Rectangle, x, x);
}

mrb_value mrb_Rectangle_set_y(mrb_state *mrb, mrb_value self)
{
  attr_setter_float(mrb, self, Rectangle_type, Rectangle, y, y);
}

mrb_value mrb_Rectangle_set_width(mrb_state *mrb, mrb_value self)
{
  attr_setter_float(mrb, self, Rectangle_type, Rectangle, width, width);
}

mrb_value mrb_Rectangle_set_height(mrb_state *mrb, mrb_value self)
{
  attr_setter_float(mrb, self, Rectangle_type, Rectangle, height, height);
}

void append_models_Rectangle(mrb_state *mrb)
{
  Rectangle_class = mrb_define_class(mrb, "Rectangle", mrb->object_class);
  MRB_SET_INSTANCE_TT(Rectangle_class, MRB_TT_DATA);
  mrb_define_method(mrb, Rectangle_class, "initialize", mrb_Rectangle_initialize, MRB_ARGS_REQ(4));
  mrb_define_method(mrb, Rectangle_class, "x=", mrb_Rectangle_set_x, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Rectangle_class, "y=", mrb_Rectangle_set_y, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Rectangle_class, "width=", mrb_Rectangle_set_width, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Rectangle_class, "height=", mrb_Rectangle_set_height, MRB_ARGS_REQ(1));

  mrb_load_string(mrb, R"(
    class Rectangle
      attr_reader :x, :y, :width, :height

      def to_h
        {
          x: x,
          y: y,
          width: width,
          height: height,
        }
      end

      def draw(
        origin: Vector2::ZERO,
        rotation: 0,    # only usable when outline and rounded are false
        outline: false,
        thickness: 2,   # only used when outline is true
        rounded: false,
        radius: 0.5,    # only used when rounded is true
        segments: 8,    # only used when rounded is true
        colour: BLACK
      )

        if rounded
          unless (0..1).include?(radius)
            raise ArgumentError, "Radius must fall between 0 and 1, you gave me #{radius}"
          end

          if outline
            draw_rectangle_rounded_lines(self, radius, segments, thickness, colour)
          else
            draw_rectangle_rounded(self, radius, segments, colour)
          end
        else
          if outline
            draw_rectangle_lines_ex(self, thickness, colour)
          else
            draw_rectangle_pro(self, origin, rotation, colour)
          end
        end
      end
    end
  )");
}
