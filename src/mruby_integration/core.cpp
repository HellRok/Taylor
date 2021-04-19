#include <cstdlib>
#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/models/vector2.hpp"
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

mrb_value mrb_close_window(mrb_state*, mrb_value) {
  CloseWindow();
  return mrb_nil_value();
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

mrb_value mrb_is_key_down(mrb_state *mrb, mrb_value) {
  mrb_int key;

  mrb_get_args(mrb, "i", &key);

  return mrb_bool_value(IsKeyDown(key));
}

mrb_value mrb_is_mouse_button_pressed(mrb_state *mrb, mrb_value) {
  mrb_int button;

  mrb_get_args(mrb, "i", &button);

  return mrb_bool_value(IsMouseButtonPressed(button));
}

mrb_value mrb_get_mouse_position(mrb_state *mrb, mrb_value) {
  Vector2 *position = (Vector2 *)malloc(sizeof(Vector2));
  *position = GetMousePosition();

  return mrb_obj_value(Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, position));
}

void append_core(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "init_window", mrb_init_window, MRB_ARGS_REQ(3));
  mrb_define_method(mrb, mrb->kernel_module, "window_should_close?", mrb_window_should_close, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "close_window", mrb_close_window, MRB_ARGS_NONE());

  mrb_define_method(mrb, mrb->kernel_module, "clear_background", mrb_clear_background, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "begin_drawing", mrb_begin_drawing, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "end_drawing", mrb_end_drawing, MRB_ARGS_NONE());

  mrb_define_method(mrb, mrb->kernel_module, "get_frame_time", mrb_get_frame_time, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "set_target_fps", mrb_set_target_fps, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "get_fps", mrb_get_fps, MRB_ARGS_NONE());

  mrb_define_method(mrb, mrb->kernel_module, "is_key_down", mrb_is_key_down, MRB_ARGS_REQ(1));

  mrb_define_method(mrb, mrb->kernel_module, "is_mouse_button_pressed", mrb_is_mouse_button_pressed, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "get_mouse_position", mrb_get_mouse_position, MRB_ARGS_NONE());
}
