# Taylor

## Unreleased

- Buildkite now builds the docker images
- Buildkite now runs tests on Linux, under wine, and in the chrome
- Upgrade mruby to 3.2.0 now that it's released
- Platform specific methods now raise a unique error on unsupported platforms
- Add tests for the platform specific methods
- Upload analytics for the web build too
- Add set_texture_filter
- Add generate_texture_mipmaps
- Add Font.filter=
- Add Texture2D.filter=
- Add Texture2D.generate_mipmaps

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
