#pragma once

#include "mruby.h"

// Image loading functions
// NOTE: This functions do not require GPU access
//Image LoadImage(const char *fileName);
//Image LoadImageRaw(const char *fileName, int width, int height, int format, int headerSize);
//Image LoadImageAnim(const char *fileName, int *frames);
//Image LoadImageFromMemory(const char *fileType, const unsigned char *fileData, int dataSize);
//void UnloadImage(Image image);
//bool ExportImage(Image image, const char *fileName);
//bool ExportImageAsCode(Image image, const char *fileName);

// Image generation functions
//Image GenImageColor(int width, int height, Color color);
//Image GenImageGradientV(int width, int height, Color top, Color bottom);
//Image GenImageGradientH(int width, int height, Color left, Color right);
//Image GenImageGradientRadial(int width, int height, float density, Color inner, Color outer);
//Image GenImageChecked(int width, int height, int checksX, int checksY, Color col1, Color col2);
//Image GenImageWhiteNoise(int width, int height, float factor);
//Image GenImagePerlinNoise(int width, int height, int offsetX, int offsetY, float scale);
//Image GenImageCellular(int width, int height, int tileSize);

// Image manipulation functions
//Image ImageCopy(Image image);
//Image ImageFromImage(Image image, Rectangle rec);
//Image ImageText(const char *text, int fontSize, Color color);
//Image ImageTextEx(Font font, const char *text, float fontSize, float spacing, Color tint);
//void ImageFormat(Image *image, int newFormat);
//void ImageToPOT(Image *image, Color fill);
//void ImageCrop(Image *image, Rectangle crop);
//void ImageAlphaCrop(Image *image, float threshold);
//void ImageAlphaClear(Image *image, Color color, float threshold);
//void ImageAlphaMask(Image *image, Image alphaMask);
//void ImageAlphaPremultiply(Image *image);
//void ImageResize(Image *image, int newWidth, int newHeight);
//void ImageResizeNN(Image *image, int newWidth,int newHeight);
//void ImageResizeCanvas(Image *image, int newWidth, int newHeight, int offsetX, int offsetY, Color fill);
//void ImageMipmaps(Image *image);
//void ImageDither(Image *image, int rBpp, int gBpp, int bBpp, int aBpp);
//void ImageFlipVertical(Image *image);
//void ImageFlipHorizontal(Image *image);
//void ImageRotateCW(Image *image);
//void ImageRotateCCW(Image *image);
//void ImageColorTint(Image *image, Color color);
//void ImageColorInvert(Image *image);
//void ImageColorGrayscale(Image *image);
//void ImageColorContrast(Image *image, float contrast);
//void ImageColorBrightness(Image *image, int brightness);
//void ImageColorReplace(Image *image, Color color, Color replace);
//Color *LoadImageColors(Image image);
//Color *LoadImagePalette(Image image, int maxPaletteSize, int *colorsCount);
//void UnloadImageColors(Color *colors);
//void UnloadImagePalette(Color *colors);
//Rectangle GetImageAlphaBorder(Image image, float threshold);

// Image drawing functions
// NOTE: Image software-rendering functions (CPU)
//void ImageClearBackground(Image *dst, Color color);
//void ImageDrawPixel(Image *dst, int posX, int posY, Color color);
//void ImageDrawPixelV(Image *dst, Vector2 position, Color color);
//void ImageDrawLine(Image *dst, int startPosX, int startPosY, int endPosX, int endPosY, Color color);
//void ImageDrawLineV(Image *dst, Vector2 start, Vector2 end, Color color);
//void ImageDrawCircle(Image *dst, int centerX, int centerY, int radius, Color color);
//void ImageDrawCircleV(Image *dst, Vector2 center, int radius, Color color);
//void ImageDrawRectangle(Image *dst, int posX, int posY, int width, int height, Color color);
//void ImageDrawRectangleV(Image *dst, Vector2 position, Vector2 size, Color color);
//void ImageDrawRectangleRec(Image *dst, Rectangle rec, Color color);
//void ImageDrawRectangleLines(Image *dst, Rectangle rec, int thick, Color color);
//void ImageDraw(Image *dst, Image src, Rectangle srcRec, Rectangle dstRec, Color tint);
//void ImageDrawText(Image *dst, const char *text, int posX, int posY, int fontSize, Color color);
//void ImageDrawTextEx(Image *dst, Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint);

// Texture loading functions
// NOTE: These functions require GPU access
mrb_value MrbLoadTexture(mrb_state*, mrb_value);
//Texture2D LoadTextureFromImage(Image image);
//TextureCubemap LoadTextureCubemap(Image image, int layout);
//RenderTexture2D LoadRenderTexture(int width, int height);
//void UnloadTexture(Texture2D texture);
//void UnloadRenderTexture(RenderTexture2D target);
//void UpdateTexture(Texture2D texture, const void *pixels);
//void UpdateTextureRec(Texture2D texture, Rectangle rec, const void *pixels);
//Image GetTextureData(Texture2D texture);
//Image GetScreenData(void);

// Texture configuration functions
//void GenTextureMipmaps(Texture2D *texture);
//void SetTextureFilter(Texture2D texture, int filter);
//void SetTextureWrap(Texture2D texture, int wrap);

// Texture drawing functions
mrb_value MrbDrawTexture(mrb_state*, mrb_value);
//void DrawTextureV(Texture2D texture, Vector2 position, Color tint);
//void DrawTextureEx(Texture2D texture, Vector2 position, float rotation, float scale, Color tint);
//void DrawTextureRec(Texture2D texture, Rectangle source, Vector2 position, Color tint);
//void DrawTextureQuad(Texture2D texture, Vector2 tiling, Vector2 offset, Rectangle quad, Color tint);
//void DrawTextureTiled(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, float scale, Color tint);
//void DrawTexturePro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint);
//void DrawTextureNPatch(Texture2D texture, NPatchInfo nPatchInfo, Rectangle dest, Vector2 origin, float rotation, Color tint);
//void DrawTexturePoly(Texture2D texture, Vector2 center, Vector2 *points, Vector2 *texcoords, int pointsCount, Color tint);

// Color/pixel related functions
//Color Fade(Color color, float alpha);
//int ColorToInt(Color color);
//Vector4 ColorNormalize(Color color);
//Color ColorFromNormalized(Vector4 normalized);
//Vector3 ColorToHSV(Color color);
//Color ColorFromHSV(float hue, float saturation, float value);
//Color ColorAlpha(Color color, float alpha);
//Color ColorAlphaBlend(Color dst, Color src, Color tint);
//Color GetColor(int hexValue);
//Color GetPixelColor(void *srcPtr, int format);
//void SetPixelColor(void *dstPtr, Color color, int format);
//int GetPixelDataSize(int width, int height, int format);

void appendTextures(mrb_state*);
