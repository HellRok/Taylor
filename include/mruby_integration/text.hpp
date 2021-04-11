#pragma once

#include "mruby.h"

// Font loading/unloading functions
//Font GetFontDefault(void);
//Font LoadFont(const char *fileName);
//Font LoadFontEx(const char *fileName, int fontSize, int *fontChars, int charsCount);
//Font LoadFontFromImage(Image image, Color key, int firstChar);
//Font LoadFontFromMemory(const char *fileType, const unsigned char *fileData, int dataSize, int fontSize, int *fontChars, int charsCount);
//CharInfo *LoadFontData(const unsigned char *fileData, int dataSize, int fontSize, int *fontChars, int charsCount, int type);
//Image GenImageFontAtlas(const CharInfo *chars, Rectangle **recs, int charsCount, int fontSize, int padding, int packMethod);
//void UnloadFontData(CharInfo *chars, int charsCount);
//void UnloadFont(Font font);

// Text drawing functions
void DrawFPS(int posX, int posY);                                                               // Draw current FPS
//void DrawText(const char *text, int posX, int posY, int fontSize, Color color);
//void DrawTextEx(Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint);
//void DrawTextRec(Font font, const char *text, Rectangle rec, float fontSize, float spacing, bool wordWrap, Color tint);
//void DrawTextRecEx(Font font, const char *text, Rectangle rec, float fontSize, float spacing, bool wordWrap, Color tint,
//  int selectStart, int selectLength, Color selectTint, Color selectBackTint);
//void DrawTextCodepoint(Font font, int codepoint, Vector2 position, float fontSize, Color tint);

// Text misc. functions
//int MeasureText(const char *text, int fontSize);
//Vector2 MeasureTextEx(Font font, const char *text, float fontSize, float spacing);
//int GetGlyphIndex(Font font, int codepoint);

// Text strings management functions (no utf8 strings, only byte chars)         
// NOTE: Some strings allocate memory internally for returned strings, just be careful!         
//int TextCopy(char *dst, const char *src);
//bool TextIsEqual(const char *text1, const char *text2);
//unsigned int TextLength(const char *text);
//const char *TextFormat(const char *text, ...);
//const char *TextSubtext(const char *text, int position, int length);
//char *TextReplace(char *text, const char *replace, const char *by);
//char *TextInsert(const char *text, const char *insert, int position);
//const char *TextJoin(const char **textList, int count, const char *delimiter);
//const char **TextSplit(const char *text, char delimiter, int *count);
//void TextAppend(char *text, const char *append, int *position);
//int TextFindIndex(const char *text, const char *find);
//const char *TextToUpper(const char *text);
//const char *TextToLower(const char *text);
//const char *TextToPascal(const char *text);
//int TextToInteger(const char *text);
//char *TextToUtf8(int *codepoints, int length);

// UTF8 text strings management functions
//int *GetCodepoints(const char *text, int *count);
//int GetCodepointsCount(const char *text);
//int GetNextCodepoint(const char *text, int *bytesProcessed);
//const char *CodepointToUtf8(int codepoint, int *byteLength);

void appendText(mrb_state*);
