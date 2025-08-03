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
