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
    # mrb_RenderTexture_unload
    # src/mruby_integration/models/render_texture.cpp
    nil
  end

  # Checks if the {RenderTexture} was successfully loaded onto the GPU and is valid.
  #
  # @example Basic usage
  #   texture = RenderTexture2D.new(width: 640, height: 480)
  #   raise "Bad image!" unless texture.valid?
  #   texture.unload
  #
  # @return [Boolean]
  def valid?
    # mrb_RenderTexture_valid
    # src/mruby_integration/models/render_texture.cpp
    true
  end

  # Start drawing to the {RenderTexture#texture}, so instead of going to the screen, they'll render to the {Texture2D}.
  #
  # @example Basic usage
  #   texture = RenderTexture.new(width: 640, height: 480)
  #
  #   texture.begin_drawing
  #   begin
  #     # Drawing code here
  #   ensure
  #     texture.end_drawing
  #   end
  #
  # @return [nil]
  def begin_drawing
    # mrb_RenderTexture_begin_drawing
    # src/mruby_integration/models/render_texture.cpp
    nil
  end

  # Stops drawing to the {RenderTexture#texture}.
  #
  # @example Basic usage
  #   texture = RenderTexture.new(width: 640, height: 480)
  #
  #   texture.begin_drawing
  #   begin
  #     # Drawing code here
  #   ensure
  #     texture.end_drawing
  #   end
  #
  # @return [nil]
  def end_drawing
    # mrb_RenderTexture_end_drawing
    # src/mruby_integration/models/render_texture.cpp
    nil
  end
end
