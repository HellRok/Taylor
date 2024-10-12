# Clears the screen with the specified colour.
# @param colour [Colour]
# @return [nil]
def clear_background(colour)
  # mrb_clear_background
  # src/mruby_integration/core/drawing.cpp
  nil
end

# Starts drawing to the screen.
# @return [nil]
def begin_drawing
  # mrb_begin_drawing
  # src/mruby_integration/core/drawing.cpp
  nil
end

# Ends drawing to the screen.
# @return [nil]
def end_drawing
  # mrb_end_drawing
  # src/mruby_integration/core/drawing.cpp
  nil
end

# Starts drawing to the {RenderTexture}.
# @param texture [RenderTexture]
# @return [nil]
def begin_texture_mode(texture)
  # mrb_begin_texture_mode
  # src/mruby_integration/core/drawing.cpp
  nil
end

# Stops drawing to the {RenderTexture}.
# @return [nil]
def end_texture_mode
  # mrb_end_texture_mode
  # src/mruby_integration/core/drawing.cpp
  nil
end

# All draw calls within will be drawn through the {Shader}.
# @param shader [Shader]
# @return [nil]
def begin_shader_mode(shader)
  # mrb_begin_shader_mode
  # src/mruby_integration/core/drawing.cpp
  nil
end

# Stops drawing through the {Shader}.
# @return [nil]
def end_shader_mode
  # mrb_end_shader_mode
  # src/mruby_integration/core/drawing.cpp
  nil
end

# In scissor mode only draw calls within the defined area will actually be drawn.
# @param x [Integer]
# @param y [Integer]
# @param width [Integer]
# @param height [Integer]
# @return [nil]
def begin_scissor_mode(x, y, width, height)
  # mrb_begin_scissor_mode
  # src/mruby_integration/core/drawing.cpp
  nil
end

# End scissor mode.
# @return [nil]
def end_scissor_mode
  # mrb_end_scissor_mode
  # src/mruby_integration/core/drawing.cpp
  nil
end

# All draw calls within will be drawn using the specified blend mode.
# @param mode [Integer]
# @return [nil]
def begin_blend_mode(mode)
  # mrb_begin_blend_mode
  # src/mruby_integration/core/drawing.cpp
  nil
end

# End blend mode.
# @return [nil]
def end_blend_mode
  # mrb_end_blend_mode
  # src/mruby_integration/core/drawing.cpp
  nil
end
