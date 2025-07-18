# Taylor

## Unreleased

- Build the docker images one at a time to not thrash the disk
- Setup standardrb for formatting
- Setup clang-tidy and clang-format
- Add a .git-blame-ignore-revs
- the `check_for_documentation` script now supports the new formatting
- Run clang-tidy and clang-format on Buildkite
- Squashing is now a taylor responsibility
- Refactor the `taylor export` command and test
- Fix the OSX docker image build
- Fix incorrect documentation for `Font#measure`
- Fix a typo in the README.md
- Remove SimpleHTTPServer
- Slight refactor of build pipeline
- Group mruby gems in a gembox
- Font#new now uses kwargs and is C++ backed
- Font#unload is now C++ backed
- Add Font#ready?
- Font#draw is now C++ backed
- Removed draw_text and draw_text_ex
- Font#measure is now C++ backed
- Removed measure_text_ex
- Add Font.default
- Font#to_image is now C++ backed
- Removed image_text_ex
- Added Vector2[]
- Added Vector2#/
- Camera2D#initialize now takes keyword arguments
- Removed begin_mode2D and end_mode2D
- Renamed Camera2D#drawing to Camera2D#draw
- Camera2D#draw is now C++ backed
- Removed get_world_to_screen2D
- Camera2D#as_in_viewport is now C++ backed
- Removed get_screen_to_world2D
- Camera2D#as_in_world is now C++ backed
- Added Vector2#inspect for better debugging
- Colour.new now takes keyword arguments
- Added Colour[]
- Image.new is now C++ backed and takes a path
- Removed load_image
- Font.new now raises when the file cannot be found
- Image.unload is now C++ backed
- Removed unload_image
- Image#export is now C++ backed
- Removed export_image
- Image#copy is now C++ backed
- Removed image_copy and image_from_image
- Removed image_text_ex
- Image.generate is now C++ backed
- Removed generate_image_colour
- Image#resize! is now C++ backed
- Removed image_resize! and image_resize_nearest_neighbour!
- Image#crop! is now C++ backed
- removed image_crop!
- Added Rectangle[]
- Renamed Image#alpha_mask= to Image#alpha_mask!
- Removed image_mask_alpha!
- Renamed Image#flip_vertical! to Image#flip_vertically!
- Renamed Image#flip_horizontal! to Image#flip_horizontally!
- Removed image_flip_vertical! and image_flip_horizontal!
- Removed Image#rotate!
- Added Image#rotate_clockwise! and Image#rotate_counter_clockwise!
- Removed image_rotate_cw! and image_rotate_ccw!
- Image#to_texture is now C++ backed
- Removed load_texture_from_image
- Image#premultiply_alpha is now C++ backed
- Removed image_alpha_premultiply
- Image#generate_mipmaps! is now C++ backed
- Removed image_mipmaps!
- Image#tint! is now C++ backed
- Removed image_colour_tint!
- Image#invert! is now C++ backed
- Removed image_colour_invert!
- Image#grayscale! was renamed to Image#greyscale! and is now C++ backed
- Removed image_colour_grayscale!
- Image#contrast! is now C++ backed
- Removed image_colour_contrast!
- Image#brightness! is now C++ backed
- Removed image_colour_brightness!
- Image#replace! is now C++ backed and takes kwargs
- Removed image_colour_replace!
- Image#draw! is now C++ backed
- Removed image_draw!
- Added Audio.open, Audio.close, Audio.ready?, and Audio.volume=
- Removed init_audio_device, close_audio_device, audio_device_ready?, and set_master_volume
- Music#initialize and Music#unload are now C++ backed
- Remove load_music_stream, unload_music_stream, Music#context_type=, and Music#frame_count=
- Music#play, Music#playing?, Music#stop are now C++ backed
- Removed play_music_stream, music_playing?, stop_music_stream
- Music#played is now C++ backed
- Removed get_music_time_played
- Music#update is now C++ backed
- Removed update_music_stream
- Music#pause and Music#resume are now C++ backed
- Removed pause_music_stream and resume_music_stream
- Added cancel_main_loop
- Music#length is now C++ backed
- Removed get_music_time_length
- Music#volume= is now C++ backed
- Removed set_music_volume
- Music#pitch= is now C++ backed
- Removed set_music_pitch
- Sound#initialize is now C++ backed
- Removed Sound#frame_count=
- Removed load_sound
- Sound#unload is now C++ backed
- Removed unload_sound
- Sound#play is now C++ backed
- Removed play_sound
- Sound#stop is now C++ backed
- Removed stop_sound
- Sound#pause is now C++ backed
- Removed pause_sound
- Sound#resume is now C++ backed
- Removed resume_sound
- Sound#playing? is now C++ backed
- Removed sound_playing?
- Sound#volume= is now C++ backed
- Removed set_sound_volume
- Sound#pitch= is now C++ backed
- Removed set_sound_pitch
- Add Cursor.hide, Cursor.show, and Cursor.hidden?
- Removed show_cursor, hide_cursor, and cursor_hidden?
- Add Cursor.disable, Cursor.enable, and Cursor.disabled?
- Removed enable_cursor and disable_cursor
- Cursor.on_screen? is now C++ backed
- Removed cursor_on_screen?
- Add Mouse.pressed?
- Removed mouse_button_pressed?
- Add Mouse.down?
- Removed mouse_button_down?
- Add Mouse.released?
- Removed mouse_button_released?
- Add Mouse.up?
- Removed mouse_button_up?
- Add Mouse.position
- Removed mouse_get_x, mouse_get_y, get_mouse_position
- Add Mouse.position=
- Removed set_mouse_position
- Add Mouse.offset=
- Removed set_mouse_offset
- Add Mouse.scale=
- Removed set_mouse_scale
- Add Mouse.wheel_moved
- Removed get_mouse_wheel_move
- Add Cursor.icon, Cursor.icon=, and Cursor icon constants
- Removed set_mouse_cursor
- Add blend_mode
- Add Key.pressed?
- Removed key_pressed?
- Add Key.down?
- Removed key_down?
- Add Key.released?
- Removed key_released?
- Add Key.up?
- Removed key_up?
- Add Key.pressed
- Removed get_key_pressed
- Add Key.pressed_character
- Removed get_char_pressed
- Added Window.open
- Removed init_window
- Added Window.width
- Removed get_screen_width
- Added Window.height
- Removed get_screen_height
- Added Window.close?
- Removed window_should_close?
- Added Window.close
- Removed window_close
- Added Window.ready?
- Removed window_ready
- Added Window.flag?
- Removed window_state?
- Added Window.flags=
- Removed set_window_state
- Added Window.fullscreen?
- Removed window_fullscreen?
- Added Window.minimised?
- Removed window_minimised?
- Added Window.maximised?
- Removed window_maximised?
- Added Window.focused?
- Removed window_focused?
- Added Window.hidden?
- Removed window_hidden?
- Added Window.always_on_top?
- Added Window.always_run?
- Added Window.transparent?
- Added Window.high_dpi?
- Added Window.vsync_hinted?
- Added Window.msaa_4x_hinted?
- Added Window.interlaced_hinted?
- Added Window.clear_flag
- Removed clear_window_state
- Added Window.config=
- Added Window.exit_key=
- Removed set_exit_key
- Added Window.resized?
- Removed window_resized?
- Added Window.toggle_fullscreen
- Removed toggle_fullscreen
- Added Window.maximise
- Removed maximise_window
- Added Window.minimise
- Removed minimise_window
- Added Window.restore
- Removed restore_window
- Added Window.icon=
- Removed set_window_icon
- Added Window.title=
- Removed set_window_title
- Added Window.position=
- Removed set_window_position
- Added Window.minimum_size
- Added Window.minimum_size=
- Removed set_window_min_size
- Added Window.size
- Added Window.size=
- Removed set_window_size
- Added Window.position
- Removed get_window_position
- Added Window.opacity
- Added Window.opacity=
- Use "resolution" instead of "size"
- Added Window.to_image
- Removed get_screen_data
- Added Taylor::Platform.android?
- Removed android?
- Added Taylor::Platform.browser?
- Removed browser?
- Added Taylor::Platform.linux?
- Removed linux?
- Added Taylor::Platform.osx?
- Removed osx?
- Added Taylor::Platform.windows?
- Removed windows?
- Added Taylor.released?
- Removed released?
- Added Taylor::Platform.os
- Added Taylor::Platform.arch
- Added Taylor::Platform.to_s
- Added Taylor::Platform==
- Added Touch.position_for, Touch[], and Touch.positions
- Removed get_touch_position
- Texture2D.new now only takes a path
- Removed Texture2D.load
- Removed Texture2D#id=
- Removed Texture2D#width=
- Removed Texture2D#height=
- Removed Texture2D#mipmaps=
- Removed Texture2D#format=
- Texture2D#unload is now C++ backed
- Removed unload_texture
- Texture2D#filter= is now C++ backed
- Removed set_texture_filter
- Texture2D#generate_texture_mipmaps is now C++ backed
- Removed generate_texture_mipmaps
- Reworked some rake tasks into shell scripts
- Added Colour#fade, Colour#fade!, and Colour#inspect
- Removed fade
- Bump Ruby and gems
- Texture2D#draw is now C++ backed
- Removed draw_texture and draw_texture_pro
- Added Monitor.count
- Removed get_monitor_count
- Added Monitor.new, Monitor[], and Monitor.all
- Added Monitor.current
- Removed get_current_monitor
- Added Monitor#position
- Removed get_monitor_position
- Added Monitor#width, Monitor#height, and Monitor#resolution
- Removed get_monitor_width
- Removed get_monitor_height
- Added Monitor#refresh_rate
- Removed get_monitor_refresh_rate
- Added Monitor#name
- Added Circle#initialize
- Cleaned up some missing documentation
- Added Circle#to_h
- Added Circle#draw
- Removed draw_circle
- Removed draw_circle_v
- Removed draw_circle_sector
- Removed draw_circle_sector_lines
- Removed draw_circle_gradient
- Removed draw_circle_lines
- Added Circle.[]
- Added Line#initialize
- Added Line#draw
- Removed draw_line
- Removed draw_line_v
- Removed draw_line_ex
- Removed draw_line_bezier
- Removed draw_line_bezier_quad
- Removed draw_line_strip
- Added Vector2#draw
- Removed draw_pixel
- Removed draw_pixel_v
- Refactored Rectangle#initialize
- Refactored Rectangle#draw
- Removed mrb_draw_rectangle
- Removed mrb_draw_rectangle_rec
- Removed mrb_draw_rectangle_pro
- Removed mrb_draw_rectangle_gradient_v
- Removed mrb_draw_rectangle_gradient_h
- Removed mrb_draw_rectangle_gradient_ex
- Removed mrb_draw_rectangle_lines
- Removed mrb_draw_rectangle_lines_ex
- Removed mrb_draw_rectangle_rounded
- Removed mrb_draw_rectangle_rounded_lines
- Removed check_collision_point_rec
- Added Window.monitor
- Added Window.monitor=
- Removed set_window_monitor
- Added Window.scale
- Removed get_window_scale_dpi
- Added Gamepad#available?
- Removed gamepad_available?
- Added Gamepad.[]
- Added Gamepad#name
- Removed get_gamepad_name
- Added Gamepad#pressed?
- Removed gamepad_button_pressed?
- Added Gamepad#down?
- Removed gamepad_button_down?
- Added Gamepad#released?
- Removed gamepad_button_released?
- Added Gamepad#up?
- Removed gamepad_button_up?
- Removed get_gamepad_button_pressed
- Added Gamepad#axis_count
- Removed get_gamepad_axis_count
- Added Gamepad#axis
- Removed get_gamepad_axis_movement
- Simplify the memory management
- Remove a memory leak
- Add tests for reference counting
- Added Gamepad.add_mappings
- Removed set_gamepad_mappings
- Added Gesture.enable=
- Removed set_gestures_enabled
- chown the build artefacts on export
- Added Gesture.detected
- Removed get_gesture_detected
- Added Gesture.detected?
- Added Gesture.duration
- Added Gesture.dragged
- Added Gesture.drag_angle
- Added Gesture.pinched
- Added Gesture.pinch_angle
- Added DroppedFiles.any?
- Removed dropped_files?
- Added DroppedFiles.all
- Removed get_dropped_files
- Refactor Shader#initialize
- Removed load_shader
- Refactor Shader#unload
- Removed unload_shader
- Refactor Shader#ready?
- Removed shader_ready?

