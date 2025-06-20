#include "mruby.h"
#include "mruby/class.h"
#include "raylib.h"

#include "mruby_integration/exceptions.hpp"
#include "mruby_integration/helpers.hpp"
#include "mruby_integration/models/monitor.hpp"
#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/models/window.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/monitor.hpp"

struct RClass* Monitor_class;

auto
mrb_Monitor_value(mrb_state* mrb, Monitor* monitor) -> mrb_value
{
  mrb_value obj =
    mrb_obj_value(Data_Wrap_Struct(mrb, Monitor_class, &Monitor_type, monitor));

  return obj;
}

void
Monitor_init(Monitor* monitor, int id)
{
  monitor->id = id;
}

auto
mrb_Monitor_count(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Monitor.count");

  return mrb_int_value(mrb, GetMonitorCount());
}

auto
mrb_Monitor_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  // def initialize(id:)
  mrb_int kw_num = 1;
  mrb_int kw_required = 1;
  mrb_sym kw_names[] = { mrb_intern_lit(mrb, "id") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  int id = 0;
  if (!mrb_undef_p(kw_values[0])) {
    id = mrb_as_int(mrb, kw_values[0]);
  }

  Monitor* monitor = static_cast<struct Monitor*> DATA_PTR(self);
  if (monitor) {
    mrb_free(mrb, monitor);
  }
  mrb_data_init(self, nullptr, &Monitor_type);
  monitor = static_cast<Monitor*>(malloc(sizeof(Monitor)));

  Monitor_init(monitor, id);

  mrb_data_init(self, monitor, &Monitor_type);
  return self;
}

mrb_attr_reader(mrb, self, int, Monitor, id);

auto
mrb_Monitor_current(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Monitor.current");
  auto* monitor = static_cast<Monitor*>(malloc(sizeof(Monitor)));
  *monitor = Monitor{ GetCurrentMonitor() };

  mrb_value obj =
    mrb_obj_value(Data_Wrap_Struct(mrb, Monitor_class, &Monitor_type, monitor));

  return obj;
}

auto
mrb_Monitor_position(mrb_state* mrb, mrb_value self) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Monitor#position");

  Monitor* monitor;

  Data_Get_Struct(mrb, self, &Monitor_type, monitor);
  mrb_assert(monitor != nullptr);

  auto* position = static_cast<Vector2*>(malloc(sizeof(Vector2)));
  *position = GetMonitorPosition(monitor->id);

  return mrb_Vector2_value(mrb, position);
}

auto
mrb_Monitor_width(mrb_state* mrb, mrb_value self) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Monitor#width");

  Monitor* monitor;

  Data_Get_Struct(mrb, self, &Monitor_type, monitor);
  mrb_assert(monitor != nullptr);

  return mrb_int_value(mrb, GetMonitorWidth(monitor->id));
}

auto
mrb_Monitor_height(mrb_state* mrb, mrb_value self) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Monitor#height");

  Monitor* monitor;

  Data_Get_Struct(mrb, self, &Monitor_type, monitor);
  mrb_assert(monitor != nullptr);

  return mrb_int_value(mrb, GetMonitorHeight(monitor->id));
}

auto
mrb_Monitor_refresh_rate(mrb_state* mrb, mrb_value self) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY(
    "You must call Window.open before Monitor#refresh_rate");

  Monitor* monitor;

  Data_Get_Struct(mrb, self, &Monitor_type, monitor);
  mrb_assert(monitor != nullptr);

  return mrb_int_value(mrb, GetMonitorRefreshRate(monitor->id));
}

auto
mrb_Monitor_name(mrb_state* mrb, mrb_value self) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Monitor#name");

  Monitor* monitor;

  Data_Get_Struct(mrb, self, &Monitor_type, monitor);
  mrb_assert(monitor != nullptr);

  return mrb_str_new_cstr(mrb, GetMonitorName(monitor->id));
}

void
append_models_Monitor(mrb_state* mrb)
{
  Monitor_class = mrb_define_class(mrb, "Monitor", mrb->object_class);
  MRB_SET_INSTANCE_TT(Monitor_class, MRB_TT_DATA);

  mrb_define_class_method(
    mrb, Monitor_class, "count", mrb_Monitor_count, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Monitor_class, "current", mrb_Monitor_current, MRB_ARGS_NONE());

  mrb_define_method(
    mrb, Monitor_class, "initialize", mrb_Monitor_initialize, MRB_ARGS_REQ(1));
  mrb_attr_reader_define(mrb, Monitor, id);
  mrb_define_method(
    mrb, Monitor_class, "position", mrb_Monitor_position, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Monitor_class, "width", mrb_Monitor_width, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Monitor_class, "height", mrb_Monitor_height, MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    Monitor_class,
                    "refresh_rate",
                    mrb_Monitor_refresh_rate,
                    MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Monitor_class, "name", mrb_Monitor_name, MRB_ARGS_NONE());

  load_ruby_models_monitor(mrb);
}
