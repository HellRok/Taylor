# The RenderTexture class is used to draw things to a texture
class RenderTexture
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

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    # src/mruby_integration/models/render_texture.cpp
    {
      width: width,
      height: height,
    }
  end
end