## v0.3.14.1

- Bug fix for Shader.load

## v0.3.14

- Upgrade to Raylib 4.5
- Add shader_ready? and Shader#ready?
- Fix up the examples link in the readme to point to the playground
- Add in the missed documentation
- Fix Buildkite analytics upload
- Fix ARM64 OSX builds
- Add get_shader_location
- Add Shader#get_uniform_location
- Add set_shader_values
- Add Shader#set_value
- Add Shader#set_values
- Reserve the Taylor gem name
- Add load_shaders_from_string

## v0.3.13

- Buildkite now builds the docker images
- Buildkite now runs tests on Linux, under wine, and in the chrome
- Upgrade mruby to 3.2.0 now that it's released
- Platform specific methods now raise a unique error on unsupported platforms
- Add tests for the platform specific methods
- Upload analytics for the web build too
- Add set_texture_filter
- Add generate_texture_mipmaps
- Add Font.filter=
- Add Texture2D#filter=
- Add Texture2D#generate_mipmaps
- Add released?

## v0.3.12.2

- CLI Tool now has the correct export targets
- Add android?
- Add GLSL_VERSION
- Tests now all pass on web again
- CLI Tool tests now fail correctly
- Build all the docker images in Buildkite
- Add documentation for `taylor_config.json`

## v0.3.12.1

