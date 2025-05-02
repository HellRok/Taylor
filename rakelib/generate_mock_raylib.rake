task "include/raylib.h" => "raylib:mock"
task "src/raylib.cpp" => "raylib:mock"

task "raylib:unmock" do
  File.delete("include/raylib.h") if File.exist?("include/raylib.h")
  File.delete("src/raylib.cpp") if File.exist?("src/raylib.cpp")
end

task "raylib:mock" do
  header = ""
  source = ""

  mocks = {
    "BeginBlendMode" => {},
    "BeginDrawing" => {},
    "BeginMode2D" => {},
    "BeginScissorMode" => {},
    "BeginShaderMode" => {},
    "BeginTextureMode" => {},
    "ChangeDirectory" => {return: "true"},
    "CheckCollisionPointRec" => {return: "true"},
    "ClearBackground" => {},
    "ClearWindowState" => {},
    "CloseAudioDevice" => {},
    "CloseWindow" => {},
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
    "DrawLineStrip" => {},
    "DrawLineV" => {},
    "DrawPixel" => {},
    "DrawPixelV" => {},
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
    "ExportImage" => {return: "true"},
    "Fade" => {return: "PURPLE"},
    "FileExists" => {return: "true"},
    "GenImageColor" => {return: "Image{}"},
    "GenTextureMipmaps" => {},
    "GetCharPressed" => {return: "57"},
    "*GetClipboardText" => {return: '"clipboard text"'},
    "GetCurrentMonitor" => {return: "0"},
    "*GetDirectoryPath" => {return: '"/path"'},
    "GetFontDefault" => {return: "Font{}"},
    "GetFPS" => {return: "60"},
    "GetFrameTime" => {return: "0.016"},
    "GetGamepadAxisCount" => {return: "2"},
    "GetGamepadAxisMovement" => {return: "0.1"},
    "GetGamepadButtonPressed" => {return: "1"},
    "*GetGamepadName" => {return: '"controller"'},
    "GetGestureDetected" => {return: "1"},
    "GetKeyPressed" => {return: "true"},
    "GetMonitorCount" => {return: "1"},
    "GetMonitorHeight" => {return: "800"},
    "GetMonitorPosition" => {return: "Vector2{}"},
    "GetMonitorRefreshRate" => {return: "60"},
    "GetMonitorWidth" => {return: "480"},
    "GetMousePosition" => {return: "Vector2{}"},
    "GetMouseWheelMoveV" => {return: "Vector2{}"},
    "GetMusicTimeLength" => {return: "0.1"},
    "GetMusicTimePlayed" => {return: "0.1"},
    "GetScreenHeight" => {return: "1080"},
    "GetScreenToWorld2D" => {return: "Vector2{}"},
    "GetScreenWidth" => {return: "1920"},
    "GetShaderLocation" => {return: "1"},
    "GetTime" => {return: "0.1"},
    "GetTouchPosition" => {return: "Vector2{}"},
    "GetWindowPosition" => {return: "Vector2{}"},
    "GetWindowScaleDPI" => {return: "Vector2{}"},
    "*GetWorkingDirectory" => {return: '"/working/directory"'},
    "GetWorldToScreen2D" => {return: "Vector2{}"},
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
    "ImageFromImage" => {return: "Image{}"},
    "ImageMipmaps" => {},
    "ImageResize" => {},
    "ImageResizeNN" => {},
    "ImageRotateCCW" => {},
    "ImageRotateCW" => {},
    "ImageTextEx" => {return: "Image{}"},
    "InitAudioDevice" => {},
    "InitWindow" => {},
    "IsAudioDeviceReady" => {return: "true"},
    "IsCursorHidden" => {return: "true"},
    "IsCursorOnScreen" => {return: "true"},
    "IsFileDropped" => {return: "true"},
    "IsFontReady" => {return: "true"},
    "IsGamepadAvailable" => {return: "true"},
    "IsGamepadButtonDown" => {return: "true"},
    "IsGamepadButtonPressed" => {return: "true"},
    "IsGamepadButtonReleased" => {return: "true"},
    "IsGamepadButtonUp" => {return: "true"},
    "IsKeyDown" => {return: "true"},
    "IsKeyPressed" => {return: "true"},
    "IsKeyReleased" => {return: "true"},
    "IsKeyUp" => {return: "true"},
    "IsMouseButtonDown" => {return: "true"},
    "IsMouseButtonPressed" => {return: "true"},
    "IsMouseButtonReleased" => {return: "true"},
    "IsMouseButtonUp" => {return: "true"},
    "IsMusicStreamPlaying" => {return: "true"},
    "IsShaderReady" => {return: "true"},
    "IsSoundPlaying" => {return: "true"},
    "IsWindowReady" => {return: "true"},
    "IsWindowResized" => {return: "true"},
    "IsWindowState" => {return: "true"},
    "LoadDroppedFiles" => {return: "FilePathList{}"},
    "LoadFontEx" => {return: "Font{}"},
    "*LoadImageColors" => {return: "colors", before: "Color colors[] = { PURPLE };"},
    "LoadImageFromScreen" => {return: "Image{}"},
    "LoadImage" => {return: "Image{}"},
    "LoadMusicStream" => {return: "Music{}"},
    "LoadRenderTexture" => {return: "RenderTexture2D()"},
    "LoadShaderFromMemory" => {return: "Shader{}"},
    "LoadShader" => {return: "Shader{}"},
    "LoadSound" => {return: "Sound{}"},
    "LoadTextureFromImage" => {return: "Texture2D{}"},
    "LoadTexture" => {return: "Texture2D{}"},
    "MaximizeWindow" => {},
    "MeasureTextEx" => {return: "Vector2{ 10, 10 }"},
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
    "SetGamepadMappings" => {return: "1"},
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
    "SetWindowPosition" => {},
    "SetWindowSize" => {},
    "SetWindowState" => {},
    "SetWindowTitle" => {},
    "ShowCursor" => {},
    "StopMusicStream" => {},
    "StopSound" => {},
    "TakeScreenshot" => {},
    "ToggleFullscreen" => {},
    "UnloadDroppedFiles" => {},
    "UnloadFont" => {},
    "UnloadImage" => {},
    "UnloadMusicStream" => {},
    "UnloadRenderTexture" => {},
    "UnloadShader" => {},
    "UnloadSound" => {},
    "UnloadTexture" => {},
    "UpdateMusicStream" => {},
    "WindowShouldClose" => {return: "true"}
  }

  def setup_source
    <<~SETUP
      #include <sstream>
      #include <string>

      #include "taylor.hpp"
      #include "raylib.h"
    SETUP
  end

  def parse_arguments(arguments)
    append = lambda { "  signature << #{it}" }
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
        source << append.call(%(" #{name}: '" << #{name} << "' ";))

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

      else
        source << if pointer
          append.call(%(" #{name}: " << std::to_string(*#{name}) << " ";))
        else
          append.call(%(" #{name}: " << std::to_string(#{name}) << " ";))
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

    return_value, method_name, arguments = line.match(/RLAPI (.*) (.*)\((.*)\);/).captures

    if mocks[method_name]
      new_method = ""

      new_method << "  #{mocks[method_name][:before]}\n" if mocks[method_name][:before]

      new_method << <<~CPP
        #{return_value} #{method_name}(#{arguments}) {
          std::ostringstream signature;
          signature << "(#{method_name}) {";
        #{parse_arguments(arguments)}
          signature << " }";

          AppendCall(signature.str());
      CPP

      new_method << "  #{mocks[method_name][:body]}\n" if mocks[method_name][:body]
      new_method << "  return #{mocks[method_name][:return]};\n" if mocks[method_name][:return]
      new_method << "  #{mocks[method_name][:manual_return]}\n" if mocks[method_name][:manual_return]

      new_method << "}\n"

      source << new_method
      header << line
    end
  end

  File.write("include/raylib.h", header)
  File.write("src/raylib.cpp", source)
end
