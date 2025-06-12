#pragma once

#include "mruby/variable.h"

#define attr_reader_int(mrb, self, klass_type, klass, attr)                    \
  {                                                                            \
    klass* data;                                                               \
                                                                               \
    Data_Get_Struct(mrb, self, &klass_type, data);                             \
    mrb_assert(data != nullptr);                                               \
                                                                               \
    return mrb_int_value(mrb, data->attr);                                     \
  }

#define attr_setter_int(mrb, self, klass_type, klass, attr, ivar)              \
  {                                                                            \
    mrb_int attr;                                                              \
    mrb_get_args(mrb, "i", &attr);                                             \
    klass* data;                                                               \
                                                                               \
    Data_Get_Struct(mrb, self, &klass_type, data);                             \
    mrb_assert(data != nullptr);                                               \
                                                                               \
    data->attr = attr;                                                         \
    mrb_iv_set(                                                                \
      mrb, self, mrb_intern_cstr(mrb, "@" #ivar), mrb_int_value(mrb, attr));   \
                                                                               \
    return mrb_int_value(mrb, data->attr);                                     \
  }

#define attr_reader_float(mrb, self, klass_type, klass, attr)                  \
  {                                                                            \
    klass* data;                                                               \
                                                                               \
    Data_Get_Struct(mrb, self, &klass_type, data);                             \
    mrb_assert(data != nullptr);                                               \
                                                                               \
    return mrb_float_value(mrb, data->attr);                                   \
  }

#define attr_setter_float(mrb, self, klass_type, klass, attr, ivar)            \
  {                                                                            \
    mrb_float attr;                                                            \
    mrb_get_args(mrb, "f", &attr);                                             \
    klass* data;                                                               \
                                                                               \
    Data_Get_Struct(mrb, self, &klass_type, data);                             \
    mrb_assert(data != nullptr);                                               \
                                                                               \
    data->attr = attr;                                                         \
    mrb_iv_set(                                                                \
      mrb, self, mrb_intern_cstr(mrb, "@" #ivar), mrb_float_value(mrb, attr)); \
                                                                               \
    return mrb_float_value(mrb, attr);                                         \
  }

#define attr_reader_bool(mrb, self, klass_type, klass, attr)                   \
  {                                                                            \
    klass* data;                                                               \
                                                                               \
    Data_Get_Struct(mrb, self, &klass_type, data);                             \
    mrb_assert(data != nullptr);                                               \
                                                                               \
    return mrb_bool_value(data->attr);                                         \
  }

#define attr_setter_bool(mrb, self, klass_type, klass, attr, ivar)             \
  {                                                                            \
    mrb_bool attr;                                                             \
    mrb_get_args(mrb, "b", &attr);                                             \
    klass* data;                                                               \
                                                                               \
    Data_Get_Struct(mrb, self, &klass_type, data);                             \
    mrb_assert(data != nullptr);                                               \
                                                                               \
    data->attr = attr;                                                         \
    mrb_iv_set(                                                                \
      mrb, self, mrb_intern_cstr(mrb, "@" #ivar), mrb_bool_value(attr));       \
                                                                               \
    return mrb_bool_value(data->attr);                                         \
  }

#define ivar_attr_int(mrb, self, value, attr)                                  \
  {                                                                            \
    value = attr;                                                              \
    mrb_iv_set(                                                                \
      mrb, self, mrb_intern_cstr(mrb, "@" #attr), mrb_int_value(mrb, value));  \
  }

#define ivar_attr_float(mrb, self, value, attr)                                \
  {                                                                            \
    value = attr;                                                              \
    mrb_iv_set(mrb,                                                            \
               self,                                                           \
               mrb_intern_cstr(mrb, "@" #attr),                                \
               mrb_float_value(mrb, value));                                   \
  }

#define ivar_attr_bool(mrb, self, value, attr)                                 \
  {                                                                            \
    value = attr;                                                              \
    mrb_iv_set(                                                                \
      mrb, self, mrb_intern_cstr(mrb, "@" #attr), mrb_bool_value(value));      \
  }

#define ivar_attr_vector2(mrb, self, obj_value, attr)                          \
  {                                                                            \
    mrb_value obj = mrb_obj_value(                                             \
      Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, &obj_value));        \
    obj_value.x = attr->x;                                                     \
    obj_value.y = attr->y;                                                     \
    mrb_iv_set(                                                                \
      mrb, obj, mrb_intern_cstr(mrb, "@x"), mrb_float_value(mrb, attr->x));    \
    mrb_iv_set(                                                                \
      mrb, obj, mrb_intern_cstr(mrb, "@y"), mrb_float_value(mrb, attr->y));    \
                                                                               \
    mrb_iv_set(mrb, self, mrb_intern_cstr(mrb, "@" #attr), obj);               \
  }

#define ivar_attr_texture2d(mrb, self, obj_value, attr)                        \
  {                                                                            \
    mrb_value obj = mrb_obj_value(                                             \
      Data_Wrap_Struct(mrb, Texture2D_class, &Texture2D_type, &obj_value));    \
                                                                               \
    mrb_iv_set(                                                                \
      mrb, obj, mrb_intern_cstr(mrb, "@id"), mrb_float_value(mrb, attr->id));  \
    mrb_iv_set(mrb,                                                            \
               obj,                                                            \
               mrb_intern_cstr(mrb, "@width"),                                 \
               mrb_float_value(mrb, attr->width));                             \
    mrb_iv_set(mrb,                                                            \
               obj,                                                            \
               mrb_intern_cstr(mrb, "@height"),                                \
               mrb_float_value(mrb, attr->height));                            \
    mrb_iv_set(mrb,                                                            \
               obj,                                                            \
               mrb_intern_cstr(mrb, "@mipmaps"),                               \
               mrb_float_value(mrb, attr->mipmaps));                           \
    mrb_iv_set(mrb,                                                            \
               obj,                                                            \
               mrb_intern_cstr(mrb, "@format"),                                \
               mrb_float_value(mrb, attr->format));                            \
                                                                               \
    mrb_iv_set(mrb, self, mrb_intern_cstr(mrb, "@" #attr), obj);               \
  }

#define mrb_self_ptr(mrb, self, klass, instance)                               \
  {                                                                            \
    instance = static_cast<struct klass*> DATA_PTR(self);                      \
    if (instance) {                                                            \
      mrb_free(mrb, instance);                                                 \
    }                                                                          \
    mrb_data_init(self, nullptr, &klass##_type);                               \
    instance = static_cast<klass*>(malloc(sizeof(klass)));                     \
  }

#define mrb_attr_reader_with_klasses(                                          \
  mrb, self, type, ruby_klass, cpp_klass, attr)                                \
  auto mrb_##ruby_klass##_##attr(mrb_state* mrb, mrb_value self)->mrb_value    \
  {                                                                            \
    cpp_klass* data;                                                           \
                                                                               \
    Data_Get_Struct(mrb, self, &cpp_klass##_type, data);                       \
    mrb_assert(data != nullptr);                                               \
                                                                               \
    return mrb_##type##_value(mrb, data->attr);                                \
  }

#define mrb_attr_reader(mrb, self, type, klass, attr)                          \
  mrb_attr_reader_with_klasses(mrb, self, type, klass, klass, attr);

#define mrb_attr_writer_with_klasses(                                          \
  mrb, self, type, mrb_arg, ruby_klass, cpp_klass, attr)                       \
  auto mrb_##ruby_klass##_set_##attr(mrb_state* mrb, mrb_value self)           \
    ->mrb_value                                                                \
  {                                                                            \
    mrb_##type attr;                                                           \
    mrb_get_args(mrb, #mrb_arg, &attr);                                        \
    cpp_klass* data;                                                           \
                                                                               \
    Data_Get_Struct(mrb, self, &cpp_klass##_type, data);                       \
    mrb_assert(data != nullptr);                                               \
                                                                               \
    data->attr = attr;                                                         \
                                                                               \
    return mrb_##type##_value(mrb, data->attr);                                \
  }

#define mrb_attr_writer(mrb, self, type, mrb_arg, klass, attr)                 \
  mrb_attr_writer_with_klasses(mrb, self, type, mrb_arg, klass, klass, attr);

#define mrb_attr_writer_struct(mrb, self, type, attr, klass)                   \
  auto mrb_##type##_set_##attr(mrb_state* mrb, mrb_value self)->mrb_value      \
  {                                                                            \
    type* data;                                                                \
    klass* value;                                                              \
                                                                               \
    Data_Get_Struct(mrb, self, &type##_type, data);                            \
    mrb_assert(data != nullptr);                                               \
                                                                               \
    mrb_get_args(mrb, "d!", &value, &klass##_type);                            \
                                                                               \
    if (value) {                                                               \
      data->attr = value;                                                      \
      add_owned_object(data->attr);                                            \
      mrb_iv_set(mrb,                                                          \
                 self,                                                         \
                 mrb_intern_cstr(mrb, "@" #attr),                              \
                 mrb_##klass##_value(mrb, data->attr));                        \
    } else {                                                                   \
      mrb_iv_set(mrb, self, mrb_intern_cstr(mrb, "@" #attr), mrb_nil_value()); \
    }                                                                          \
                                                                               \
    return mrb_nil_value();                                                    \
  }

#define mrb_attr_accessor_with_klasses(                                        \
  mrb, self, type, mrb_arg, ruby_klass, cpp_klass, attr)                       \
  mrb_attr_reader_with_klasses(mrb, self, type, ruby_klass, cpp_klass, attr);  \
  mrb_attr_writer_with_klasses(                                                \
    mrb, self, type, mrb_arg, ruby_klass, cpp_klass, attr);

#define mrb_attr_accessor(mrb, self, type, mrb_arg, klass, attr)               \
  mrb_attr_reader(mrb, self, type, klass, attr);                               \
  mrb_attr_writer(mrb, self, type, mrb_arg, klass, attr);

#define mrb_attr_reader_define(mrb, klass, attr)                               \
  mrb_define_method(                                                           \
    mrb, klass##_class, #attr, mrb_##klass##_##attr, MRB_ARGS_NONE());

#define mrb_attr_writer_define(mrb, klass, attr)                               \
  mrb_define_method(                                                           \
    mrb, klass##_class, #attr "=", mrb_##klass##_set_##attr, MRB_ARGS_REQ(1));

#define mrb_attr_accessor_defines(mrb, klass, attr)                            \
  mrb_attr_reader_define(mrb, klass, attr);                                    \
  mrb_attr_writer_define(mrb, klass, attr);
