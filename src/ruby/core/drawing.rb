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
