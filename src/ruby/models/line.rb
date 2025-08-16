# The {Line} class is used to draw straight lines.
class Line
  # @return [Vector2]
  attr_reader :start, :end

  # @return [Colour]
  attr_reader :colour

  # Return the {Line} represented as a Hash
  #
  # @example Basic usage
  #   line = Line.new(start: Vector2[1, 2], end: Vector2[3, 4], colour: Colour[5, 6, 7, 8], thickness: 9)
  #
  #   p line.to_h
  #   # =>  {
  #   #       start: {
  #   #         x: 1,
  #   #         y: 2,
  #   #       },
  #   #       end: {
  #   #         x: 3,
  #   #         y: 4,
  #   #       },
  #   #       colour: {
  #   #         red: 5,
  #   #         green: 6,
  #   #         blue: 7,
  #   #         alpha: 8
  #   #       },
  #   #       thickness: 9,
  #   #     }
  #
  # @return [Hash]
  def to_h
    {
      start: start&.to_h,
      end: self.end&.to_h,
      colour: colour&.to_h,
      thickness: thickness
    }
  end
end
