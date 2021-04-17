#pragma once

#include "mruby.h"

extern RClass *texture_class;

mrb_value MrbTexture2DInitialize(mrb_state*, mrb_value);
mrb_value MrbTexture2DGetId(mrb_state*, mrb_value);
mrb_value MrbTexture2DSetId(mrb_state*, mrb_value);
mrb_value MrbTexture2DGetWidth(mrb_state*, mrb_value);
mrb_value MrbTexture2DSetWidth(mrb_state*, mrb_value);
mrb_value MrbTexture2DGetHeight(mrb_state*, mrb_value);
mrb_value MrbTexture2DSetHeight(mrb_state*, mrb_value);
mrb_value MrbTexture2DGetMipmaps(mrb_state*, mrb_value);
mrb_value MrbTexture2DSetMipmaps(mrb_state*, mrb_value);
mrb_value MrbTexture2DGetFormat(mrb_state*, mrb_value);
mrb_value MrbTexture2DSetFormat(mrb_state*, mrb_value);
mrb_value MrbTexture2DLoad(mrb_state*, mrb_value);

void appendModelsTexture2D(mrb_state*);

