# Clear the screen with the specified colour.
# @param colour [Colour]
# @return [nil]
def clear(colour: Colour::RAYWHITE)
  clear_background(colour)
end

# Allows you to call rendering functions within the block.
# @yield The block that calls your rendering logic.
# @return [nil]
def drawing(&block)
  begin_drawing
  block.call
ensure
  end_drawing
end

# Allows you to call rendering functions within the block but limits the output.
# to within the bounds of `section`.
# @yield The block that calls your rendering logic.
# @param section [Rectangle]
# @return [nil]
def scissor_mode(section, &block)
  begin_scissor_mode(section.x, section.y, section.width, section.height)
  block.call
ensure
  end_scissor_mode
end

# Allows you to call rendering functions within the block using blending.
# @yield The block that calls your rendering logic.
# @param mode [Integer] Must be one of {BLEND_ALPHA}, {BLEND_ADDITIVE},
#   {BLEND_MULTIPLIED}, {BLEND_ADD_COLORS}, {BLEND_SUBTRACT_COLORS},
#   {BLEND_ALPHA_PREMULTIPLY}, {BLEND_CUSTOM}, {BLEND_CUSTOM_SEPARATE}
# @return [nil]
def blend_mode(mode = BLEND_ALPHA, &block)
  begin_blend_mode(mode)
  block.call
ensure
  end_blend_mode
end

# @!group Blend modes

# Blend textures considering alpha.
BLEND_ALPHA = 0
# Blend textures adding colors.
BLEND_ADDITIVE = 1
# Blend textures multiplying colors.
BLEND_MULTIPLIED = 2
# Blend textures adding colors (alternative).
BLEND_ADD_COLORS = 3
# Blend textures subtracting colors (alternative).
BLEND_SUBTRACT_COLORS = 4
# Blend premultiplied textures considering alpha.
BLEND_ALPHA_PREMULTIPLY = 5
# Blend textures using custom src/dst factors.
# @note Currently you can't set custom blend factors.
BLEND_CUSTOM = 6
# Blend textures using custom rgb/alpha separate src/dst factors.
# @note Currently you can't set custom blend factors.
BLEND_CUSTOM_SEPARATE = 7

# @!endgroup