- Web exports no longer run at 20% speed or use 8GB of RAM

## v0.3.12

- Add a loading screen for web exports
- Refactor Rakefile
- Can now compile for OSX Apple hardware
- Use exit! for tests
- Update CLI-tool to use the new apple exports
- Update CLI-tool to use exit! for failed command
- Add a roadmap

## v0.3.11

- Add Shader
- Add load_shader
- Add unload_shader
- Add begin_shader_mode
- Add end_shader_mode
- Add Shader#draw
- Running taylor with a bad path now exits 1 instead of raising

## v0.3.10

- Add mruby-base64
- Remove workaround for simplehttp on Windows
- Tweak buildkite test scripts for better reliability
- Fix Camera2D test on Buildkite
- Add RenderTexture
- Add begin_texture_mode, end_texture_mode, and RenderTexture#drawing
- Add RenderTexture#unload
- Add RenderTexture#texture
- Add specs for RenderTexture
- Bump raylib to 4.2.0
- Rake now builds in parallel

## v0.3.9

- Bump mruby and recompile raylib
- Force Locale to be en_US.UTF-8 inside docker export images
- Add mruby-uri-parser

## v0.3.8

- Fix documentation typo
- Allow memory growth on the web builds
- Add LocalStorage#set_item
- Add LocalStorage#get_item
- Errors now display in the javascript console

