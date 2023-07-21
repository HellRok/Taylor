class Camera2D
  attr_reader :offset, :target, :rotation, :zoom

  def offset=(other)
    offset.x = other.x
    offset.y = other.y
    offset
  end

  def target=(other)
    target.x = other.x
    target.y = other.y
    target
  end

  def to_h
    {
      offset: offset.to_h,
      target: target.to_h,
      rotation: rotation,
      zoom: zoom,
    }
  end

  def drawing(&block)
    begin_mode2D(self)
    block.call
  ensure
    end_mode2D
  end

  def as_in_viewport(vector)
    get_world_to_screen2D(vector, self)
  end

  def as_in_world(vector)
    get_screen_to_world2D(vector, self)
  end
end
