#pragma once

#include "mruby.h"
#include "raylib.h"
#include <memory>

extern RClass* Rectangle_class;

struct Rektangle
{
  Rectangle rectangle;
  Color* colour;
  Color* outline;
  float thickness;
  float roundness;
  int segments;
};

void
append_models_Rectangle(mrb_state*);
