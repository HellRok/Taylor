#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/struct_types.hpp"

mrb_value mrb_init_window(mrb_state *mrb, mrb_value) {
  mrb_int width, height;
  char* title;

  mrb_get_args(mrb, "iiz", &width, &height, &title);

  InitWindow(width, height, title);
  return mrb_nil_value();
}

mrb_value mrb_window_should_close(mrb_state*, mrb_value) {
  return mrb_bool_value(WindowShouldClose());
}

mrb_value mrb_clear_background(mrb_state *mrb, mrb_value) {
  mrb_value mrb_colour;
  Color *colour;

  mrb_get_args(mrb, "o", &mrb_colour);

  Data_Get_Struct(mrb, mrb_colour, &Colour_type, colour);
  mrb_assert(colour != nullptr);

  ClearBackground(*colour);
  return mrb_nil_value();
}

mrb_value mrb_begin_drawing(mrb_state*, mrb_value) {
  BeginDrawing();
  return mrb_nil_value();
}

mrb_value mrb_end_drawing(mrb_state*, mrb_value) {
  EndDrawing();
  return mrb_nil_value();
}

mrb_value mrb_get_frame_time(mrb_state *mrb, mrb_value) {
  return mrb_float_value(mrb, GetFrameTime());
}

mrb_value mrb_set_target_fps(mrb_state *mrb, mrb_value) {
  mrb_int fps;

  mrb_get_args(mrb, "i", &fps);

  SetTargetFPS(fps);
  return mrb_nil_value();
}

mrb_value mrb_get_fps(mrb_state *mrb, mrb_value) {
  return mrb_int_value(mrb, GetFPS());
}

void append_core(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "init_window", mrb_init_window, MRB_ARGS_REQ(3));
  mrb_define_method(mrb, mrb->kernel_module, "window_should_close?", mrb_window_should_close, MRB_ARGS_NONE());

  mrb_define_method(mrb, mrb->kernel_module, "clear_background", mrb_clear_background, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "begin_drawing", mrb_begin_drawing, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "end_drawing", mrb_end_drawing, MRB_ARGS_NONE());

  mrb_define_method(mrb, mrb->kernel_module, "get_frame_time", mrb_get_frame_time, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "set_target_fps", mrb_set_target_fps, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "get_fps", mrb_get_fps, MRB_ARGS_NONE());
}
