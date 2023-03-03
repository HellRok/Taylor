#include "mruby.h"
#include "mruby/compile.h"

mrb_value mrb_android(mrb_state*, mrb_value) {
#ifdef __NDK_MAJOR__
  return mrb_true_value();
#else
  return mrb_false_value();
#endif
}

mrb_value mrb_browser(mrb_state*, mrb_value) {
#ifdef __EMSCRIPTEN__
  return mrb_true_value();
#else
  return mrb_false_value();
#endif
}

mrb_value mrb_linux(mrb_state*, mrb_value) {
#ifdef __linux__
  return mrb_true_value();
#else
  return mrb_false_value();
#endif
}

mrb_value mrb_osx(mrb_state*, mrb_value) {
#ifdef __APPLE__
  return mrb_true_value();
#else
  return mrb_false_value();
#endif
}

mrb_value mrb_windows(mrb_state*, mrb_value) {
#ifdef _WIN32
  return mrb_true_value();
#else
  return mrb_false_value();
#endif
}

void append_platform(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "android?", mrb_android, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "browser?", mrb_browser, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "linux?", mrb_linux, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "osx?", mrb_osx, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "windows?", mrb_windows, MRB_ARGS_NONE());

  mrb_load_string(mrb, R"(
    GLSL_VERSION = (browser? || android?) ? 100 : 330

    class PlatformSpecificMethodCalledOnWrongPlatformError < StandardError
    end
  )");
}
