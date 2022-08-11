# The RenderTexture class is used to draw things to a texture
class RenderTexture
  # @return [Texture2D]
  attr_reader :texture

  # @return [Integer]
  attr_reader :width, :height

  # Creates a new instance of RenderTexture
  # @param width [Integer]
  # @param height [Integer]
  # @return [RenderTexture]
  def initialize(width, height)
    # mrb_RenderTexture_initialize
    # src/mruby_integration/models/render_texture.cpp
    RenderTexture.new
  end

  # Unloads the render texture from memory
  # @return [nil]
  def unload
    # src/mruby_integration/models/render_texture.cpp
    nil
  end

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    # src/mruby_integration/models/render_texture.cpp
    {
      width: width,
      height: height,
    }
  end

  # Instead of rending to the screen, render to this RenderTexture
  # @yield The block that calls your rendering logic
  # @return [nil]
  def drawing(&block)
    # src/mruby_integration/models/render_texture.cpp
    nil
  end
end
