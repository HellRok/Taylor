class RenderTexture
  # @return [Integer]
  attr_reader :width, :height

  # Creates a new instance of {RenderTexture}.
  #
  # @example Basic usage
  #   texture = RenderTexture.new(width: 100, height: 100)
  #
  # @param width [Integer]
  # @param height [Integer]
  # @return [RenderTexture]
  def initialize(width:, height:)
    # mrb_RenderTexture_initialize
    # src/mruby_integration/models/render_texture.cpp
    RenderTexture.new
  end

  # Unloads the {RenderTexture} from memory.
  #
  # @example Basic usage
  #   texture = RenderTexture.new(width: 100, height: 100)
  #   #... Later
  #   texture.unload
  #
  # @return [nil]
  def unload
    # src/mruby_integration/models/render_texture.cpp
    nil
  end
end
