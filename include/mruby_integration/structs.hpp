#pragma once

#include "mruby.h"

#include "mruby_integration/models/colour.hpp"
#include "mruby_integration/models/texture2d.hpp"

//struct Vector2;
//struct Vector3;
//struct Vector4;
//struct Quaternion;
//struct Matrix;

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

void appendStructs(mrb_state*);