## v0.3.7

- Switch to Buildkite and add test analytics
- Switch Taylor CLI to BuildKite and add test analytics
- Fix up the README
- Use flock to prevent running multiple xvfb/fluxbox

## v0.3.6

- Add image_draw!
- Add Image#draw!

## v0.3.5

- mRuby now builds from master instead of 3.0.0
- Add mruby-sleep as a library
- cli-new help now displays the correct command name
- Bump Emscripten and clean up it's build process
- Add get_attribute_from_element

## v0.3.4

- Add Gitpod support
- Add more tests for cli-export
- Use slim docker images to save a few megabytes
- Building the export docker images now includes the version for easy use
- cli-export run now properly handles being passed a path
- Test suite is now a proper Taylor application
- Test suite now mostly runs on Windows

## v0.3.3

- Add regex support
- Add image_colour_tint!
- Add Image#tint!
- Add image_colour_invert!
- Add Image#invert!
- Add image_colour_grayscale!
- Add Image#grayscale!
- Add image_colour_contrast!
- Add Image#contrast!
- Add image_colour_brightness!
- Add Image#brightness!
- Add image_colour_replace!
- Add Image#replace!

## v0.3.2

- Add SimpleHttp
- Add SimpleHttpServer

## v0.3.1

- Add generate_image_colour
- Add Image.generate
- Add export_image
- Add Image#export
- Add image_copy
- Add Image#copy
- Add image_from_image
- Image#copy now can take a `source` argument
- Add image_text_ex
- Add Font#to_image
- Restructured tests to run in a single window instead of spawning one window per test
- Add load_texture_from_image
- Add Image#to_texture
- Add image_resize!
- Add image_resize_nearest_neighbour!
- Add Image#resize!
- Add image_crop!
- Add Image#crop!
- Taylor-cli new now adds `.keep` files
- Add image_alpha_mask!
- Add Image#alpha_mask=
- Upgrade Raylib to 4.0.0
- Add image_alpha_premultiply!
- Add Image#premultiply_alpha!
- Add image_mipmaps!
- Add Image#generate_mipmaps!
- Add image_flip_vertical!
- Add image_flip_horizontal!
- Add Image#flip_vertical!
- Add Image#flip_horizontal!
- Add image_rotate_cw!
- Add image_rotate_ccw!
- Add Image#rotate!
- Re-wrote the docker images since applant/mruby-cli doesn't work
- Exports now use independent docker images for each target

