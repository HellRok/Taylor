#include "mruby.h"
#include "raylib.h"

auto
mrb_init_audio_device(mrb_state*, mrb_value) -> mrb_value
{
  InitAudioDevice();
  return mrb_nil_value();
}

auto
mrb_close_audio_device(mrb_state*, mrb_value) -> mrb_value
{
  CloseAudioDevice();
  return mrb_nil_value();
}

auto
mrb_audio_device_ready(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(IsAudioDeviceReady());
}

auto
mrb_set_master_volume(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_float volume;
  mrb_get_args(mrb, "f", &volume);

  SetMasterVolume(volume);
  return mrb_nil_value();
}

void
append_audio_device(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "init_audio_device",
                    mrb_init_audio_device,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "close_audio_device",
                    mrb_close_audio_device,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "audio_device_ready?",
                    mrb_audio_device_ready,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_master_volume",
                    mrb_set_master_volume,
                    MRB_ARGS_REQ(1));
}
