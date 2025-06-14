# The RenderTexture class is used to draw things to a texture.
class RenderTexture
  # @return [Texture2D]
  attr_reader :texture

  # @return [Integer]
  attr_reader :width, :height

  # Return the object represented by a Hash.
  # @return [Hash]
  def to_h
    {
      texture: texture.to_h,
      width: width,
      height: height
    }
  end

  # Instead of rending to the screen, render to this RenderTexture.
  # @yield The block that calls your rendering logic.
  # @return [nil]
  def drawing(&block)
    begin_texture_mode(self)
    block.call
  ensure
    end_texture_mode
  end

  # A method used to generate the mock data for Raylib.
  #
  # @example Basic usage
  #   Taylor::Raylib.mock_call(
  #     "LoadRenderTexture",
  #     RenderTexture.mock_return(width: 10, height: 10)
  #   )
  #
  # @param width [Integer]
  # @param height [Integer]
  # @return [String]
  def self.mock_return(width: 10, height: 10)
    [width, height].map(&:to_s).join(" ")
  end
end
