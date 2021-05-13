#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/struct_types.hpp"

mrb_value mrb_clear_background(mrb_state *mrb, mrb_value) {
  Color *colour;
  mrb_get_args(mrb, "d", &colour, &Colour_type);

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

mrb_value mrb_begin_mode2D(mrb_state *mrb, mrb_value) {
  Camera2D *camera;
  mrb_get_args(mrb, "d", &camera, &Camera2D_type);

  BeginMode2D(*camera);
  return mrb_nil_value();
}

mrb_value mrb_end_mode2D(mrb_state*, mrb_value) {
  EndMode2D();
  return mrb_nil_value();
}

void append_core_drawing(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "clear_background", mrb_clear_background, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "begin_drawing", mrb_begin_drawing, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "end_drawing", mrb_end_drawing, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "begin_mode2D", mrb_begin_mode2D, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "end_mode2D", mrb_end_mode2D, MRB_ARGS_NONE());
}
