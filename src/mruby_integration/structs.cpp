#include "mruby_integration/models/camera_2d.hpp"
#include "mruby_integration/models/colour.hpp"
#include "mruby_integration/models/image.hpp"
#include "mruby_integration/models/music.hpp"
#include "mruby_integration/models/rectangle.hpp"
#include "mruby_integration/models/sound.hpp"
#include "mruby_integration/models/texture2d.hpp"
#include "mruby_integration/models/vector2.hpp"

void append_structs(mrb_state *mrb) {
  append_models_Camera2D(mrb);
  append_models_Colour(mrb);
  append_models_Image(mrb);
  append_models_Music(mrb);
  append_models_Rectangle(mrb);
  append_models_Sound(mrb);
  append_models_Texture2D(mrb);
  append_models_Vector2(mrb);
}
