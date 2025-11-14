task "raylib:unmock" do
  File.delete("include/raylib.h") if File.exist?("include/raylib.h")
  File.delete("src/raylib.cpp") if File.exist?("src/raylib.cpp")
end

task "raylib:mock" do
  # Manually skip this step since I can't make rake do it
  if File.exist?("include/raylib.h") && File.exist?("src/raylib.cpp")
    mocked_time = [File.mtime("include/raylib.h"), File.mtime("src/raylib.cpp")].min
    original_time = [File.mtime("rakelib/generate_mock_raylib.rake"), File.mtime("vendor/raylib/include/raylib.h")].max

    next if original_time < mocked_time
  end

  header = ""
  source = ""

  mocks = {
    "BeginBlendMode" => {},
    "BeginDrawing" => {},
    "BeginMode2D" => {},
    "BeginScissorMode" => {},
    "BeginShaderMode" => {},
    "BeginTextureMode" => {},
    "ChangeDirectory" => {return: true},
    "CheckCollisionPointRec" => {return: true},
    "ClearBackground" => {},
    "ClearWindowState" => {},
    "CloseAudioDevice" => {},
    "CloseWindow" => {},
    "ColorContrast" => {return: true},
    "ColorBrightness" => {return: true},
    "ColorTint" => {return: true},
    "DisableCursor" => {},
    "DrawCircle" => {},
    "DrawCircleGradient" => {},
    "DrawCircleLines" => {},
    "DrawCircleSector" => {},
    "DrawCircleSectorLines" => {},
    "DrawCircleV" => {},
    "DrawEllipse" => {},
    "DrawEllipseLines" => {},
    "DrawFPS" => {},
    "DrawLine" => {},
    "DrawLineBezier" => {},
    "DrawLineBezierQuad" => {},
    "DrawLineEx" => {},
    "DrawLineV" => {},
    "DrawPixel" => {},
    "DrawPixelV" => {},
    "DrawPolyLinesEx" => {},
    "DrawRectangle" => {},
    "DrawRectangleGradientEx" => {},
    "DrawRectangleGradientH" => {},
    "DrawRectangleGradientV" => {},
    "DrawRectangleLines" => {},
    "DrawRectangleLinesEx" => {},
    "DrawRectanglePro" => {},
    "DrawRectangleRec" => {},
    "DrawRectangleRounded" => {},
    "DrawRectangleRoundedLines" => {},
    "DrawRectangleRoundedLinesEx" => {},
    "DrawRing" => {},
    "DrawRingLines" => {},
    "DrawTextEx" => {},
    "DrawTexture" => {},
    "DrawTexturePro" => {},
    "DrawTriangle" => {},
    "DrawTriangleLines" => {},
    "EnableCursor" => {},
    "EndBlendMode" => {},
    "EndDrawing" => {},
    "EndMode2D" => {},
    "EndScissorMode" => {},
    "EndShaderMode" => {},
    "EndTextureMode" => {},
    "ExportImage" => {return: true},
    "Fade" => {return: true},
    "FileExists" => {return: true},
    "GenImageColor" => {return: true},
    "GenTextureMipmaps" => {},
    "GetCharPressed" => {return: true},
    "*GetClipboardText" => {return: true},
    "GetCurrentMonitor" => {return: true},
    "*GetDirectoryPath" => {return: true},
    "GetFontDefault" => {return: true},
    "GetFPS" => {return: true},
    "GetFrameTime" => {return: true},
    "GetGamepadAxisCount" => {return: true},
    "GetGamepadAxisMovement" => {return: true},
    "GetGamepadButtonPressed" => {return: true},
    "*GetGamepadName" => {return: true},
    "GetGestureDetected" => {return: true},
    "GetGestureDragAngle" => {return: true},
    "GetGestureDragVector" => {return: true},
    "GetGestureHoldDuration" => {return: true},
    "GetGesturePinchAngle" => {return: true},
    "GetGesturePinchVector" => {return: true},
    "GetKeyPressed" => {return: true},
    "GetMasterVolume" => {return: true},
    "GetMonitorCount" => {return: true},
    "GetMonitorHeight" => {return: true},
    "*GetMonitorName" => {return: true},
    "GetMonitorPosition" => {return: true},
    "GetMonitorRefreshRate" => {return: true},
    "GetMonitorWidth" => {return: true},
    "GetMousePosition" => {return: true},
    "GetMouseWheelMoveV" => {return: true},
    "GetMusicTimeLength" => {return: true},
    "GetMusicTimePlayed" => {return: true},
    "GetScreenHeight" => {return: true},
    "GetScreenToWorld2D" => {return: true},
    "GetScreenWidth" => {return: true},
    "GetShaderLocation" => {return: true},
    "GetTime" => {return: true},
    "GetTouchPosition" => {return: true},
    "GetWindowPosition" => {return: true},
    "GetWindowScaleDPI" => {return: true},
    "*GetWorkingDirectory" => {return: true},
    "GetWorldToScreen2D" => {return: true},
    "HideCursor" => {},
    "ImageAlphaMask" => {},
    "ImageAlphaPremultiply" => {},
    "ImageColorBrightness" => {},
    "ImageColorContrast" => {},
    "ImageColorGrayscale" => {},
    "ImageColorInvert" => {},
    "ImageColorReplace" => {},
    "ImageColorTint" => {},
    "ImageCrop" => {},
    "ImageDraw" => {},
    "ImageFlipHorizontal" => {},
    "ImageFlipVertical" => {},
    "ImageFromImage" => {return: true},
    "ImageMipmaps" => {},
    "ImageResize" => {},
    "ImageResizeNN" => {},
    "ImageRotateCCW" => {},
    "ImageRotateCW" => {},
    "ImageTextEx" => {return: true},
    "InitAudioDevice" => {},
    "InitWindow" => {},
    "IsAudioDeviceReady" => {return: true},
    "IsCursorHidden" => {return: true},
    "IsCursorOnScreen" => {return: true},
    "IsFileDropped" => {return: true},
    "IsFontValid" => {return: true},
    "IsGamepadAvailable" => {return: true},
    "IsGamepadButtonDown" => {return: true},
    "IsGamepadButtonPressed" => {return: true},
    "IsGamepadButtonReleased" => {return: true},
    "IsGamepadButtonUp" => {return: true},
    "IsGestureDetected" => {return: true},
    "IsImageValid" => {return: true},
    "IsKeyDown" => {return: true},
    "IsKeyPressed" => {return: true},
    "IsKeyReleased" => {return: true},
    "IsKeyUp" => {return: true},
    "IsMouseButtonDown" => {return: true},
    "IsMouseButtonPressed" => {return: true},
    "IsMouseButtonReleased" => {return: true},
    "IsMouseButtonUp" => {return: true},
    "IsMusicStreamPlaying" => {return: true},
    "IsMusicValid" => {return: true},
    "IsRenderTextureValid" => {return: true},
    "IsShaderValid" => {return: true},
    "IsSoundPlaying" => {return: true},
    "IsSoundValid" => {return: true},
    "IsTextureValid" => {return: true},
    "IsWindowReady" => {return: true},
    "IsWindowResized" => {return: true},
    "IsWindowState" => {return: true},
    "LoadDroppedFiles" => {return: true},
    "LoadFontEx" => {return: true},
    "*LoadImageColors" => {return: true},
    "LoadImageFromScreen" => {return: true},
    "LoadImage" => {return: true},
    "LoadMusicStream" => {return: true},
    "LoadRenderTexture" => {return: true},
    "LoadShaderFromMemory" => {return: true},
    "LoadShader" => {return: true},
    "LoadSound" => {return: true},
    "LoadTextureFromImage" => {return: true},
    "LoadTexture" => {return: true},
    "MaximizeWindow" => {},
    "MeasureTextEx" => {return: true},
    "MinimizeWindow" => {},
    "OpenURL" => {},
    "PauseMusicStream" => {},
    "PauseSound" => {},
    "PlayMusicStream" => {},
    "PlaySound" => {},
    "RestoreWindow" => {},
    "ResumeMusicStream" => {},
    "ResumeSound" => {},
    "SetClipboardText" => {},
    "SetConfigFlags" => {},
    "SetExitKey" => {},
    "SetGamepadMappings" => {return: true},
    "SetGesturesEnabled" => {},
    "SetMasterVolume" => {},
    "SetMouseCursor" => {},
    "SetMouseOffset" => {},
    "SetMousePosition" => {},
    "SetMouseScale" => {},
    "SetMusicPitch" => {},
    "SetMusicVolume" => {},
    "SetShaderValueV" => {},
    "SetSoundPitch" => {},
    "SetSoundVolume" => {},
    "SetTargetFPS" => {},
    "SetTextureFilter" => {},
    "SetTraceLogLevel" => {},
    "SetWindowIcon" => {},
    "SetWindowMinSize" => {},
    "SetWindowMonitor" => {},
    "SetWindowOpacity" => {},
    "SetWindowPosition" => {},
    "SetWindowSize" => {},
    "SetWindowState" => {},
    "SetWindowTitle" => {},
    "ShowCursor" => {},
    "StopMusicStream" => {},
    "StopSound" => {},
    "TakeScreenshot" => {},
    "ToggleFullscreen" => {},
    "TraceLog" => {},
    "UnloadDroppedFiles" => {},
    "UnloadFont" => {},
    "UnloadImage" => {},
    "UnloadMusicStream" => {},
    "UnloadRenderTexture" => {},
    "UnloadShader" => {},
    "UnloadSound" => {},
    "UnloadTexture" => {},
    "UpdateMusicStream" => {},
    "WindowShouldClose" => {return: true}
  }

  def setup_source
    <<~SETUP
      #include <sstream>
      #include <string>

      #include "taylor/raylib.hpp"
      #include "raylib.h"
    SETUP
  end

  def parse_arguments(arguments)
    append = lambda { |var| "  signature << #{var}" }
    call_on = lambda { |object, method, pointer|
      str = append.call(%("#{method}: "))
      str += " << std::to_string("
      str += object
      str += pointer ? "->" : "."
      str += method
      str += ') << " " ;'

      str
    }

    source = []
    arguments.split(", ").each do |argument|
      next if argument == "void"
      next if argument == "..."

      type, name = argument.match(/(.*) (.*)/).captures
      pointer = name.start_with?("*")
      name = name[1..] if pointer

      case type
      when "const char"
        source << <<~CPP
          if (#{name}) {
            signature << " #{name}: '" << #{name} << "'";
          }
        CPP

      when "const void"
        source << append.call(%(" #{name}: ??? ";))

      when "Camera2D"
        source << append.call(%(" #{name}: { ";))
        source << call_on.call(name, "offset.x", pointer)
        source << call_on.call(name, "offset.y", pointer)
        source << call_on.call(name, "target.x", pointer)
        source << call_on.call(name, "target.y", pointer)
        source << call_on.call(name, "rotation", pointer)
        source << call_on.call(name, "zoom", pointer)
        source << append.call(%("}";))

      when "Color"
        source << append.call(%(" #{name}: { ";))
        source << call_on.call(name, "r", pointer)
        source << call_on.call(name, "g", pointer)
        source << call_on.call(name, "b", pointer)
        source << call_on.call(name, "a", pointer)
        source << append.call(%("}";))

      when "FilePathList"
        source << append.call(%(" #{name}: { ";))
        source << call_on.call(name, "capacity", pointer)
        source << call_on.call(name, "count", pointer)
        source << append.call(%("}";))

      when "Font"
        source << append.call(%(" #{name}: { ";))
        source << call_on.call(name, "baseSize", pointer)
        source << call_on.call(name, "glyphCount", pointer)
        source << call_on.call(name, "glyphPadding", pointer)
        source << append.call(%("}";))

      when "Image"
        source << append.call(%(" #{name}: { ";))
        source << call_on.call(name, "width", pointer)
        source << call_on.call(name, "height", pointer)
        source << call_on.call(name, "mipmaps", pointer)
        source << call_on.call(name, "format", pointer)
        source << append.call(%("}";))

      when "Music"
        source << append.call(%(" #{name}: { ";))
        source << call_on.call(name, "frameCount", pointer)
        source << call_on.call(name, "looping", pointer)
        source << call_on.call(name, "ctxType", pointer)
        source << append.call(%("}";))

      when "Rectangle"
        source << append.call(%(" #{name}: { ";))
        source << call_on.call(name, "x", pointer)
        source << call_on.call(name, "y", pointer)
        source << call_on.call(name, "width", pointer)
        source << call_on.call(name, "height", pointer)
        source << append.call(%("}";))

      when "RenderTexture2D"
        source << append.call(%(" #{name}: { ";))
        source << call_on.call(name, "id", pointer)
        source << call_on.call(name, "texture.width", pointer)
        source << call_on.call(name, "texture.height", pointer)
        source << call_on.call(name, "texture.mipmaps", pointer)
        source << call_on.call(name, "texture.format", pointer)
        source << call_on.call(name, "depth.width", pointer)
        source << call_on.call(name, "depth.height", pointer)
        source << call_on.call(name, "depth.mipmaps", pointer)
        source << call_on.call(name, "depth.format", pointer)
        source << append.call(%("}";))

      when "Sound"
        source << append.call(%(" #{name}: { ";))
        source << call_on.call(name, "frameCount", pointer)
        source << append.call(%("}";))

      when "Shader"
        source << append.call(%(" #{name}: { ";))
        source << call_on.call(name, "id", pointer)
        source << append.call(%("}";))

      when "Texture2D"
        source << append.call(%(" #{name}: { ";))
        source << call_on.call(name, "id", pointer)
        source << call_on.call(name, "width", pointer)
        source << call_on.call(name, "height", pointer)
        source << call_on.call(name, "mipmaps", pointer)
        source << call_on.call(name, "format", pointer)
        source << append.call(%("}";))

      when "Vector2"
        source << append.call(%(" #{name}: { ";))
        source << call_on.call(name, "x", pointer)
        source << call_on.call(name, "y", pointer)
        source << append.call(%("}";))

      when "int"
        # Clang and GCC format pointers differently, so let's just lean with
        # what clang prefers because I feel it makes more sense.
        source << if pointer
          append.call(<<~CPP)
            " #{name}: "
            #ifdef __EMSCRIPTEN__
              << "0x" << #{name}
            #elifdef __clang__
              << #{name}
            #else
              << "0x" << #{name}
            #endif
            ;
          CPP
        else
          append.call(%(" #{name}: " << #{name};))
        end

      else
        source << if pointer
          append.call(%(" #{name}: " << std::to_string(*#{name});))
        else
          append.call(%(" #{name}: " << std::to_string(#{name});))
        end
      end
    end

    source.join("\n")
  end

  File.read("vendor/raylib/include/raylib.h").lines do |line|
    if line == "#define RAYLIB_H\n"
      header << line
      source << setup_source
      next
    end

    unless line.start_with?("RLAPI ")
      header << line
      next
    end

    return_type, method_name, arguments = line.match(/RLAPI (.*) (.*)\((.*)\);/).captures

    if mocks[method_name]
      new_method = ""

      new_method << "  #{mocks[method_name][:before]}\n" if mocks[method_name][:before]

      new_method << <<~CPP
        #{return_type} #{method_name}(#{arguments}) {
          std::ostringstream signature;
          signature << "(#{method_name}) {";
        #{parse_arguments(arguments)}
          signature << " }";

          append_call(signature.str());
      CPP

      new_method << "  #{mocks[method_name][:body]}\n" if mocks[method_name][:body]
      if mocks[method_name][:return]
        new_method << if return_type == "const char"
          %(  return mocked_const_char_call_for("#{method_name}");\n)

        elsif method_name == "*LoadImageColors"
          <<~CPP
            auto* result = static_cast<Color*>(malloc(sizeof(Color)));
            mocked_call_for_LoadImageColors(result);
            return result;
          CPP

        else
          <<~CPP
            #{return_type} result;
            mocked_call_for("#{method_name}", &result);
            return result;
          CPP
        end
      end

      new_method << "}\n"

      source << new_method
      header << line
    end
  end

  File.write("include/raylib.h", header)
  File.write("src/raylib.cpp", source)
end
