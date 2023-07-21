#include "mruby.h"
#include <mruby/class.h>
#include "mruby/compile.h"

#include "ruby/platform_specific/web.hpp"

#ifdef __EMSCRIPTEN__
#include <emscripten/emscripten.h>

EM_JS(char*, js_get_attribute_from_element, (const char* selectorPointer, const char* attributePointer), {
  const selector = Module.UTF8ToString(selectorPointer);
  let attribute = Module.UTF8ToString(attributePointer);
  let value;

  if (attribute.slice(0, 5) === 'data-') {
    attribute = attribute.slice(5, attribute.length);
    value = document.querySelector(selector).dataset[attribute];
  } else {
    value = document.querySelector(selector)[attribute];
  }

  const byteCount = Module.lengthBytesUTF8(value) + 1;
  const valuePointer = Module._malloc(byteCount);

  Module.stringToUTF8(value, valuePointer, byteCount);

  return valuePointer;
});

mrb_value mrb_get_attribute_from_element(mrb_state *mrb, mrb_value) {
  char *selector, *attribute;
  mrb_get_args(mrb, "zz", &selector, &attribute);

  return mrb_str_new_cstr(mrb, js_get_attribute_from_element(selector, attribute));
}

EM_JS(void, js_local_storage_set_item, (const char* keyPointer, const char* valuePointer), {
  const key = Module.UTF8ToString(keyPointer);
  const value = Module.UTF8ToString(valuePointer);

  console.log(key, value);
  localStorage.setItem(key, value);
});

mrb_value mrb_local_storage_set_item(mrb_state *mrb, mrb_value) {
  char *key, *value;
  mrb_get_args(mrb, "zz", &key, &value);

  js_local_storage_set_item(key, value);

  return mrb_nil_value();
}

EM_JS(char*, js_local_storage_get_item, (const char* keyPointer), {
  const key = Module.UTF8ToString(keyPointer);

  // We can't return two different types, so let's just return an empty string,
  // this shouldn't be too bad an edge case.
  const value = localStorage.getItem(key) || "";

  const byteCount = Module.lengthBytesUTF8(value) + 1;
  const valuePointer = Module._malloc(byteCount);

  Module.stringToUTF8(value, valuePointer, byteCount);

  return valuePointer;
});

mrb_value mrb_local_storage_get_item(mrb_state *mrb, mrb_value) {
  char *key;
  mrb_get_args(mrb, "z", &key);

  return mrb_str_new_cstr(mrb, js_local_storage_get_item(key));
}
#endif

void append_platform_specific_web(mrb_state *mrb) {
#ifdef __EMSCRIPTEN__
  struct RClass *LocalStorage_class;
  LocalStorage_class = mrb_define_class(mrb, "LocalStorage", mrb->object_class);
  MRB_SET_INSTANCE_TT(LocalStorage_class, MRB_TT_DATA);
  mrb_define_class_method(mrb, LocalStorage_class, "set_item", mrb_local_storage_set_item, MRB_ARGS_REQ(2));
  mrb_define_class_method(mrb, LocalStorage_class, "get_item", mrb_local_storage_get_item, MRB_ARGS_REQ(2));

  mrb_define_method(mrb, mrb->kernel_module, "get_attribute_from_element", mrb_get_attribute_from_element, MRB_ARGS_REQ(2));
#endif

#ifndef __EMSCRIPTEN__
  load_ruby_platform_specific_web(mrb);
#endif
}
