#ifdef __EMSCRIPTEN__
#include "mruby.h"
#include <emscripten/emscripten.h>

EM_JS(char*, get_attribute_from_element, (const char* selectorPointer, const char* attributePointer), {
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

  return mrb_str_new_cstr(mrb, get_attribute_from_element(selector, attribute));
}

void append_platform_specific_web(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "get_attribute_from_element", mrb_get_attribute_from_element, MRB_ARGS_REQ(2));
}
#endif
