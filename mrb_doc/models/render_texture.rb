class RenderTexture
  # Creates a new instance of {RenderTexture}.
  # @param width [Integer]
  # @param height [Integer]
  # @return [RenderTexture]
  def initialize(width, height)
    # mrb_RenderTexture_initialize
    # src/mruby_integration/models/render_texture.cpp
    RenderTexture.new
  end

  # Unloads the render texture from memory.
  # @return [nil]
  def unload
    # src/mruby_integration/models/render_texture.cpp
    nil
  end
end
