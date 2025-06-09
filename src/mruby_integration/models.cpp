#include "mruby_integration/models/audio.hpp"
#include "mruby_integration/models/camera2d.hpp"
#include "mruby_integration/models/colour.hpp"
#include "mruby_integration/models/cursor.hpp"
#include "mruby_integration/models/font.hpp"
#include "mruby_integration/models/image.hpp"
#include "mruby_integration/models/key.hpp"
#include "mruby_integration/models/monitor.hpp"
#include "mruby_integration/models/mouse.hpp"
#include "mruby_integration/models/music.hpp"
#include "mruby_integration/models/rectangle.hpp"
#include "mruby_integration/models/render_texture.hpp"
#include "mruby_integration/models/shader.hpp"
#include "mruby_integration/models/sound.hpp"
#include "mruby_integration/models/texture2d.hpp"
#include "mruby_integration/models/touch.hpp"
#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/models/window.hpp"

void
append_models(mrb_state* mrb)
{
  append_models_Audio(mrb);
  append_models_Camera2D(mrb);
  append_models_Colour(mrb);
  append_models_Cursor(mrb);
  append_models_Font(mrb);
  append_models_Image(mrb);
  append_models_Key(mrb);
  append_models_Monitor(mrb);
  append_models_Mouse(mrb);
  append_models_Music(mrb);
  append_models_Rectangle(mrb);
  append_models_RenderTexture(mrb);
  append_models_Shader(mrb);
  append_models_Sound(mrb);
  append_models_Texture2D(mrb);
  append_models_Touch(mrb);
  append_models_Vector2(mrb);
  append_models_Window(mrb);
}
