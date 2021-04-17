#pragma once

#include "mruby.h"

// Window-related functions
mrb_value MrbInitWindow(mrb_state*, mrb_value);
mrb_value MrbWindowShouldClose(mrb_state*, mrb_value);
//void CloseWindow(void);
//bool IsWindowReady(void);
//bool IsWindowFullscreen(void);
//bool IsWindowHidden(void);
//bool IsWindowMinimized(void);
//bool IsWindowMaximized(void);
//bool IsWindowFocused(void);
//bool IsWindowResized(void);
//bool IsWindowState(unsigned int flag);
//void SetWindowState(unsigned int flags);
//void ClearWindowState(unsigned int flags);
//void ToggleFullscreen(void);
//void MaximizeWindow(void);
//void MinimizeWindow(void);
//void RestoreWindow(void);
//void SetWindowIcon(Image image);
//void SetWindowTitle(const char *title);
//void SetWindowPosition(int x, int y);
//void SetWindowMonitor(int monitor);
//void SetWindowMinSize(int width, int height);
//void SetWindowSize(int width, int height);
//void *GetWindowHandle(void);
//int GetScreenWidth(void);
//int GetScreenHeight(void);
//int GetMonitorCount(void);
//int GetCurrentMonitor(void);
//Vector2 GetMonitorPosition(int monitor);
//int GetMonitorWidth(int monitor);
//int GetMonitorHeight(int monitor);
//int GetMonitorPhysicalWidth(int monitor);
//int GetMonitorPhysicalHeight(int monitor);
//int GetMonitorRefreshRate(int monitor);
//Vector2 GetWindowPosition(void);
//Vector2 GetWindowScaleDPI(void);
//const char *GetMonitorName(int monitor);
//void SetClipboardText(const char *text);
//const char *GetClipboardText(void);

// Cursor-related functions
//void ShowCursor(void);
//void HideCursor(void);
//bool IsCursorHidden(void);
//void EnableCursor(void);
//void DisableCursor(void);
//bool IsCursorOnScreen(void);

// Drawing-related functions
mrb_value MrbClearBackground(mrb_state*, mrb_value);
mrb_value MrbBeginDrawing(mrb_state*, mrb_value);
mrb_value MrbEndDrawing(mrb_state*, mrb_value);
//void BeginMode2D(Camera2D camera);
//void EndMode2D(void);
//void BeginMode3D(Camera3D camera);
//void EndMode3D(void);
//void BeginTextureMode(RenderTexture2D target);
//void EndTextureMode(void);
//void BeginShaderMode(Shader shader);
//void EndShaderMode(void);
//void BeginBlendMode(int mode);
//void EndBlendMode(void);
//void BeginScissorMode(int x, int y, int width, int height);
//void EndScissorMode(void);
//void BeginVrStereoMode(VrStereoConfig config);
//void EndVrStereoMode(void);

// VR stereo config functions for VR simulator
//VrStereoConfig LoadVrStereoConfig(VrDeviceInfo device);
//void UnloadVrStereoConfig(VrStereoConfig config);

// Shader management functions
// NOTE: Shader functionality is not available on OpenGL 1.1
//Shader LoadShader(const char *vsFileName, const char *fsFileName);
//Shader LoadShaderFromMemory(const char *vsCode, const char *fsCode);
//int GetShaderLocation(Shader shader, const char *uniformName);
//int GetShaderLocationAttrib(Shader shader, const char *attribName);
//void SetShaderValue(Shader shader, int locIndex, const void *value, int uniformType);
//void SetShaderValueV(Shader shader, int locIndex, const void *value, int uniformType, int count);
//void SetShaderValueMatrix(Shader shader, int locIndex, Matrix mat);
//void SetShaderValueTexture(Shader shader, int locIndex, Texture2D texture);
//void UnloadShader(Shader shader);

// Screen-space-related functions
//Ray GetMouseRay(Vector2 mousePosition, Camera camera);
//Matrix GetCameraMatrix(Camera camera);
//Matrix GetCameraMatrix2D(Camera2D camera);
//Vector2 GetWorldToScreen(Vector3 position, Camera camera);
//Vector2 GetWorldToScreenEx(Vector3 position, Camera camera, int width, int height);
//Vector2 GetWorldToScreen2D(Vector2 position, Camera2D camera);
//Vector2 GetScreenToWorld2D(Vector2 position, Camera2D camera);

// Timing-related functions
mrb_value MrbSetTargetFPS(mrb_state*, mrb_value);
//int GetFPS(void);
mrb_value MrbGetFrameTime(mrb_state*, mrb_value);
//double GetTime(void);

// Misc. functions
//int GetRandomValue(int min, int max);
//void TakeScreenshot(const char *fileName);
//void SetConfigFlags(unsigned int flags);

