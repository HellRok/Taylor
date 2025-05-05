#include <deque>
#include <sstream>
#include <string>
#include <unordered_map>
#include <vector>

#include "mruby.h"
#include "mruby/array.h"
#include "mruby/compile.h"

#include "raylib.h"

std::vector<std::string> raylib_method_calls;
std::unordered_map<std::string, std::deque<std::string>>
  raylib_method_call_mock_returns;

auto
append_call(std::string call) -> void
{
  raylib_method_calls.push_back(call);
}

auto
mrb_Taylor_Raylib_mocked(mrb_state* mrb, mrb_value) -> mrb_value
{
#ifdef MOCK_RAYLIB
  return mrb_true_value();
#else
  return mrb_false_value();
#endif
}

auto
mrb_Taylor_Raylib_calls(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_value result;
  result = mrb_ary_new_capa(mrb, raylib_method_calls.size());

  for (auto& raylib_method_call : raylib_method_calls) {
    mrb_ary_push(
      mrb, result, mrb_str_new_cstr(mrb, raylib_method_call.c_str()));
  }

  return result;
}

auto
mocked_const_char_call_for(std::string method) -> const char*
{
  if (raylib_method_call_mock_returns.count(method) > 0 &&
      !raylib_method_call_mock_returns[method].empty()) {
    const char* result =
      raylib_method_call_mock_returns[method].front().c_str();
    raylib_method_call_mock_returns[method].pop_front();
    return result;
  }

  return "default";
}

auto
mocked_call_for_LoadImageColors(Color* result) -> void
{
}

auto
mocked_call_for(std::string method, bool* result) -> void
{
  *result = true;

  if (raylib_method_call_mock_returns.count(method) > 0 &&
      !raylib_method_call_mock_returns[method].empty()) {
    *result = (raylib_method_call_mock_returns[method].front() == "true");
    raylib_method_call_mock_returns[method].pop_front();
  }
}

auto
mocked_call_for(std::string method, double* result) -> void
{
  *result = 1.0;

  if (raylib_method_call_mock_returns.count(method) > 0 &&
      !raylib_method_call_mock_returns[method].empty()) {
    *result = std::stof(raylib_method_call_mock_returns[method].front());
    raylib_method_call_mock_returns[method].pop_front();
  }
}

auto
mocked_call_for(std::string method, float* result) -> void
{
  *result = 1.0f;

  if (raylib_method_call_mock_returns.count(method) > 0 &&
      !raylib_method_call_mock_returns[method].empty()) {
    *result = std::stof(raylib_method_call_mock_returns[method].front());
    raylib_method_call_mock_returns[method].pop_front();
  }
}

auto
mocked_call_for(std::string method, int* result) -> void
{
  *result = 1;

  if (raylib_method_call_mock_returns.count(method) > 0 &&
      !raylib_method_call_mock_returns[method].empty()) {
    *result = std::stoi(raylib_method_call_mock_returns[method].front());
    raylib_method_call_mock_returns[method].pop_front();
  }
}

auto
mocked_call_for(std::string method, Color* result) -> void
{
  *result = Color{ 0, 0, 0, 0 };
}

auto
mocked_call_for(std::string method, FilePathList* result) -> void
{
  *result = FilePathList{ 0, 0 };
}

auto
mocked_call_for(std::string method, Font* result) -> void
{
  auto rectangle = Rectangle{ 0, 0, 0, 0 };
  auto glyph_info = GlyphInfo{};
  int size = 0;
  int glyph_count = 0;
  int glyph_padding = 0;

  if (raylib_method_call_mock_returns.count(method) > 0 &&
      !raylib_method_call_mock_returns[method].empty()) {

    std::string mock = raylib_method_call_mock_returns[method].front();
    raylib_method_call_mock_returns[method].pop_front();

    std::string temp;
    std::stringstream stream(mock);

    stream >> temp;
    size = std::stoi(temp);
    stream >> temp;
    glyph_count = std::stoi(temp);
    stream >> temp;
    glyph_padding = std::stoi(temp);
  }

  *result = Font{ size,        glyph_count, glyph_padding,
                  Texture2D{}, &rectangle,  &glyph_info };
}

auto
mocked_call_for(std::string method, Image* result) -> void
{
  // Gotta dereference something I guess?
  std::string data = "hello";
  int width = 0;
  int height = 0;
  int mipmaps = 0;
  int format = 0;

  if (raylib_method_call_mock_returns.count(method) > 0 &&
      !raylib_method_call_mock_returns[method].empty()) {

    std::string mock = raylib_method_call_mock_returns[method].front();
    raylib_method_call_mock_returns[method].pop_front();

    std::string temp;
    std::stringstream stream(mock);

    stream >> temp;
    width = std::stoi(temp);
    stream >> temp;
    height = std::stoi(temp);
    stream >> temp;
    mipmaps = std::stoi(temp);
    stream >> temp;
    format = std::stoi(temp);
  }

  *result = Image{ &data, width, height, mipmaps, format };
}

