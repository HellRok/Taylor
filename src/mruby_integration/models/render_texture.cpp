#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/compile.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

struct RClass *RenderTexture_class;

void setup_RenderTexture(mrb_state *mrb, mrb_value object, int width, int height) {
  mrb_iv_set(
      mrb, object,
      mrb_intern_cstr(mrb, "@width"),
      mrb_int_value(mrb, width)
    );
  mrb_iv_set(
      mrb, object,
      mrb_intern_cstr(mrb, "@height"),
      mrb_int_value(mrb, height)
    );
}

mrb_value mrb_RenderTexture_initialize(mrb_state *mrb, mrb_value self) {
  mrb_int width, height;
  mrb_get_args(mrb, "ii", &width, &height);
  setup_RenderTexture(mrb, self, width, height);

  RenderTexture *texture = (RenderTexture *)malloc(sizeof(RenderTexture));
  *texture = LoadRenderTexture(width, height);

  mrb_data_init(self, texture, &RenderTexture_type);
  return self;
}

void append_models_RenderTexture(mrb_state *mrb) {
  RenderTexture_class = mrb_define_class(mrb, "RenderTexture", mrb->object_class);
  MRB_SET_INSTANCE_TT(RenderTexture_class, MRB_TT_DATA);
  mrb_define_method(mrb, RenderTexture_class, "initialize", mrb_RenderTexture_initialize, MRB_ARGS_REQ(2));

  mrb_load_string(mrb, R"(
    class RenderTexture
      attr_reader :width, :height

      def to_h
        {
          width: width,
          height: height,
        }
      end
    end
  )");
}
