#pragma once

#define attr_reader_int(mrb, self, klass_type, klass, attr) { \
  klass *data; \
  \
  Data_Get_Struct(mrb, self, &klass_type, data); \
  mrb_assert(data != nullptr); \
  \
  return mrb_int_value(mrb, data->attr); \
}

#define attr_setter_int(mrb, self, klass_type, klass, attr) { \
  mrb_int attr; \
  mrb_get_args(mrb, "i", &attr); \
  klass *data; \
  \
  Data_Get_Struct(mrb, self, &klass_type, data); \
  mrb_assert(data != nullptr); \
  \
  data->attr = attr; \
  \
  return mrb_int_value(mrb, data->attr); \
}
