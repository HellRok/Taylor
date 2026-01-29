#pragma once

#include <string>
#include <vector>

#include "mruby.h"
#include "raylib.h"

extern std::vector<std::string> raylib_method_calls;

void append_call(std::string);

auto mocked_const_char_call_for(std::string) -> const char*;
auto mocked_call_for_LoadImageColors(Color*) -> const Color*;

void mocked_call_for(std::string, bool*);
void mocked_call_for(std::string, double*);
void mocked_call_for(std::string, float*);
void mocked_call_for(std::string, int*);

void mocked_call_for(std::string, Color*);
void mocked_call_for(std::string, FilePathList*);
void mocked_call_for(std::string, Font*);
void mocked_call_for(std::string, Image*);
void mocked_call_for(std::string, Music*);
void mocked_call_for(std::string, RenderTexture*);
void mocked_call_for(std::string, Shader*);
void mocked_call_for(std::string, Sound*);
void mocked_call_for(std::string, Texture*);
void mocked_call_for(std::string, Vector2*);

void append_taylor_raylib(mrb_state*, RClass*);