## v0.3.0

- Add unload_font
- Add tests for draw_texture
- Add Font.load
- Add Font#unload
- Add Font#draw
- Add Font#measure
- Add Vector2::ZERO
- Add Texture2D.load
- Add Texture2D#unload
- Add Texture2D#draw
- add unload_image
- Add Image.load
- Add Image#unload
- Add Music.load
- Add Music#unload
- Add Music#play
- Add Music#update
- Add Music#playing?
- Add Music#stop
- Add Music#pause
- Add Music#resume
- Add Music#length
- Add Music#played
- Add Music#volume=
- Add Music#pitch=
- Rebranded the music type constants
- Add Rectangle#draw
- Add Sound.load
- Add Sound#unload
- Add Sound#play
- Add Sound#playing?
- Add Sound#stop
- Add Sound#pause
- Add Sound#resume
- Add Sound#volume=
- Add Sound#pitch=
- Add Sound.stop
- Add Sound.playing
- is_sound_playing? now references the correct function
- Add clear
- Add drawing
- Add scissor_mode
- Add Camera2D#drawing
- Add Camera2D#as_in_viewport
- Add Camera2D#as_in_world
- Drop all is_ predicates since that's not very "ruby"

## v0.2.6

- Add linux?
- Add windows?
- Add osx?
- Add browser?
- Set default game template to work with improved emscripten performance gains
- Allow setting the folder for Taylor-cli new command easily

## v0.2.5

- Add set_main_loop
- Add link to examples in the README
- Add compilation instructions to the README
- Add a link to Getting Started to the README

## v0.2.4

- Fix exports for OSX builds

## v0.2.3

- Init audio in the initial template

## v0.2.2

- Use -O3 on all builds
- Taylor CLI OSX now exports as a cli app, not as a gui application
- Added load_font_ex

## v0.2.1

- Web exports now use index.html so they can be uploaded straight to itch.io

## v0.2.0

- Can now export to web
- Can now specify target exports

## v0.1.7

- Do not prime the build cache

## v0.1.6