auto
mocked_call_for(std::string method, Music* result) -> void
{
  unsigned int sample_rate = 0;
  unsigned int sample_size = 0;
  unsigned int channels = 0;
  unsigned int frame_count = 0;
  bool looping = false;
  int ctx_type = 0;

  if (raylib_method_call_mock_returns.count(method) > 0 &&
      !raylib_method_call_mock_returns[method].empty()) {

    std::string mock = raylib_method_call_mock_returns[method].front();
    raylib_method_call_mock_returns[method].pop_front();

    std::string temp;
    std::stringstream stream(mock);

    stream >> temp;
    sample_rate = std::stoi(temp);
    stream >> temp;
    sample_size = std::stoi(temp);
    stream >> temp;
    channels = std::stoi(temp);
    stream >> temp;
    frame_count = std::stoi(temp);
    stream >> temp;
    looping = (temp == "true");
    stream >> temp;
    ctx_type = std::stoi(temp);
  }

  *result = Music{
    AudioStream{ 0, 0, sample_rate, sample_size, channels },
    frame_count,
    looping,
    ctx_type,
  };
}

auto
mocked_call_for(std::string method, RenderTexture* result) -> void
{
  int width = 0;
  int height = 0;

  if (raylib_method_call_mock_returns.count(method) > 0 &&
      !raylib_method_call_mock_returns[method].empty()) {

    std::string mock = raylib_method_call_mock_returns[method].front();
    raylib_method_call_mock_returns[method].pop_front();

    std::string temp;
    std::stringstream stream(mock);

    stream >> temp;
    width = std::stoi(temp);
    stream >> temp;
    height = std::stoi(temp);
  }

  *result = RenderTexture{
    0,
    Texture{ 0, width, height, 0, 0 },
    Texture{ 0, width, height, 0, 0 },
  };
}

auto
mocked_call_for(std::string method, Shader* result) -> void
{
  unsigned int id = 0;

  if (raylib_method_call_mock_returns.count(method) > 0 &&
      !raylib_method_call_mock_returns[method].empty()) {

    std::string mock = raylib_method_call_mock_returns[method].front();
    raylib_method_call_mock_returns[method].pop_front();

    id = std::stoi(mock);
  }
  *result = Shader{ id, 0 };
}

auto
mocked_call_for(std::string method, Sound* result) -> void
{
  unsigned int frame_count = 0;

  if (raylib_method_call_mock_returns.count(method) > 0 &&
      !raylib_method_call_mock_returns[method].empty()) {

    std::string mock = raylib_method_call_mock_returns[method].front();
    raylib_method_call_mock_returns[method].pop_front();

    frame_count = std::stoi(mock);
  }
  *result = Sound{ AudioStream{}, frame_count };
}

auto
mocked_call_for(std::string method, Texture* result) -> void
{
  unsigned int id;
  int width;
  int height;
  int mipmaps;
  int format;

  if (raylib_method_call_mock_returns.count(method) > 0 &&
      !raylib_method_call_mock_returns[method].empty()) {

    std::string mock = raylib_method_call_mock_returns[method].front();
    raylib_method_call_mock_returns[method].pop_front();

    std::string temp;
    std::stringstream stream(mock);

    stream >> temp;
    id = std::stoi(temp);
    stream >> temp;
    width = std::stoi(temp);
    stream >> temp;
    height = std::stoi(temp);
    stream >> temp;
    mipmaps = std::stoi(temp);
    stream >> temp;
    format = std::stoi(temp);
  }

  *result = Texture{ id, width, height, mipmaps, format };
}

auto
mocked_call_for(std::string method, Vector2* result) -> void
{
  float x = 0;
  float y = 0;

  if (raylib_method_call_mock_returns.count(method) > 0 &&
      !raylib_method_call_mock_returns[method].empty()) {

    std::string mock = raylib_method_call_mock_returns[method].front();
    raylib_method_call_mock_returns[method].pop_front();

    std::string temp;
    std::stringstream stream(mock);

    stream >> temp;
    x = std::stof(temp);
    stream >> temp;
    y = std::stof(temp);
  }
  *result = Vector2{ x, y };
}

auto
mrb_Taylor_Raylib_mock_call(mrb_state* mrb, mrb_value) -> mrb_value
{
  char* methodPtr;
  char* resultPtr;

  mrb_get_args(mrb, "zz", &methodPtr, &resultPtr);

  std::string method = methodPtr;
  std::string result = resultPtr;

  raylib_method_call_mock_returns[method].push_back(result);

  return mrb_nil_value();
}

auto
mrb_Taylor_Raylib_reset_calls(mrb_state* mrb, mrb_value) -> mrb_value
{
  raylib_method_calls.clear();

  return mrb_nil_value();
}

void
append_taylor(mrb_state* mrb)
{
  struct RClass* Taylor_module = mrb_define_module(mrb, "Taylor");
  struct RClass* Raylib_module =
    mrb_define_module_under(mrb, Taylor_module, "Raylib");
  mrb_define_class_method(
    mrb, Raylib_module, "mocked?", mrb_Taylor_Raylib_mocked, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Raylib_module, "calls", mrb_Taylor_Raylib_calls, MRB_ARGS_NONE());
  mrb_define_class_method(mrb,
                          Raylib_module,
                          "reset_calls",
                          mrb_Taylor_Raylib_reset_calls,
                          MRB_ARGS_NONE());
  mrb_define_class_method(mrb,
                          Raylib_module,
                          "mock_call",
                          mrb_Taylor_Raylib_mock_call,
                          MRB_ARGS_REQ(2));
}
