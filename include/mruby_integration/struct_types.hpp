#pragma once

#include "mruby.h"
#include "mruby/data.h"
#include <string>

#include "mruby_integration/structs.hpp"

void
add_parent(void*, std::string);
void
add_owned_object(void*);

extern mrb_data_type Camera2D_type;
extern mrb_data_type Colour_type;
extern mrb_data_type Font_type;
extern mrb_data_type Image_type;
extern mrb_data_type Music_type;
extern mrb_data_type Rectangle_type;
extern mrb_data_type Shader_type;
extern mrb_data_type Sound_type;
extern mrb_data_type RenderTexture_type;
extern mrb_data_type Texture2D_type;
extern mrb_data_type Vector2_type;
