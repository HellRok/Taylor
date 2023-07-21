class RenderTexture
  attr_reader :texture, :width, :height

  def to_h
    {
      texture: texture.to_h,
      width: width,
      height: height,
    }
  end

  def drawing(&block)
    begin_texture_mode(self)
    block.call
  ensure
    end_texture_mode
  end
end
