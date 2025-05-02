#include <string>
#include <vector>

#include "mruby.h"
#include "mruby/array.h"
#include "mruby/compile.h"

#include "raylib.h"

std::vector<std::string> raylib_method_calls;

auto
AppendCall(std::string call) -> void
{
  raylib_method_calls.push_back(call);
}

auto
mrb_Taylor_Raylib_mocked(mrb_state* mrb, mrb_value) -> mrb_value
{
#ifdef MOCK_RAYLIB
  return mrb_true_value();
#else
  return mrb_false_value();
#endif
}

auto
mrb_Taylor_Raylib_calls(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_value result;
#ifdef MOCK_RAYLIB
  result = mrb_ary_new_capa(mrb, raylib_method_calls.size());

  for (int i = 0; i < raylib_method_calls.size(); i++) {
    mrb_ary_push(
      mrb, result, mrb_str_new_cstr(mrb, raylib_method_calls[i].c_str()));
  }

#else
  result = mrb_ary_new_capa(mrb, 0);
#endif

  return result;
}

void
append_taylor(mrb_state* mrb)
{
  struct RClass* Taylor_module = mrb_define_module(mrb, "Taylor");
  struct RClass* Raylib_module =
    mrb_define_module_under(mrb, Taylor_module, "Raylib");
  mrb_define_class_method(
    mrb, Raylib_module, "mocked?", mrb_Taylor_Raylib_mocked, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Raylib_module, "calls", mrb_Taylor_Raylib_calls, MRB_ARGS_NONE());
}
