# Taylor

## Unreleased


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
