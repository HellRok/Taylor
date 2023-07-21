#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/sound.hpp"

struct RClass *Sound_class;

void setup_Sound(mrb_state *mrb, mrb_value object, Sound *sound, int frame_count) {
  ivar_attr_int(mrb, object, sound->frameCount, frame_count);
}

mrb_value mrb_Sound_initialize(mrb_state *mrb, mrb_value self) {
  mrb_int frame_count;
  mrb_get_args(mrb, "i", &frame_count);

  Sound *sound = (struct Sound *)DATA_PTR(self);
  if (sound) { mrb_free(mrb, sound); }
  mrb_data_init(self, nullptr, &Sound_type);
  sound = (Sound *)malloc(sizeof(Sound));

  setup_Sound(mrb, self, sound, frame_count);

  mrb_data_init(self, sound, &Sound_type);
  return self;
}

mrb_value mrb_Sound_set_frame_count(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Sound_type, Sound, frameCount, frame_count);
}

void append_models_Sound(mrb_state *mrb) {
  Sound_class = mrb_define_class(mrb, "Sound", mrb->object_class);
  MRB_SET_INSTANCE_TT(Sound_class, MRB_TT_DATA);
  mrb_define_method(mrb, Sound_class, "initialize", mrb_Sound_initialize, MRB_ARGS_REQ(3));
  mrb_define_method(mrb, Sound_class, "frame_count=", mrb_Sound_set_frame_count, MRB_ARGS_REQ(1));

  load_ruby_models_sound(mrb);
}
