@unit.describe "Line#initialize" do
  When "you initialize a line" do
    @line = Line.new(start: Vector2[0, 1], end: Vector2[2, 3], colour: Colour[4, 5, 6, 7])
  end

  Then "it has the correct attributes" do
    expect(@line).to_be_a(Line)
    expect(@line.start).to_equal(Vector2[0, 1])
    expect(@line.end).to_equal(Vector2[2, 3])
    expect(@line.colour).to_equal(Colour[4, 5, 6, 7])
    expect(@line.thickness).to_equal(1)
  end

  When "you initialize a line with all the arguments" do
    @line = Line.new(start: Vector2[1, 2], end: Vector2[3, 4], colour: Colour[5, 6, 7, 8], thickness: 9)
  end

  Then "it has the correct attributes" do
    expect(@line).to_be_a(Line)
    expect(@line.start).to_equal(Vector2[1, 2])
    expect(@line.end).to_equal(Vector2[3, 4])
    expect(@line.colour).to_equal(Colour[5, 6, 7, 8])
    expect(@line.thickness).to_equal(9)
  end

  But "raises an error if thickness is negative" do
    expect {
      Line.new(start: Vector2[0, 0], end: Vector2[0, 0], colour: Colour[0, 0, 0, 0], thickness: -1)
    }.to_raise(ArgumentError, "Thickness must be greater than 0")

    expect {
      @line.thickness = 0
    }.to_raise(ArgumentError, "Thickness must be greater than 0")
  end
end

@unit.describe "Line#to_h" do
  Given "we have a line" do
    @line = Line.new(start: Vector2[1, 2], end: Vector2[3, 4], colour: Colour[5, 6, 7, 8], thickness: 9)
  end

  Then "return a hash with all the attributes" do
    expect(@line.to_h).to_equal(
      {
        start: {
          x: 1,
          y: 2
        },
        end: {
          x: 3,
          y: 4
        },
        colour: {
          red: 5,
          green: 6,
          blue: 7,
          alpha: 8
        },
        thickness: 9
      }
    )
  end
end

@unit.describe "Line#draw" do
  Given "we have a line" do
    @line = Line.new(start: Vector2[1, 2], end: Vector2[3, 4], colour: Colour[5, 6, 7, 8], thickness: 9)
  end

  When "we draw it" do
    @line.draw
  end

  Then "Raylib is called with the correct methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawLineEx) { " \
          "startPos: { " \
            "x: 1.000000 " \
            "y: 2.000000 " \
          "} " \
          "endPos: { " \
            "x: 3.000000 " \
            "y: 4.000000 " \
          "} " \
          "thick: 9.000000 " \
          "color: { " \
            "r: 5 " \
            "g: 6 " \
            "b: 7 " \
            "a: 8 " \
          "} " \
        "}"
      ]
    )
  end
end
