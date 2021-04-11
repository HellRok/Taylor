#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/struct_types.hpp"

mrb_value MrbInitWindow(mrb_state *mrb, mrb_value) {
  mrb_int width, height;
  char* title;

  mrb_get_args(mrb, "iiz", &width, &height, &title);

  InitWindow(width, height, title);
  return mrb_nil_value();
}

mrb_value MrbWindowShouldClose(mrb_state*, mrb_value) {
  return mrb_bool_value(WindowShouldClose());
}

mrb_value MrbClearBackground(mrb_state *mrb, mrb_value) {
  mrb_value mrb_colour;
  Color *colour;

  mrb_get_args(mrb, "o", &mrb_colour);

  Data_Get_Struct(mrb, mrb_colour, &Colour_type, colour);
  mrb_assert(colour != nullptr);

  ClearBackground(*colour);
  return mrb_nil_value();
}

mrb_value MrbBeginDrawing(mrb_state*, mrb_value) {
  BeginDrawing();
  return mrb_nil_value();
}

mrb_value MrbEndDrawing(mrb_state*, mrb_value) {
  EndDrawing();
  return mrb_nil_value();
}

mrb_value MrbSetTargetFPS(mrb_state *mrb, mrb_value) {
  mrb_int fps;

  mrb_get_args(mrb, "i", &fps);

  SetTargetFPS(fps);
  return mrb_nil_value();
}

mrb_value MrbGetFrameTime(mrb_state *mrb, mrb_value) {
  return mrb_float_value(mrb, GetFrameTime());
}

void appendCore(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "init_window", MrbInitWindow, MRB_ARGS_REQ(3));
  mrb_define_method(mrb, mrb->kernel_module, "window_should_close?", MrbWindowShouldClose, MRB_ARGS_NONE());

  mrb_define_method(mrb, mrb->kernel_module, "clear_background", MrbClearBackground, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "begin_drawing", MrbBeginDrawing, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "end_drawing", MrbEndDrawing, MRB_ARGS_NONE());

  mrb_define_method(mrb, mrb->kernel_module, "get_frame_time", MrbGetFrameTime, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "set_target_fps", MrbSetTargetFPS, MRB_ARGS_REQ(1));
}
