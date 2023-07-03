#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/compile.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

struct RClass *Shader_class;

void setup_Shader(mrb_state *mrb, mrb_value object, Shader *shader, int id) {
  ivar_attr_int(mrb, object, shader->id, id);
}

mrb_value mrb_Shader_initialize(mrb_state *mrb, mrb_value self) {
  mrb_int id;
  mrb_get_args(mrb, "i", &id);

  Shader *shader = (Shader *)DATA_PTR(self);
  if (shader) { mrb_free(mrb, shader); }
  mrb_data_init(self, nullptr, &Shader_type);
  shader = (Shader *)malloc(sizeof(Shader));

  setup_Shader(mrb, self, shader, id);

  mrb_data_init(self, shader, &Shader_type);
  return self;
}

mrb_value mrb_Shader_set_id(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Shader_type, Shader, id, id);
}

void append_models_Shader(mrb_state *mrb) {
  Shader_class = mrb_define_class(mrb, "Shader", mrb->object_class);
  MRB_SET_INSTANCE_TT(Shader_class, MRB_TT_DATA);
  mrb_define_method(mrb, Shader_class, "initialize", mrb_Shader_initialize, MRB_ARGS_REQ(5));
  mrb_define_method(mrb, Shader_class, "id=", mrb_Shader_set_id, MRB_ARGS_REQ(1));

  mrb_load_string(mrb, R"(
    class Shader
      attr_reader :id

      def self.load(vertex_shader_path, fragment_shader_path)
        load_shader(vertex_shader_path, fragment_shader_path)
      end

      def unload
        unload_shader(self)
      end

      def draw(&block)
        begin_shader_mode(self)
        block.call
        end_shader_mode
      end

      def ready?
        shader_ready?(self)
      end

      def get_uniform_location(variable)
        value = get_shader_location(self, variable)
        value == -1 ? nil : value
      end
    end
  )");
}