- ARGV needs to be zero indexed for export

## v0.1.5

- Taylor-cli help commands now format nicely
- Taylor-cli can just return the version number
- Add measure_text_ex method
- export_directory now actually specifies the export from the docker build, not
  where it builds inside Docker
- Can now specify a build cache for exports to save on compile time
- Export Dockerfile now builds Taylor to prime the build cache

## v0.1.4

- Add mruby-exit gem
- Tests now return an exit code of 1 when they fail or error
- Export now copies "copy_paths"
- Export for OSX now creates an app
- Cleanup the readme a little
- Rectangles use floats, so use the right method for setting the ivar

## v0.1.3

- Version the release assets
- Add the Font model
- Add load_font method
- Add draw_text_ex method
- Tests now all have the correct title for their window
- Tests now run through taylor-cli
- Some more tests can now run on CI

## v0.1.2

- Setup STDERR, STDOUT, STDIN for Windows applications

## v0.1.1

- Taylor-cli commands now handle arguments individually
- Taylor-cli now has tests

## v0.1.0

- Setup for export builds
- Populate ARGV for programs
- Add get_monitor_refresh_rate
- Do a test build on push/pull request
- Add the ability to export builds
- Create a CLI tool that will be the main user interface to Taylor
- Build for cli-tool instead of standard taylor

## v0.0.6

- Add draw_triangle_lines
- Add draw_texture_pro
- Make tests a little more lenient with screenshot comparisons
- The entire build process now works in docker, no more OSX machine required

## v0.0.5

- Add draw_circle_sector
- Add draw_circle_sector_lines
- Add draw_circle_gradient
- Add draw_circle_lines
- Add draw_ellipse
- Add draw_ellipse_lines
- Add draw_ring
- Add draw_ring_lines
- Add draw_rectangle_pro
- Add JSON parsing and generating via mruby-iijson
- Add draw_rectangle_gradient_v
- Add draw_rectangle_gradient_h
- Add draw_rectangle_gradient_ex
- Add draw_rectangle_rounded
- Add draw_rectangle_rounded_lines

## v0.0.4

- Add take_screenshot
- Set the current working directory to the location of the script called instead
  of the taylor binary
- Add files_dropped?
- Backtraces are actually working now
- Add get_dropped_files
- Add is_key_released?
- Add is_key_up?
- Add set_exit_key
- Add get_key_pressed
- Add get_char_pressed
- Add is_gamepad_button_pressed?
- Add is_gamepad_button_released?
- Add is_gamepad_button_up?
- Add set_gamepad_mappings
- Add set_mouse_position
- Add set_mouse_offset
- Add set_mouse_scale
- Add set_mouse_cursor
- Add load_image
- Compile raylib with jpg support
- Refactor windows build to not need raylib.dll
- Add draw_pixel
- Add draw_pixel_v
- Add draw_line_v
- Add draw_line_ex
- Add draw_line_bezier
- Add draw_line_bezier_quad
- Add draw_line_strip

## v0.0.3

- Add set_window_icon
- Add set_window_title
- Add set_window_position
- Add get_window_position
- Add set_window_monitor
- Add set_window_min_size
- Add set_window_size
- Add get_monitor_position
- Add get_window_scale_dpi
- Add set_clipboard_text
- Add get_clipboard_text
- Add show_cursor
- Add hide_cursor
- Add is_cursor_hidden?
- Add enable_cursor
- Add disable_cursor
- Add is_cursor_on_screen?
- Add get_mouse_x
- Add get_mouse_y
- Add begin_scissor_mode
- Add end_scissor_mode
- Add get_time
- Improve the release body

## v0.0.2

- Re-word the readme to say game engine
- Dockerfile now makes sure the release directory can be created
- draw_rectangle_lines_ex had incorrect parameters in the documentation
- Use mrb_print_error since it seems to do a better job
- Add mrb-dir so users can easily change working directories

## v0.0.1

