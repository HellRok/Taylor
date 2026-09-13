#include <filesystem>

#ifdef __APPLE__
// Thanks Apple...
namespace std_fs = std::__fs::filesystem;
#else
namespace std_fs = std::filesystem;
#endif

#include "mruby.h"

#include "ruby/taylor/config.hpp"

#include "taylor/platform.hpp"
#include "taylor/raylib.hpp"

auto mrb_taylor_released(mrb_state*, mrb_value) -> mrb_value
{
#ifdef EXPORT
  return mrb_true_value();
#else
  return mrb_false_value();
#endif
}

void append_taylor(mrb_state* mrb)
{
  struct RClass* Taylor_module = mrb_define_module(mrb, "Taylor");

  const std_fs::path working_directory = std_fs::current_path();
  // Convert from path -> string -> c_str because Windows returns wide chars
  // with path.c_str
  mrb_define_const(mrb,
                   Taylor_module,
                   "WORKING_DIRECTORY",
                   mrb_str_new_cstr(mrb, working_directory.string().c_str()));

  mrb_define_class_method(mrb, Taylor_module, "released?", mrb_taylor_released, MRB_ARGS_NONE());

  append_taylor_platform(mrb, Taylor_module);
  append_taylor_raylib(mrb, Taylor_module);

  load_ruby_taylor_config(mrb);
}
