#include "raylib.h"
#include "raygui.hpp"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/irep.h"
#include "mruby/compile.h"

mrb_value MrbInitWindow(mrb_state *mrb, mrb_value) {
  mrb_int width, height;
  char* title;

  mrb_get_args(mrb, "iiz", &width, &height, &title);

  InitWindow(width, height, title);
  return mrb_nil_value();
}

mrb_value MrbSetTargetFPS(mrb_state *mrb, mrb_value) {
  mrb_int fps;

  mrb_get_args(mrb, "i", &fps);

  SetTargetFPS(fps);
  return mrb_nil_value();
}

mrb_value MrbWindowShouldClose(mrb_state*, mrb_value) {
  return mrb_bool_value(WindowShouldClose());
}

mrb_value MrbBeginDrawing(mrb_state*, mrb_value) {
  BeginDrawing();
  return mrb_nil_value();
}

mrb_value MrbEndDrawing(mrb_state*, mrb_value) {
  EndDrawing();
  return mrb_nil_value();
}

mrb_value MrbDrawFPS(mrb_state *mrb, mrb_value) {
  mrb_int x, y;

  mrb_get_args(mrb, "ii", &x, &y);

  DrawFPS(x, y);
  return mrb_nil_value();
}

mrb_data_type Colour_type = {
  "Color", mrb_free
};

mrb_value MrbClearBackground(mrb_state *mrb, mrb_value) {
  mrb_value mrb_colour;
  Color *colour;

  mrb_get_args(mrb, "o", &mrb_colour);

  Data_Get_Struct(mrb, mrb_colour, &Colour_type, colour);
  mrb_assert(colour != nullptr);

  ClearBackground(*colour);
  return mrb_nil_value();
}

mrb_value MrbDrawRectangle(mrb_state *mrb, mrb_value) {
  mrb_int x, y, width, height;
  mrb_value mrb_colour;
  Color *colour;

  mrb_get_args(mrb, "iiiio", &x, &y, &width, &height, &mrb_colour);

  Data_Get_Struct(mrb, mrb_colour, &Colour_type, colour);
  mrb_assert(colour != nullptr);

  DrawRectangle(x, y, width, height, *colour);
  return mrb_nil_value();
}

mrb_value MrbGetFrameTime(mrb_state* mrb, mrb_value) {
  return mrb_float_value(mrb, GetFrameTime());
}

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

int main(void)
{
  mrb_state *mrb = mrb_open();

  mrb_define_method(mrb, mrb->kernel_module, "init_window", MrbInitWindow, MRB_ARGS_REQ(3));
  mrb_define_method(mrb, mrb->kernel_module, "set_target_fps", MrbSetTargetFPS, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "window_should_close?", MrbWindowShouldClose, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "begin_drawing", MrbBeginDrawing, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "end_drawing", MrbEndDrawing, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "draw_fps", MrbDrawFPS, MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb->kernel_module, "clear_background", MrbClearBackground, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "draw_rectangle", MrbDrawRectangle, MRB_ARGS_REQ(5));
  mrb_define_method(mrb, mrb->kernel_module, "get_frame_time", MrbGetFrameTime, MRB_ARGS_NONE());

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

  mrb_load_string(mrb, R"(
      init_window(100, 100, 'hello')
      set_target_fps(144)

      colour = Colour.new(0, 0, 0 ,255)
      red = Colour.new(255, 0 ,0, 255)

      until window_should_close?
        delta = get_frame_time
        begin_drawing
        clear_background(colour)
        draw_rectangle(50, 50, 25, 25, red)
        draw_fps(10, 10)
        end_drawing
      end
    )");
  //mrb_load_irep(mrb, game);

  if (mrb->exc) {
    mrb_print_backtrace(mrb);
    return 1;
  }

  mrb_close(mrb);

  return 0;
}
