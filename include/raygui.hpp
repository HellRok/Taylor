#pragma once

#define RAYGUI_SUPPORT_ICONS

#ifndef RAYGUI_H
#define RAYGUI_H

#define RAYGUI_VERSION  "2.6-dev"

#if !defined(RAYGUI_STANDALONE)
    #include "raylib.h"
#endif

// Define functions scope to be used internally (static) or externally (extern) to the module including this file
#if defined(RAYGUI_STATIC)
    #define RAYGUIDEF static            // Functions just visible to module including this file
#else
    #ifdef __cplusplus
        #define RAYGUIDEF extern "C"    // Functions visible from other files (no name mangling of functions in C++)
    #else
        // NOTE: By default any function declared in a C file is extern
        #define RAYGUIDEF extern        // Functions visible from other files
    #endif
#endif

#if defined(_WIN32)
    #if defined(BUILD_LIBTYPE_SHARED)
        #define RAYGUIDEF __declspec(dllexport)     // We are building raygui as a Win32 shared library (.dll).
    #elif defined(USE_LIBTYPE_SHARED)
        #define RAYGUIDEF __declspec(dllimport)     // We are using raygui as a Win32 shared library (.dll)
    #endif
#endif


#if !defined(RAYGUI_MALLOC) && !defined(RAYGUI_CALLOC) && !defined(RAYGUI_FREE)
    #include <stdlib.h>                 // Required for: malloc(), calloc(), free()
#endif

// Allow custom memory allocators
#ifndef RAYGUI_MALLOC
    #define RAYGUI_MALLOC(sz)       malloc(sz)
#endif
#ifndef RAYGUI_CALLOC
    #define RAYGUI_CALLOC(n,sz)     calloc(n,sz)
#endif
#ifndef RAYGUI_FREE
    #define RAYGUI_FREE(p)          free(p)
#endif

//----------------------------------------------------------------------------------
// Defines and Macros
//----------------------------------------------------------------------------------
#define NUM_CONTROLS                    16      // Number of standard controls
#define NUM_PROPS_DEFAULT               16      // Number of standard properties
#define NUM_PROPS_EXTENDED               8      // Number of extended properties

#define TEXTEDIT_CURSOR_BLINK_FRAMES    20      // Text edit controls cursor blink timming

//----------------------------------------------------------------------------------
// Types and Structures Definition
// NOTE: Some types are required for RAYGUI_STANDALONE usage
//----------------------------------------------------------------------------------
#if defined(RAYGUI_STANDALONE)
    #ifndef __cplusplus
    // Boolean type
        #ifndef true
            typedef enum { false, true } bool;
        #endif
    #endif

    // Vector2 type
    typedef struct Vector2 {
        float x;
        float y;
    } Vector2;

    // Vector3 type
    typedef struct Vector3 {
        float x;
        float y;
        float z;
    } Vector3;

    // Color type, RGBA (32bit)
    typedef struct Color {
        unsigned char r;
        unsigned char g;
        unsigned char b;
        unsigned char a;
    } Color;

    // Rectangle type
    typedef struct Rectangle {
        float x;
        float y;
        float width;
        float height;
    } Rectangle;

    // TODO: Texture2D type is very coupled to raylib, mostly required by GuiImageButton()
    // It should be redesigned to be provided by user
    typedef struct Texture2D {
        unsigned int id;        // OpenGL texture id
        int width;              // Texture base width
        int height;             // Texture base height
        int mipmaps;            // Mipmap levels, 1 by default
        int format;             // Data format (PixelFormat type)
    } Texture2D;

    // Font character info
    typedef struct CharInfo CharInfo;

    // TODO: Font type is very coupled to raylib, mostly required by GuiLoadStyle()
    // It should be redesigned to be provided by user
    typedef struct Font {
        int baseSize;           // Base size (default chars height)
        int charsCount;         // Number of characters
        Texture2D texture;      // Characters texture atlas
        Rectangle *recs;        // Characters rectangles in texture
        CharInfo *chars;        // Characters info data
    } Font;
#endif

// Style property
typedef struct GuiStyleProp {
    unsigned short controlId;
    unsigned short propertyId;
    int propertyValue;
} GuiStyleProp;