- Added begin_drawing
- Added begin_mode2D
- Added Camera2D#initialize
- Added Camera2D#offset=
- Added Camera2D#rotation=
- Added Camera2D#target=
- Added Camera2D#to_h
- Added Camera2D#zoom=
- Added check_collision_point_rec
- Added clear_background
- Added clear_window_state
- Added close_audio_device
- Added close_window
- Added Colour#==
- Added Colour#alpha=
- Added Colour#blue=
- Added Colour#green=
- Added Colour#initialize
- Added Colour#red=
- Added Colour#to_h
- Added draw_circle
- Added draw_circle_v
- Added draw_fps
- Added draw_line
- Added draw_rectangle
- Added draw_rectangle_lines
- Added draw_rectangle_lines_ex
- Added draw_rectangle_rec
- Added draw_text
- Added draw_texture
- Added draw_triangle
- Added end_drawing
- Added end_mode2D
- Added fade
- Added get_current_monitor
- Added get_fps
- Added get_frame_time
- Added get_gamepad_axis_count
- Added get_gamepad_axis_movement
- Added get_gamepad_button_pressed
- Added get_gamepad_name
- Added get_gesture_detected
- Added get_monitor_count
- Added get_monitor_height
- Added get_monitor_width
- Added get_mouse_position
- Added get_mouse_wheel_move
- Added get_music_time_length
- Added get_music_time_played
- Added get_screen_data
- Added get_screen_height
- Added get_screen_to_world2D
- Added get_screen_width
- Added get_sounds_playing
- Added get_touch_position
- Added get_world_to_screen2D
- Added Image#data
- Added Image#format=
- Added Image#height=
- Added Image#initialize
- Added Image#mipmaps=
- Added Image#to_h
- Added Image#width=
- Added init_audio_device
- Added init_window
- Added is_audio_device_ready?
- Added is_gamepad_available?
- Added is_gamepad_button_down?
- Added is_key_down?
- Added is_key_pressed?
- Added is_mouse_button_down?
- Added is_mouse_button_pressed?
- Added is_music_playing?
- Added is_sound_playing?
- Added is_window_focused?
- Added is_window_fullscreen?
- Added is_window_hidden?
- Added is_window_maximised?
- Added is_window_minimised?
- Added is_window_ready?
- Added is_window_resized?
- Added is_window_state?
- Added load_music_stream
- Added load_sound
- Added load_texture
- Added maximise_window
- Added minimise_window
- Added Music#context_type=
- Added Music#initialize
- Added Music#looping=
- Added Music#sample_count=
- Added Music#to_h
- Added open_url
- Added pause_music_stream
- Added pause_sound
- Added play_music_stream
- Added play_sound
- Added play_sound_multi
- Added Rectangle#height=
- Added Rectangle#initialize
- Added Rectangle#to_h
- Added Rectangle#width=
- Added Rectangle#x=
- Added Rectangle#y=
- Added restore_window
- Added resume_music_stream
- Added resume_sound
- Added set_config_flags
- Added set_gestures_enabled
- Added set_master_volume
- Added set_music_pitch
- Added set_music_volume
- Added set_sound_pitch
- Added set_sound_volume
- Added set_target_fps
- Added set_trace_log_level
- Added set_window_state
- Added Sound#initialize
- Added Sound#sample_count=
- Added Sound#to_h
- Added stop_music_stream
- Added stop_sound
- Added stop_sound_multi
- Added Texture2D#format=
- Added Texture2D#height=
- Added Texture2D#id=
- Added Texture2D#initialize
- Added Texture2D#mipmaps=
- Added Texture2D#to_h
- Added Texture2D#width=
- Added toggle_fullscreen
- Added unload_music_stream
- Added unload_sound
- Added unload_texture
- Added update_music_stream
- Added Vector2#+
- Added Vector2#-
- Added Vector2#==
- Added Vector2#initialize
- Added Vector2#length
- Added Vector2#scale
- Added Vector2#to_h
- Added Vector2#x=
- Added Vector2#y=
- Added window_should_close?
