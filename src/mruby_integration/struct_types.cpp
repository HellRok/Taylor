#include <cstdlib>
#include <unordered_map>
#include <string>
#include <vector>
#include "mruby.h"
#include "mruby/data.h"

std::unordered_map<void*, std::string> parent_types;
std::vector<void*> owned_objects{ };

int is_owned(void* p) {
  for (unsigned int i = 0; i < owned_objects.size(); i++) {
    if (p == owned_objects[i]) return int(i);
  }
  return -1;
}

void add_parent(void* p, std::string klass) {
  parent_types[p] = klass;
}

void add_owned_object(void* p) {
  int current = owned_objects.size();
  owned_objects.resize(current + 1);
  owned_objects[current] = p;
}

void free_klass(mrb_state *mrb, void* p, std::string klass) {
  int index = is_owned(p);

  if (parent_types[p] == klass) {
    mrb_free(mrb, p);
    parent_types.erase(p);
  } else if (index >= 0) {
    owned_objects.erase(owned_objects.begin() + index);
  } else {
    mrb_free(mrb, p);
  }
};

void free_camera2d(mrb_state *mrb, void* p)       { free_klass(mrb, p, "Camera2D");  };
void free_colour(mrb_state *mrb, void *p)         { free_klass(mrb, p, "Color");     };
void free_font(mrb_state *mrb, void *p)           { free_klass(mrb, p, "Font");      };
void free_image(mrb_state *mrb, void *p)          { free_klass(mrb, p, "Image");     };
void free_music(mrb_state *mrb, void *p)          { free_klass(mrb, p, "Music");     };
void free_rectangle(mrb_state *mrb, void *p)      { free_klass(mrb, p, "Rectangle"); };
void free_sound(mrb_state *mrb, void *p)          { free_klass(mrb, p, "Sound");     };
void free_render_texture(mrb_state *mrb, void *p) { free_klass(mrb, p, "RenderTexture"); };
void free_texture2d(mrb_state *mrb, void *p)      { free_klass(mrb, p, "Texture2D"); };
void free_vector(mrb_state *mrb, void* p)         { free_klass(mrb, p, "Vector");    };

mrb_data_type Camera2D_type =      { "Camera2D",      free_camera2d       };
mrb_data_type Colour_type =        { "Color",         free_colour         };
mrb_data_type Font_type =          { "Font",          free_font           };
mrb_data_type Image_type =         { "Image",         free_image          };
mrb_data_type Music_type =         { "Music",         free_music          };
mrb_data_type Rectangle_type =     { "Rectangle",     free_rectangle      };
mrb_data_type Sound_type =         { "Sound",         free_sound          };
mrb_data_type RenderTexture_type = { "RenderTexture", free_render_texture };
mrb_data_type Texture2D_type =     { "Texture2D",     free_texture2d      };
mrb_data_type Vector2_type =       { "Vector2",       free_vector         };