// Gui control state
typedef enum {
    GUI_STATE_NORMAL = 0,
    GUI_STATE_FOCUSED,
    GUI_STATE_PRESSED,
    GUI_STATE_DISABLED,
} GuiControlState;

// Gui control text alignment
typedef enum {
    GUI_TEXT_ALIGN_LEFT = 0,
    GUI_TEXT_ALIGN_CENTER,
    GUI_TEXT_ALIGN_RIGHT,
} GuiTextAlignment;

// Gui controls
typedef enum {
    DEFAULT = 0,
    LABEL,          // LABELBUTTON
    BUTTON,         // IMAGEBUTTON
    TOGGLE,         // TOGGLEGROUP
    SLIDER,         // SLIDERBAR
    PROGRESSBAR,
    CHECKBOX,
    COMBOBOX,
    DROPDOWNBOX,
    TEXTBOX,        // TEXTBOXMULTI
    VALUEBOX,
    SPINNER,
    LISTVIEW,
    COLORPICKER,
    SCROLLBAR,
    STATUSBAR
} GuiControl;

// Gui base properties for every control
typedef enum {
    BORDER_COLOR_NORMAL = 0,
    BASE_COLOR_NORMAL,
    TEXT_COLOR_NORMAL,
    BORDER_COLOR_FOCUSED,
    BASE_COLOR_FOCUSED,
    TEXT_COLOR_FOCUSED,
    BORDER_COLOR_PRESSED,
    BASE_COLOR_PRESSED,
    TEXT_COLOR_PRESSED,
    BORDER_COLOR_DISABLED,
    BASE_COLOR_DISABLED,
    TEXT_COLOR_DISABLED,
    BORDER_WIDTH,
    TEXT_PADDING,
    TEXT_ALIGNMENT,
    RESERVED,

    // Gui extended properties depend on control
    // NOTE: We reserve a fixed size of additional properties per control

    // DEFAULT properties
    TEXT_SIZE,
    TEXT_SPACING,
    LINE_COLOR,
    BACKGROUND_COLOR,
} GuiControlProperty;

// Label
//typedef enum { } GuiLabelProperty;

// Button
//typedef enum { } GuiButtonProperty;

// Toggle / ToggleGroup
typedef enum {
    GROUP_PADDING = 16,
} GuiToggleProperty;

// Slider / SliderBar
typedef enum {
    SLIDER_WIDTH = 16,
    SLIDER_PADDING
} GuiSliderProperty;

// ProgressBar
typedef enum {
    PROGRESS_PADDING = 16,
} GuiProgressBarProperty;

// CheckBox
typedef enum {
    CHECK_PADDING = 16
} GuiCheckBoxProperty;

// ComboBox
typedef enum {
    COMBO_BUTTON_WIDTH = 16,
    COMBO_BUTTON_PADDING
} GuiComboBoxProperty;

// DropdownBox
typedef enum {
    ARROW_PADDING = 16,
    DROPDOWN_ITEMS_PADDING
} GuiDropdownBoxProperty;

// TextBox / TextBoxMulti / ValueBox / Spinner
typedef enum {
    TEXT_INNER_PADDING = 16,
    TEXT_LINES_PADDING,
    COLOR_SELECTED_FG,
    COLOR_SELECTED_BG
} GuiTextBoxProperty;

// Spinner
typedef enum {
    SPIN_BUTTON_WIDTH = 16,
    SPIN_BUTTON_PADDING,
} GuiSpinnerProperty;

// ScrollBar
typedef enum {
    ARROWS_SIZE = 16,
    ARROWS_VISIBLE,
    SCROLL_SLIDER_PADDING,
    SCROLL_SLIDER_SIZE,
    SCROLL_PADDING,
    SCROLL_SPEED,
} GuiScrollBarProperty;

// ScrollBar side
typedef enum {
    SCROLLBAR_LEFT_SIDE = 0,
    SCROLLBAR_RIGHT_SIDE
} GuiScrollBarSide;

// ListView
typedef enum {
    LIST_ITEMS_HEIGHT = 16,
    LIST_ITEMS_PADDING,
    SCROLLBAR_WIDTH,
    SCROLLBAR_SIDE,
} GuiListViewProperty;

