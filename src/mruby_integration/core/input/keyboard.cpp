#include "raylib.h"
#include "mruby.h"
#include "mruby/compile.h"

mrb_value mrb_is_key_down(mrb_state *mrb, mrb_value) {
  mrb_int key;
  mrb_get_args(mrb, "i", &key);

  return mrb_bool_value(IsKeyDown(key));
}

mrb_value mrb_is_key_pressed(mrb_state *mrb, mrb_value) {
  mrb_int key;
  mrb_get_args(mrb, "i", &key);

  return mrb_bool_value(IsKeyPressed(key));
}

void append_core_input_keyboard(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "is_key_down", mrb_is_key_down, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "is_key_pressed", mrb_is_key_pressed, MRB_ARGS_REQ(1));
  mrb_load_string(mrb, R"(
    # Alphanumeric keys
    KEY_APOSTROPHE      = 39
    KEY_COMMA           = 44
    KEY_MINUS           = 45
    KEY_PERIOD          = 46
    KEY_SLASH           = 47
    KEY_ZERO            = 48
    KEY_ONE             = 49
    KEY_TWO             = 50
    KEY_THREE           = 51
    KEY_FOUR            = 52
    KEY_FIVE            = 53
    KEY_SIX             = 54
    KEY_SEVEN           = 55
    KEY_EIGHT           = 56
    KEY_NINE            = 57
    KEY_SEMICOLON       = 59
    KEY_EQUAL           = 61
    KEY_A               = 65
    KEY_B               = 66
    KEY_C               = 67
    KEY_D               = 68
    KEY_E               = 69
    KEY_F               = 70
    KEY_G               = 71
    KEY_H               = 72
    KEY_I               = 73
    KEY_J               = 74
    KEY_K               = 75
    KEY_L               = 76
    KEY_M               = 77
    KEY_N               = 78
    KEY_O               = 79
    KEY_P               = 80
    KEY_Q               = 81
    KEY_R               = 82
    KEY_S               = 83
    KEY_T               = 84
    KEY_U               = 85
    KEY_V               = 86
    KEY_W               = 87
    KEY_X               = 88
    KEY_Y               = 89
    KEY_Z               = 90

    # Function keys
    KEY_SPACE           = 32
    KEY_ESCAPE          = 256
    KEY_ENTER           = 257
    KEY_TAB             = 258
    KEY_BACKSPACE       = 259
    KEY_INSERT          = 260
    KEY_DELETE          = 261
    KEY_RIGHT           = 262
    KEY_LEFT            = 263
    KEY_DOWN            = 264
    KEY_UP              = 265
    KEY_PAGE_UP         = 266
    KEY_PAGE_DOWN       = 267
    KEY_HOME            = 268
    KEY_END             = 269
    KEY_CAPS_LOCK       = 280
    KEY_SCROLL_LOCK     = 281
    KEY_NUM_LOCK        = 282
    KEY_PRINT_SCREEN    = 283
    KEY_PAUSE           = 284
    KEY_F1              = 290
    KEY_F2              = 291
    KEY_F3              = 292
    KEY_F4              = 293
    KEY_F5              = 294
    KEY_F6              = 295
    KEY_F7              = 296
    KEY_F8              = 297
    KEY_F9              = 298
    KEY_F10             = 299
    KEY_F11             = 300
    KEY_F12             = 301
    KEY_LEFT_SHIFT      = 340
    KEY_LEFT_CONTROL    = 341
    KEY_LEFT_ALT        = 342
    KEY_LEFT_SUPER      = 343
    KEY_RIGHT_SHIFT     = 344
    KEY_RIGHT_CONTROL   = 345
    KEY_RIGHT_ALT       = 346
    KEY_RIGHT_SUPER     = 347
    KEY_KB_MENU         = 348
    KEY_LEFT_BRACKET    = 91
    KEY_BACKSLASH       = 92
    KEY_RIGHT_BRACKET   = 93
    KEY_GRAVE           = 96

    # Keypad keys
    KEY_KP_0            = 32
    KEY_KP_1            = 32
    KEY_KP_2            = 32
    KEY_KP_3            = 32
    KEY_KP_4            = 32
    KEY_KP_5            = 32
    KEY_KP_6            = 32
    KEY_KP_7            = 32
    KEY_KP_8            = 32
    KEY_KP_9            = 32
    KEY_KP_DECIMAL      = 33
    KEY_KP_DIVIDE       = 33
    KEY_KP_MULTIPLY     = 33
    KEY_KP_SUBTRACT     = 33
    KEY_KP_ADD          = 33
    KEY_KP_ENTER        = 33
    KEY_KP_EQUAL        = 336
  )");
}