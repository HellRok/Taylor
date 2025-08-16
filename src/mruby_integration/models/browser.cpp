#include "mruby.h"
#include "mruby/class.h"
#include "mruby/compile.h"
#include "raylib.h"

#ifdef __EMSCRIPTEN__
#include <emscripten/emscripten.h>
#endif

struct RClass* Browser_class;

auto
mrb_Browser_open(mrb_state* mrb, mrb_value) -> mrb_value
{
  const char* url;
  mrb_get_args(mrb, "z", &url);

  OpenURL(url);
  return mrb_nil_value();
}

#ifdef __EMSCRIPTEN__
mrb_state* main_loop_mrb{};
mrb_value main_loop_self{};
char* main_loop_method{};

void
real_main_loop()
{
  mrb_funcall(main_loop_mrb, main_loop_self, main_loop_method, 0);
}

mrb_value
mrb_Browser_set_main_loop(mrb_state* mrb, mrb_value self)
{
  mrb_get_args(mrb, "z", &main_loop_method);
  main_loop_mrb = mrb;
  main_loop_self = self;

  emscripten_set_main_loop(real_main_loop, 0, 1);

  return mrb_nil_value();
}

mrb_value
mrb_Browser_cancel_main_loop(mrb_state*, mrb_value)
{
  emscripten_cancel_main_loop();

  return mrb_nil_value();
}

EM_JS(char*,
      js_get_attribute_from_element,
      (const char* selectorPointer, const char* attributePointer),
      {
        // clang-format off
        const selector = Module.UTF8ToString(selectorPointer);
        let attribute = Module.UTF8ToString(attributePointer);
        let value;

        if (attribute.slice(0, 5) === 'data-') {
          attribute = attribute.slice(5, attribute.length);
          value = document.querySelector(selector).dataset[attribute];
        } else {
          value = document.querySelector(selector)[attribute];
        }

        value = (value || "").toString();

        const byteCount = Module.lengthBytesUTF8(value) + 1;
        const valuePointer = Module._malloc(byteCount);

        Module.stringToUTF8(value, valuePointer, byteCount);

        return valuePointer;
        // clang-format on
      });

mrb_value
mrb_Browser_attribute_from_element(mrb_state* mrb, mrb_value)
{
  char *selector, *attribute;
  mrb_get_args(mrb, "zz", &selector, &attribute);

  return mrb_str_new_cstr(mrb,
                          js_get_attribute_from_element(selector, attribute));
}
#endif

void
append_models_Browser(mrb_state* mrb)
{
  Browser_class = mrb_define_module(mrb, "Browser");
  mrb_define_class_method(
    mrb, Browser_class, "open", mrb_Browser_open, MRB_ARGS_REQ(1));

#ifdef __EMSCRIPTEN__
  mrb_define_class_method(mrb,
                          Browser_class,
                          "main_loop=",
                          mrb_Browser_set_main_loop,
                          MRB_ARGS_REQ(1));
  mrb_define_class_method(mrb,
                          Browser_class,
                          "cancel_main_loop",
                          mrb_Browser_cancel_main_loop,
                          MRB_ARGS_NONE());
  mrb_define_class_method(mrb,
                          Browser_class,
                          "attribute_from_element",
                          mrb_Browser_attribute_from_element,
                          MRB_ARGS_REQ(2));
#endif

#ifndef __EMSCRIPTEN__
  mrb_load_string(mrb, R"(
    module Browser
      def self.main_loop=(main_loop_method)
        raise Taylor::Platform::MethodCalledOnInvalidPlatformError, 'Browser.mainloop= is only available for Web exports'
      end

      def self.cancel_main_loop
        raise Taylor::Platform::MethodCalledOnInvalidPlatformError, 'Browser.cancel_main_loop is only available for Web exports'
      end

      def self.attribute_from_element(selector, attribute)
        raise Taylor::Platform::MethodCalledOnInvalidPlatformError, "get_attribute_from_element is only available for Web exports"
      end
    end
  )");
#endif
}
