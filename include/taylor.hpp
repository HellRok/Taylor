#pragma once

#include <string>
#include <vector>

#include "mruby.h"
#include "raylib.h"

extern std::vector<std::string> raylib_method_calls;

void AppendCall(std::string);

void
append_taylor(mrb_state*);
