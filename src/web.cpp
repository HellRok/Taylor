#include "mruby.h"
#include "mruby/compile.h"
#ifdef __EMSCRIPTEN__
#include <emscripten/emscripten.h>

mrb_state *main_loop_mrb{};
mrb_value main_loop_self{};
char *main_loop_method{};

void real_main_loop() {
  mrb_funcall(main_loop_mrb, main_loop_self, main_loop_method, 0);
}

mrb_value mrb_set_main_loop(mrb_state *mrb, mrb_value self) {
  mrb_get_args(mrb, "z", &main_loop_method);
  main_loop_mrb = mrb;
  main_loop_self = self;

  emscripten_set_main_loop(real_main_loop, 0, 1);

  return mrb_nil_value();
}
#endif

void append_web(mrb_state *mrb) {
#ifdef __EMSCRIPTEN__
  mrb_define_method(mrb, mrb->kernel_module, "set_main_loop", mrb_set_main_loop, MRB_ARGS_REQ(1));
#endif

#ifndef __EMSCRIPTEN__
  mrb_load_string(mrb, R"(
    def set_main_loop(main_loop_method)
      raise PlatformSpecificMethodCalledOnWrongPlatformError, 'set_main_loop is only available for Web exports'
    end
  )");
#endif
}
