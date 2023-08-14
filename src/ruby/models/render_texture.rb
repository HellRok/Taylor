# The RenderTexture class is used to draw things to a texture
class RenderTexture
  # @return [Texture2D]
  attr_reader :texture

  # @return [Integer]
  attr_reader :width, :height

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    {
      texture: texture.to_h,
      width: width,
      height: height
    }
  end

  # Instead of rending to the screen, render to this RenderTexture
  # @yield The block that calls your rendering logic
  # @return [nil]
  def drawing(&block)
    begin_texture_mode(self)
    block.call
  ensure
    end_texture_mode
  end
end
