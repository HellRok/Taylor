# @!group Window flags

# Set to run program in fullscreen.
FLAG_FULLSCREEN_MODE = 0x00000002

# Set to try enabling V-Sync on GPU.
FLAG_VSYNC_HINT = 0x00000040
# Set to try enabling MSAA 4X.
FLAG_MSAA_4X_HINT = 0x00000020
# Set to try enabling interlaced video format (for V3D).
FLAG_INTERLACED_HINT = 0x00010000

# Set to allow resizable window.
FLAG_WINDOW_RESIZABLE = 0x00000004
# Set to disable window decoration (frame and buttons).
FLAG_WINDOW_UNDECORATED = 0x00000008
# Set to hide window.
FLAG_WINDOW_HIDDEN = 0x00000080
# Set to minimize window (iconify).
FLAG_WINDOW_MINIMISED = 0x00000200
# Set to maximize window (expanded to monitor).
FLAG_WINDOW_MAXIMISED = 0x00000400
# Set to window non focused.
FLAG_WINDOW_UNFOCUSED = 0x00000800
# Set to window always on top.
FLAG_WINDOW_TOPMOST = 0x00001000
# Set to allow windows running while minimized.
FLAG_WINDOW_ALWAYS_RUN = 0x00000100
# Set to allow transparent framebuffer.
FLAG_WINDOW_TRANSPARENT = 0x00000010
# Set to support HighDPI.
FLAG_WINDOW_HIGHDPI = 0x00002000

# @!engroup
