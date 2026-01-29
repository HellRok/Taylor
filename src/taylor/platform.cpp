#include "mruby.h"

#include "ruby/taylor/platform.hpp"

auto mrb_Taylor_Platform_os(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_symbol_value(mrb_intern_cstr(mrb,
#ifdef __NDK_MAJOR__
                                          "android"
#elif __EMSCRIPTEN__
                                          "browser"
#elif __linux__
                                          "linux"
#elif __APPLE__
                                          "osx"
#elif _WIN32
                                          "windows"
#endif
                                          ));
}

auto mrb_Taylor_Platform_arch(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_symbol_value(mrb_intern_cstr(mrb,
#ifdef __EMSCRIPTEN__
                                          "wasm32"
#elif defined(__x86_64__) || defined(_M_X64)
                                          "amd64"
#elif defined(__aarch64__) || defined(_M_ARM64)
                                          "arm64"
#endif
                                          ));
}

auto mrb_Taylor_Platform_android(mrb_state*, mrb_value) -> mrb_value
{
#ifdef __NDK_MAJOR__
  return mrb_true_value();
#else
  return mrb_false_value();
#endif
}

auto mrb_Taylor_Platform_browser(mrb_state*, mrb_value) -> mrb_value
{
#ifdef __EMSCRIPTEN__
  return mrb_true_value();
#else
  return mrb_false_value();
#endif
}

auto mrb_Taylor_Platform_linux(mrb_state*, mrb_value) -> mrb_value
{
#ifdef __linux__
  return mrb_true_value();
#else
  return mrb_false_value();
#endif
}

auto mrb_Taylor_Platform_osx(mrb_state*, mrb_value) -> mrb_value
{
#ifdef __APPLE__
  return mrb_true_value();
#else
  return mrb_false_value();
#endif
}

auto mrb_Taylor_Platform_windows(mrb_state*, mrb_value) -> mrb_value
{
#ifdef _WIN32
  return mrb_true_value();
#else
  return mrb_false_value();
#endif
}

void append_taylor_platform(mrb_state* mrb, RClass* Taylor_module)
{
  struct RClass* Platform_module = mrb_define_module_under(mrb, Taylor_module, "Platform");
  mrb_define_class_method(mrb, Platform_module, "os", mrb_Taylor_Platform_os, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, Platform_module, "arch", mrb_Taylor_Platform_arch, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Platform_module, "android?", mrb_Taylor_Platform_android, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Platform_module, "browser?", mrb_Taylor_Platform_browser, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Platform_module, "linux?", mrb_Taylor_Platform_linux, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, Platform_module, "osx?", mrb_Taylor_Platform_osx, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Platform_module, "windows?", mrb_Taylor_Platform_windows, MRB_ARGS_NONE());

  load_ruby_taylor_platform(mrb);
}
