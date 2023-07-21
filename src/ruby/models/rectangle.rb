class Rectangle
  attr_reader :x, :y, :width, :height

  def to_h
    {
      x: x,
      y: y,
      width: width,
      height: height,
    }
  end

  def draw(
    origin: Vector2::ZERO,
    rotation: 0,    # only usable when outline and rounded are false
    outline: false,
    thickness: 2,   # only used when outline is true
    rounded: false,
    radius: 0.5,    # only used when rounded is true
    segments: 8,    # only used when rounded is true
    colour: BLACK
  )

    if rounded
      unless (0..1).include?(radius)
        raise ArgumentError, "Radius must fall between 0 and 1, you gave me #{radius}"
      end

      if outline
        draw_rectangle_rounded_lines(self, radius, segments, thickness, colour)
      else
        draw_rectangle_rounded(self, radius, segments, colour)
      end
    else
      if outline
        draw_rectangle_lines_ex(self, thickness, colour)
      else
        draw_rectangle_pro(self, origin, rotation, colour)
      end
    end
  end
end