//void TraceLog(int logLevel, const char *text, ...);
//void SetTraceLogLevel(int logLevel);
//void *MemAlloc(int size);
//void *MemRealloc(void *ptr, int size);
//void MemFree(void *ptr);

// Set custom callbacks
// WARNING: Callbacks setup is intended for advance users
//void SetTraceLogCallback(TraceLogCallback callback);
//void SetLoadFileDataCallback(LoadFileDataCallback callback);
//void SetSaveFileDataCallback(SaveFileDataCallback callback);
//void SetLoadFileTextCallback(LoadFileTextCallback callback);
//void SetSaveFileTextCallback(SaveFileTextCallback callback);

// Files management functions
//unsigned char *LoadFileData(const char *fileName, unsigned int *bytesRead);
//void UnloadFileData(unsigned char *data);
//bool SaveFileData(const char *fileName, void *data, unsigned int bytesToWrite);
//char *LoadFileText(const char *fileName);
//void UnloadFileText(unsigned char *text);
//bool SaveFileText(const char *fileName, char *text);
//bool FileExists(const char *fileName);
//bool DirectoryExists(const char *dirPath);
//bool IsFileExtension(const char *fileName, const char *ext);
//const char *GetFileExtension(const char *fileName);
//const char *GetFileName(const char *filePath);
//const char *GetFileNameWithoutExt(const char *filePath);
//const char *GetDirectoryPath(const char *filePath);
//const char *GetPrevDirectoryPath(const char *dirPath);
//const char *GetWorkingDirectory(void);
//char **GetDirectoryFiles(const char *dirPath, int *count);
//void ClearDirectoryFiles(void);
//bool ChangeDirectory(const char *dir);
//bool IsFileDropped(void);
//char **GetDroppedFiles(int *count);
//void ClearDroppedFiles(void);
//long GetFileModTime(const char *fileName);

//unsigned char *CompressData(unsigned char *data, int dataLength, int *compDataLength);
//unsigned char *DecompressData(unsigned char *compData, int compDataLength, int *dataLength);

// Persistent storage management
//bool SaveStorageValue(unsigned int position, int value);
//int LoadStorageValue(unsigned int position);

//void OpenURL(const char *url);

// Input-related functions: keyboard
//bool IsKeyPressed(int key);
//bool IsKeyDown(int key);
//bool IsKeyReleased(int key);
//bool IsKeyUp(int key);
//void SetExitKey(int key);
//int GetKeyPressed(void);
//int GetCharPressed(void);

// Input-related functions: gamepads
//bool IsGamepadAvailable(int gamepad);
//bool IsGamepadName(int gamepad, const char *name);
//const char *GetGamepadName(int gamepad);
//bool IsGamepadButtonPressed(int gamepad, int button);
//bool IsGamepadButtonDown(int gamepad, int button);
//bool IsGamepadButtonReleased(int gamepad, int button);
//bool IsGamepadButtonUp(int gamepad, int button);
//int GetGamepadButtonPressed(void);
//int GetGamepadAxisCount(int gamepad);
//float GetGamepadAxisMovement(int gamepad, int axis);
//int SetGamepadMappings(const char *mappings);

// Input-related functions: mouse
//bool IsMouseButtonPressed(int button);
//bool IsMouseButtonDown(int button);
//bool IsMouseButtonReleased(int button);
//bool IsMouseButtonUp(int button);
//int GetMouseX(void);
//int GetMouseY(void);
//Vector2 GetMousePosition(void);
//void SetMousePosition(int x, int y);
//void SetMouseOffset(int offsetX, int offsetY);
//void SetMouseScale(float scaleX, float scaleY);
//float GetMouseWheelMove(void);
//void SetMouseCursor(int cursor);

// Input-related functions: touch
//int GetTouchX(void);
//int GetTouchY(void);
//Vector2 GetTouchPosition(int index);

// Gestures and Touch Handling Functions (Module: gestures)
//void SetGesturesEnabled(unsigned int flags);
//bool IsGestureDetected(int gesture);
//int GetGestureDetected(void);
//int GetTouchPointsCount(void);
//float GetGestureHoldDuration(void);
//Vector2 GetGestureDragVector(void);
//float GetGestureDragAngle(void);
//Vector2 GetGesturePinchVector(void);
//float GetGesturePinchAngle(void);

// Camera System Functions (Module: camera)
//void SetCameraMode(Camera camera, int mode);
//void UpdateCamera(Camera *camera);

//void SetCameraPanControl(int keyPan);
//void SetCameraAltControl(int keyAlt);
//void SetCameraSmoothZoomControl(int keySmoothZoom);
//void SetCameraMoveControls(int frontKey, int backKey, 
//    int rightKey, int leftKey, 
//    int upKey, int downKey);

void appendCore(mrb_state*);
