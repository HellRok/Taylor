#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"
#include <cstdlib>

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/music.hpp"

struct RClass* Music_class;

void
setup_Music(mrb_state* mrb,
            mrb_value object,
            Music* music,
            int context_type,
            bool looping,
            int frame_count)
{
  ivar_attr_int(mrb, object, music->ctxType, context_type);
  ivar_attr_bool(mrb, object, music->looping, looping);
  ivar_attr_int(mrb, object, music->frameCount, frame_count);
}

mrb_value
mrb_Music_initialize(mrb_state* mrb, mrb_value self)
{
  mrb_int context_type, frame_count;
  mrb_bool looping;
  mrb_get_args(mrb, "ibi", &context_type, &looping, &frame_count);

  Music* music = (struct Music*)DATA_PTR(self);
  if (music) {
    mrb_free(mrb, music);
  }
  mrb_data_init(self, nullptr, &Music_type);
  music = (Music*)malloc(sizeof(Music));

  setup_Music(mrb, self, music, context_type, looping, frame_count);

  mrb_data_init(self, music, &Music_type);
  return self;
}

mrb_value
mrb_Music_set_context_type(mrb_state* mrb, mrb_value self)
{
  attr_setter_int(mrb, self, Music_type, Music, ctxType, context_type);
}

mrb_value
mrb_Music_set_looping(mrb_state* mrb, mrb_value self)
{
  attr_setter_bool(mrb, self, Music_type, Music, looping, looping);
}

mrb_value
mrb_Music_set_frame_count(mrb_state* mrb, mrb_value self)
{
  attr_setter_int(mrb, self, Music_type, Music, frameCount, frame_count);
}

void
append_models_Music(mrb_state* mrb)
{
  Music_class = mrb_define_class(mrb, "Music", mrb->object_class);
  MRB_SET_INSTANCE_TT(Music_class, MRB_TT_DATA);
  mrb_define_method(
    mrb, Music_class, "initialize", mrb_Music_initialize, MRB_ARGS_REQ(3));
  mrb_define_method(mrb,
                    Music_class,
                    "context_type=",
                    mrb_Music_set_context_type,
                    MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Music_class, "looping=", mrb_Music_set_looping, MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    Music_class,
                    "frame_count=",
                    mrb_Music_set_frame_count,
                    MRB_ARGS_REQ(1));

  load_ruby_models_music(mrb);
}
