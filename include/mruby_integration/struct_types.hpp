#pragma once

#include "mruby.h"
#include "mruby/data.h"

void
add_reference(void*);

void
append_module_ReferenceCounter(mrb_state*);

extern mrb_data_type Camera2D_type;
extern mrb_data_type Circle_type;
extern mrb_data_type Color_type;
extern mrb_data_type Font_type;
extern mrb_data_type Gamepad_type;
extern mrb_data_type Image_type;
extern mrb_data_type Line_type;
extern mrb_data_type Monitor_type;
extern mrb_data_type Music_type;
extern mrb_data_type Rectangle_type;
extern mrb_data_type Rektangle_type;
extern mrb_data_type Shader_type;
extern mrb_data_type Sound_type;
extern mrb_data_type RenderTexture_type;
extern mrb_data_type Texture2D_type;
extern mrb_data_type Vector2_type;
