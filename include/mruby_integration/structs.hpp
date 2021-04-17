#pragma once

#include "mruby.h"

//struct Vector2;
//struct Vector3;
//struct Vector4;
//struct Quaternion;
//struct Matrix;

mrb_value MrbColourInitialize(mrb_state*, mrb_value self);
mrb_value MrbColourGetRed(mrb_state*, mrb_value self);
mrb_value MrbColourSetRed(mrb_state*, mrb_value self);
mrb_value MrbColourGetGreen(mrb_state*, mrb_value self);
mrb_value MrbColourSetGreen(mrb_state*, mrb_value self);
mrb_value MrbColourGetBlue(mrb_state*, mrb_value self);
mrb_value MrbColourSetBlue(mrb_state*, mrb_value self);
mrb_value MrbColourGetAlpha(mrb_state*, mrb_value self);
mrb_value MrbColourSetAlpha(mrb_state*, mrb_value self);

//struct Rectangle;

//struct Image;
//struct Texture;
//struct RenderTexture;
//struct NPatchInfo;
//struct CharInfo;
//struct Font;

//struct Camera;
//struct Camera2D;
//struct Mesh;
//struct Shader;
//struct MaterialMap;
//struct Material;
//struct Model;
//struct Transform;
//struct BoneInfo;
//struct ModelAnimation;
//struct Ray;
//struct RayHitInfo;
//struct BoundingBox;

//struct Wave;
//struct Sound;
//struct Music;
//struct AudioStream;

//struct VrDeviceInfo;
//struct VrStereoConfig;

extern RClass *colour_class;
extern RClass *texture_class;

void appendStructs(mrb_state*);
