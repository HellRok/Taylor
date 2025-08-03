# The RenderTexture class is used to draw things to a texture.
class RenderTexture
  # @note If you access the instance variable `@texture` directly and assign it
  #   to a different variable, it will be corrupted when Ruby cleans up the
  #   memory of the parent {RenderTexture} object.
  #
  # @return [Texture2D]
  def texture = @texture # standard:disable Style/TrivialAccessors

  # Return the object represented by a Hash.
  # @return [Hash]
  def to_h
    {
      width: width,
      height: height
    }
  end

  # Start drawing to the {RenderTexture#texture}, so instead of going to the screen, they'll render to the {Texture2D}.
  #
  # @example Basic usage
  #   texture = RenderTexture.new(width: 640, height: 480)
  #
  #   texture.draw
  #     # Drawing code here
  #   end
  #
  # @return [nil]
  def draw(&block)
    begin_drawing
    block.call
  ensure
    end_drawing
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
