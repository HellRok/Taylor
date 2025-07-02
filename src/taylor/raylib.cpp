#include <cstring>
#include <deque>
#include <sstream>
#include <string>
#include <unordered_map>
#include <vector>

#include "mruby.h"
#include "mruby/array.h"

#include "raylib.h"

std::vector<std::string> raylib_method_calls;
std::unordered_map<std::string, std::deque<std::string>>
  raylib_method_call_mock_returns;

auto
append_call(std::string call) -> void
{
  raylib_method_calls.push_back(call);
}

struct mock_result
{
  std::string value;
  bool found;
};

auto
next_mock_for(std::string method) -> mock_result
{
  mock_result result{ "", false };

  if (raylib_method_call_mock_returns.count(method) == 0) {
    return result;
  }

  result.found = true;
  result.value = raylib_method_call_mock_returns[method].front();
  raylib_method_call_mock_returns[method].pop_front();

  if (raylib_method_call_mock_returns[method].empty()) {
    raylib_method_call_mock_returns.erase(method);
  }

  return result;
}

auto
mrb_Taylor_Raylib_mocked(mrb_state*, mrb_value) -> mrb_value
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

#ifdef MOCK_RAYLIB
auto
mocked_const_char_call_for(std::string method) -> const char*
{
  mock_result mock = next_mock_for(method);

  if (mock.found) {
    // Do this little dance or the pointer will point to junk soon
    std::string mocked_value = mock.value;
    char* result = new char[mocked_value.length() + 1];
    strcpy(result, mocked_value.c_str());
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

  mock_result mock = next_mock_for(method);
  if (mock.found) {
    *result = (mock.value == "true");
  }
}

auto
mocked_call_for(std::string method, double* result) -> void
{
  *result = 1.0;

  mock_result mock = next_mock_for(method);
  if (mock.found) {
    *result = std::stof(mock.value);
  }
}

auto
mocked_call_for(std::string method, float* result) -> void
{
  *result = 1.0f;

  mock_result mock = next_mock_for(method);
  if (mock.found) {
    *result = std::stof(mock.value);
  }
}

auto
mocked_call_for(std::string method, int* result) -> void
{
  *result = 1;

  mock_result mock = next_mock_for(method);
  if (mock.found) {
    *result = std::stoi(mock.value);
  }
}

auto
mocked_call_for(std::string, Color* result) -> void
{
  *result = Color{ 0, 0, 0, 0 };
}

auto
mocked_call_for(std::string method, FilePathList* result) -> void
{
  const unsigned int capacity = 8;
  auto** paths = static_cast<char**>(malloc(sizeof(char*) * capacity));
  *result = FilePathList{ capacity, 0, paths };

  mock_result mock = next_mock_for(method);
  if (mock.found) {
    std::string temp;
    std::stringstream stream(mock.value);

    while (stream.good()) {
      stream >> temp;
      paths[result->count] = strdup(temp.c_str());
      result->count++;
    }
  }
}

auto
mocked_call_for(std::string method, Font* result) -> void
{
  auto rectangle = Rectangle{ 0, 0, 0, 0 };
  auto glyph_info = GlyphInfo{};
  int size = 0;
  int glyph_count = 0;
  int glyph_padding = 0;

  mock_result mock = next_mock_for(method);
  if (mock.found) {
    std::string temp;
    std::stringstream stream(mock.value);

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

  mock_result mock = next_mock_for(method);
  if (mock.found) {
    std::string temp;
    std::stringstream stream(mock.value);

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

  mock_result mock = next_mock_for(method);
  if (mock.found) {
    std::string temp;
    std::stringstream stream(mock.value);

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

  mock_result mock = next_mock_for(method);
  if (mock.found) {
    std::string temp;
    std::stringstream stream(mock.value);

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

  mock_result mock = next_mock_for(method);
  if (mock.found) {
    id = std::stoi(mock.value);
  }

  *result = Shader{ id, 0 };
}

auto
mocked_call_for(std::string method, Sound* result) -> void
{
  unsigned int frame_count = 0;

  mock_result mock = next_mock_for(method);
  if (mock.found) {
    frame_count = std::stoi(mock.value);
  }

  *result = Sound{ AudioStream{}, frame_count };
}

auto
mocked_call_for(std::string method, Texture* result) -> void
{
  unsigned int id = 0;
  int width = 0;
  int height = 0;
  int mipmaps = 0;
  int format = 0;

  mock_result mock = next_mock_for(method);
  if (mock.found) {
    std::string temp;
    std::stringstream stream(mock.value);

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

  mock_result mock = next_mock_for(method);
  if (mock.found) {
    std::string temp;
    std::stringstream stream(mock.value);

    stream >> temp;
    x = std::stof(temp);
    stream >> temp;
    y = std::stof(temp);
  }
  *result = Vector2{ x, y };
}
#endif // MOCK_RAYLIB

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
mrb_Taylor_Raylib_all_mocks_used(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(raylib_method_call_mock_returns.empty());
}

auto
mrb_Taylor_Raylib_reset_calls(mrb_state*, mrb_value) -> mrb_value
{
  raylib_method_calls.clear();

  return mrb_nil_value();
}

auto
mrb_Taylor_Raylib_clear_mocks(mrb_state*, mrb_value) -> mrb_value
{
  raylib_method_call_mock_returns.clear();

  return mrb_nil_value();
}

void
append_taylor_raylib(mrb_state* mrb, RClass* Taylor_module)
{
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
  mrb_define_class_method(mrb,
                          Raylib_module,
                          "all_mocks_used?",
                          mrb_Taylor_Raylib_all_mocks_used,
                          MRB_ARGS_NONE());
  mrb_define_class_method(mrb,
                          Raylib_module,
                          "clear_mocks",
                          mrb_Taylor_Raylib_clear_mocks,
                          MRB_ARGS_NONE());
}