// ColorPicker
typedef enum {
    COLOR_SELECTOR_SIZE = 16,
    HUEBAR_WIDTH,                  // Right hue bar width
    HUEBAR_PADDING,                // Right hue bar separation from panel
    HUEBAR_SELECTOR_HEIGHT,        // Right hue bar selector height
    HUEBAR_SELECTOR_OVERFLOW       // Right hue bar selector overflow
} GuiColorPickerProperty;

//----------------------------------------------------------------------------------
// Global Variables Definition
//----------------------------------------------------------------------------------
// ...

//----------------------------------------------------------------------------------
// Module Functions Declaration
//----------------------------------------------------------------------------------

// State modification functions
RAYGUIDEF void GuiEnable(void);                                         // Enable gui controls (global state)
RAYGUIDEF void GuiDisable(void);                                        // Disable gui controls (global state)
RAYGUIDEF void GuiLock(void);                                           // Lock gui controls (global state)
RAYGUIDEF void GuiUnlock(void);                                         // Unlock gui controls (global state)
RAYGUIDEF void GuiFade(float alpha);                                    // Set gui controls alpha (global state), alpha goes from 0.0f to 1.0f
RAYGUIDEF void GuiSetState(int state);                                  // Set gui state (global state)
RAYGUIDEF int GuiGetState(void);                                        // Get gui state (global state)

// Font set/get functions
RAYGUIDEF void GuiSetFont(Font font);                                   // Set gui custom font (global state)
RAYGUIDEF Font GuiGetFont(void);                                        // Get gui custom font (global state)

// Style set/get functions
RAYGUIDEF void GuiSetStyle(int control, int property, int value);       // Set one style property
RAYGUIDEF int GuiGetStyle(int control, int property);                   // Get one style property

// Tooltips set functions
RAYGUIDEF void GuiEnableTooltip(void);                                  // Enable gui tooltips
RAYGUIDEF void GuiDisableTooltip(void);                                 // Disable gui tooltips
RAYGUIDEF void GuiSetTooltip(const char *tooltip);                      // Set current tooltip for display
RAYGUIDEF void GuiClearTooltip(void);                                   // Clear any tooltip registered

// Container/separator controls, useful for controls organization
RAYGUIDEF bool GuiWindowBox(Rectangle bounds, const char *title);                                       // Window Box control, shows a window that can be closed
RAYGUIDEF void GuiGroupBox(Rectangle bounds, const char *text);                                         // Group Box control with text name
RAYGUIDEF void GuiLine(Rectangle bounds, const char *text);                                             // Line separator control, could contain text
RAYGUIDEF void GuiPanel(Rectangle bounds);                                                              // Panel control, useful to group controls
RAYGUIDEF Rectangle GuiScrollPanel(Rectangle bounds, Rectangle content, Vector2 *scroll);               // Scroll Panel control

