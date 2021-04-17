#pragma once

#include "mruby.h"

extern RClass *colour_class;

mrb_value MrbColourInitialize(mrb_state*, mrb_value self);
mrb_value MrbColourGetRed(mrb_state*, mrb_value self);
mrb_value MrbColourSetRed(mrb_state*, mrb_value self);
mrb_value MrbColourGetGreen(mrb_state*, mrb_value self);
mrb_value MrbColourSetGreen(mrb_state*, mrb_value self);
mrb_value MrbColourGetBlue(mrb_state*, mrb_value self);
mrb_value MrbColourSetBlue(mrb_state*, mrb_value self);
mrb_value MrbColourGetAlpha(mrb_state*, mrb_value self);
mrb_value MrbColourSetAlpha(mrb_state*, mrb_value self);

void appendModelsColour(mrb_state*);
