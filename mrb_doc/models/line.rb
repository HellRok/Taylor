class Line
  # @return [Vector2]
  attr_writer :start, :end

  # @return [Colour]
  attr_writer :colour

  # @return [Float]
  attr_accessor :thickness

  # Creates a new instance of {Line}.
  #
  # @example Basic usage
  #   line = Line.new(start: Vector2[10, 10], end: Vector2[50, 60], colour:Colour::RED)
  #
  # @param start [Vector2]
  # @param end [Vector2]
  # @param colour [Colour]
  # @param thickness [Float]
  # @return [Line]
  def initialize(start:, end:, colour:, thickness: 1.0)
    # mrb_Line_initialize
    # src/mruby_integration/models/line.cpp
    Line.new
  end
end