// Basic controls set
RAYGUIDEF void GuiLabel(Rectangle bounds, const char *text);                                            // Label control, shows text
RAYGUIDEF bool GuiButton(Rectangle bounds, const char *text);                                           // Button control, returns true when clicked
RAYGUIDEF bool GuiLabelButton(Rectangle bounds, const char *text);                                      // Label button control, show true when clicked
RAYGUIDEF bool GuiImageButton(Rectangle bounds, const char *text, Texture2D texture);                   // Image button control, returns true when clicked
RAYGUIDEF bool GuiImageButtonEx(Rectangle bounds, const char *text, Texture2D texture, Rectangle texSource);    // Image button extended control, returns true when clicked
RAYGUIDEF bool GuiToggle(Rectangle bounds, const char *text, bool active);                              // Toggle Button control, returns true when active
RAYGUIDEF int GuiToggleGroup(Rectangle bounds, const char *text, int active);                           // Toggle Group control, returns active toggle index
RAYGUIDEF bool GuiCheckBox(Rectangle bounds, const char *text, bool checked);                           // Check Box control, returns true when active
RAYGUIDEF int GuiComboBox(Rectangle bounds, const char *text, int active);                              // Combo Box control, returns selected item index
RAYGUIDEF bool GuiDropdownBox(Rectangle bounds, const char *text, int *active, bool editMode);          // Dropdown Box control, returns selected item
RAYGUIDEF bool GuiSpinner(Rectangle bounds, const char *text, int *value, int minValue, int maxValue, bool editMode);     // Spinner control, returns selected value
RAYGUIDEF bool GuiValueBox(Rectangle bounds, const char *text, int *value, int minValue, int maxValue, bool editMode);    // Value Box control, updates input text with numbers
RAYGUIDEF bool GuiTextBox(Rectangle bounds, char *text, int textSize, bool editMode);                   // Text Box control, updates input text
RAYGUIDEF bool GuiTextBoxMulti(Rectangle bounds, char *text, int textSize, bool editMode);              // Text Box control with multiple lines
RAYGUIDEF float GuiSlider(Rectangle bounds, const char *textLeft, const char *textRight, float value, float minValue, float maxValue);       // Slider control, returns selected value
RAYGUIDEF float GuiSliderBar(Rectangle bounds, const char *textLeft, const char *textRight, float value, float minValue, float maxValue);    // Slider Bar control, returns selected value
RAYGUIDEF float GuiProgressBar(Rectangle bounds, const char *textLeft, const char *textRight, float value, float minValue, float maxValue);  // Progress Bar control, shows current progress value
RAYGUIDEF void GuiStatusBar(Rectangle bounds, const char *text);                                        // Status Bar control, shows info text
RAYGUIDEF void GuiDummyRec(Rectangle bounds, const char *text);                                         // Dummy control for placeholders
RAYGUIDEF int GuiScrollBar(Rectangle bounds, int value, int minValue, int maxValue);                    // Scroll Bar control
RAYGUIDEF Vector2 GuiGrid(Rectangle bounds, float spacing, int subdivs);                                // Grid control

// Advance controls set
RAYGUIDEF int GuiListView(Rectangle bounds, const char *text, int *scrollIndex, int active);            // List View control, returns selected list item index
RAYGUIDEF int GuiListViewEx(Rectangle bounds, const char **text, int count, int *focus, int *scrollIndex, int active);      // List View with extended parameters
RAYGUIDEF int GuiMessageBox(Rectangle bounds, const char *title, const char *message, const char *buttons);                 // Message Box control, displays a message
RAYGUIDEF int GuiTextInputBox(Rectangle bounds, const char *title, const char *message, const char *buttons, char *text);   // Text Input Box control, ask for text
RAYGUIDEF Color GuiColorPicker(Rectangle bounds, Color color);                                          // Color Picker control (multiple color controls)
RAYGUIDEF Color GuiColorPanel(Rectangle bounds, Color color);                                           // Color Panel control
RAYGUIDEF float GuiColorBarAlpha(Rectangle bounds, float alpha);                                        // Color Bar Alpha control
RAYGUIDEF float GuiColorBarHue(Rectangle bounds, float value);                                          // Color Bar Hue control

// Styles loading functions
RAYGUIDEF void GuiLoadStyle(const char *fileName);              // Load style file (.rgs)
RAYGUIDEF void GuiLoadStyleDefault(void);                       // Load style default over global style

/*
typedef GuiStyle (unsigned int *)
RAYGUIDEF GuiStyle LoadGuiStyle(const char *fileName);          // Load style from file (.rgs)
RAYGUIDEF void UnloadGuiStyle(GuiStyle style);                  // Unload style
*/

RAYGUIDEF const char *GuiIconText(int iconId, const char *text); // Get text with icon id prepended (if supported)

#if defined(RAYGUI_SUPPORT_ICONS)
// Gui icons functionality
RAYGUIDEF void GuiDrawIcon(int iconId, Vector2 position, int pixelSize, Color color);

RAYGUIDEF unsigned int *GuiGetIcons(void);                      // Get full icons data pointer
RAYGUIDEF unsigned int *GuiGetIconData(int iconId);             // Get icon bit data
RAYGUIDEF void GuiSetIconData(int iconId, unsigned int *data);  // Set icon bit data

RAYGUIDEF void GuiSetIconPixel(int iconId, int x, int y);       // Set icon pixel value
RAYGUIDEF void GuiClearIconPixel(int iconId, int x, int y);     // Clear icon pixel value
RAYGUIDEF bool GuiCheckIconPixel(int iconId, int x, int y);     // Check icon pixel value
#endif

#endif // RAYGUI_H
