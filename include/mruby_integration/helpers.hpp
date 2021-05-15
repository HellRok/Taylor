#pragma once

#include "mruby/variable.h"

#define attr_reader_int(mrb, self, klass_type, klass, attr) { \
  klass *data; \
  \
  Data_Get_Struct(mrb, self, &klass_type, data); \
  mrb_assert(data != nullptr); \
  \
  return mrb_int_value(mrb, data->attr); \
}

#define attr_setter_int(mrb, self, klass_type, klass, attr, ivar) { \
  mrb_int attr; \
  mrb_get_args(mrb, "i", &attr); \
  klass *data; \
  \
  Data_Get_Struct(mrb, self, &klass_type, data); \
  mrb_assert(data != nullptr); \
  \
  data->attr = attr; \
  mrb_iv_set( \
      mrb, self, \
      mrb_intern_cstr(mrb, "@" #ivar), \
      mrb_int_value(mrb, attr) \
    ); \
  \
  return mrb_int_value(mrb, data->attr); \
}

#define attr_reader_float(mrb, self, klass_type, klass, attr) { \
  klass *data; \
  \
  Data_Get_Struct(mrb, self, &klass_type, data); \
  mrb_assert(data != nullptr); \
  \
  return mrb_float_value(mrb, data->attr); \
}

#define attr_setter_float(mrb, self, klass_type, klass, attr, ivar) { \
  mrb_float attr; \
  mrb_get_args(mrb, "f", &attr); \
  klass *data; \
  \
  Data_Get_Struct(mrb, self, &klass_type, data); \
  mrb_assert(data != nullptr); \
  \
  data->attr = attr; \
  mrb_iv_set( \
      mrb, self, \
      mrb_intern_cstr(mrb, "@" #ivar), \
      mrb_float_value(mrb, attr) \
    ); \
  \
  return mrb_float_value(mrb, attr); \
}

#define attr_reader_bool(mrb, self, klass_type, klass, attr) { \
  klass *data; \
  \
  Data_Get_Struct(mrb, self, &klass_type, data); \
  mrb_assert(data != nullptr); \
  \
  return mrb_bool_value(data->attr); \
}

#define attr_setter_bool(mrb, self, klass_type, klass, attr, ivar) { \
  mrb_bool attr; \
  mrb_get_args(mrb, "b", &attr); \
  klass *data; \
  \
  Data_Get_Struct(mrb, self, &klass_type, data); \
  mrb_assert(data != nullptr); \
  \
  data->attr = attr; \
  mrb_iv_set( \
      mrb, self, \
      mrb_intern_cstr(mrb, "@" #ivar), \
      mrb_bool_value(attr) \
    ); \
  \
  return mrb_bool_value(data->attr); \
}

#define ivar_attr_int(mrb, self, value, attr) { \
  value = attr; \
  mrb_iv_set( \
      mrb, self, \
      mrb_intern_cstr(mrb, "@" #attr), \
      mrb_int_value(mrb, value) \
    ); \
}

#define ivar_attr_float(mrb, self, value, attr) { \
  value = attr; \
  mrb_iv_set( \
      mrb, self, \
      mrb_intern_cstr(mrb, "@" #attr), \
      mrb_float_value(mrb, value) \
    ); \
}

#define ivar_attr_bool(mrb, self, value, attr) { \
  value = attr; \
  mrb_iv_set( \
      mrb, self, \
      mrb_intern_cstr(mrb, "@" #attr), \
      mrb_bool_value(value) \
    ); \
}

#define ivar_attr_vector2(mrb, self, obj_value, attr) { \
  mrb_value obj = mrb_obj_value(Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, &obj_value)); \
  obj_value.x = attr->x; \
  obj_value.y = attr->y; \
  mrb_iv_set( \
      mrb, obj, \
      mrb_intern_cstr(mrb, "@x"), \
      mrb_float_value(mrb, attr->x) \
    ); \
  mrb_iv_set( \
      mrb, obj, \
      mrb_intern_cstr(mrb, "@y"), \
      mrb_float_value(mrb, attr->y) \
    ); \
  \
  mrb_iv_set( \
      mrb, self, \
      mrb_intern_cstr(mrb, "@" #attr), \
      obj \
    ); \
}
