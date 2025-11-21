@unit.describe "Rectangle#initialize" do
  When "we initialize a rectangle" do
    @rectangle = Rectangle.new(x: 1, y: 2, width: 3, height: 4)
  end

  Then "it has the correct attributes" do
    expect(@rectangle).to_be_a(Rectangle)
    expect(@rectangle.x).to_equal(1)
    expect(@rectangle.y).to_equal(2)
    expect(@rectangle.width).to_equal(3)
    expect(@rectangle.height).to_equal(4)
    expect(@rectangle.colour).to_equal(Colour::BLACK)
    expect(@rectangle.outline).to_be_nil
    expect(@rectangle.thickness).to_equal(1)
    expect(@rectangle.roundness).to_equal(0)
    expect(@rectangle.segments).to_equal(6)
  end

  When "we initialize with all the arguments" do
    @rectangle = Rectangle.new(x: 2, y: 3, width: 4, height: 5, colour: Colour[6, 7, 8, 9], outline: Colour[10, 11, 12, 13], thickness: 14, roundness: 0.5, segments: 15)
  end

  Then "it has the correct attributes" do
    expect(@rectangle).to_be_a(Rectangle)
    expect(@rectangle.x).to_equal(2)
    expect(@rectangle.y).to_equal(3)
    expect(@rectangle.width).to_equal(4)
    expect(@rectangle.height).to_equal(5)
    expect(@rectangle.colour).to_equal(Colour[6, 7, 8, 9])
    expect(@rectangle.outline).to_equal(Colour[10, 11, 12, 13])
    expect(@rectangle.thickness).to_equal(14)
    expect(@rectangle.roundness).to_equal(0.5)
    expect(@rectangle.segments).to_equal(15)
  end

  But "if thickness is too low, raise an error" do
    expect {
      Rectangle.new(x: 0, y: 0, width: 0, height: 0, colour: Colour[0, 0, 0, 0], thickness: 0)
    }.to_raise(ArgumentError, "Thickness must be greater than 0")
  end

  Or "if roundness is too low" do
    expect {
      Rectangle.new(x: 0, y: 0, width: 0, height: 0, colour: Colour[0, 0, 0, 0], roundness: -0.1)
    }.to_raise(ArgumentError, "Roundness must be within (0.0..1.0)")
  end

  Or "if roundness is too high" do
    expect {
      Rectangle.new(x: 0, y: 0, width: 0, height: 0, colour: Colour[0, 0, 0, 0], roundness: 1.1)
    }.to_raise(ArgumentError, "Roundness must be within (0.0..1.0)")
  end

  Or "if segments is too low" do
    expect {
      Rectangle.new(x: 0, y: 0, width: 0, height: 0, colour: Colour[0, 0, 0, 0], segments: 0)
    }.to_raise(ArgumentError, "Segments must be greater than 0")
  end

  Then "clean up" do
    @rectangle = nil
  end
end

@unit.describe "Rectangle.[]" do
  When "we get a new rectangle" do
    @rectangle = Rectangle[1, 2, 3, 4]
  end

  Then "it has the correct attributes" do
    expect(@rectangle).to_be_a(Rectangle)
    expect(@rectangle.x).to_equal(1)
    expect(@rectangle.y).to_equal(2)
    expect(@rectangle.width).to_equal(3)
    expect(@rectangle.height).to_equal(4)
    expect(@rectangle.colour).to_equal(Colour::BLACK)
    expect(@rectangle.outline).to_be_nil
    expect(@rectangle.thickness).to_equal(1)
    expect(@rectangle.roundness).to_equal(0)
    expect(@rectangle.segments).to_equal(6)
  end

  Then "clean up" do
    @rectangle = nil
  end
end

@unit.describe "Rectangle attributes" do
  Given "we have a rectangle" do
    @rectangle = Rectangle.new(x: 0, y: 0, width: 0, height: 0, colour: Colour[0, 0, 0, 0], outline: Colour[0, 0, 0, 0], thickness: 1, roundness: 0, segments: 1)
  end

  When "we update the attributes" do
    @rectangle.x = 3
    @rectangle.y = 4
    @rectangle.width = 5
    @rectangle.height = 6
    @rectangle.colour = Colour[7, 8, 9, 10]
    @rectangle.outline = Colour[11, 12, 13, 14]
    @rectangle.thickness = 15
    @rectangle.roundness = 1
    @rectangle.segments = 16
  end

  Then "it has the correct attributes" do
    expect(@rectangle.x).to_equal(3)
    expect(@rectangle.y).to_equal(4)
    expect(@rectangle.width).to_equal(5)
    expect(@rectangle.height).to_equal(6)
    expect(@rectangle.colour).to_equal(Colour[7, 8, 9, 10])
    expect(@rectangle.outline).to_equal(Colour[11, 12, 13, 14])
    expect(@rectangle.thickness).to_equal(15)
    expect(@rectangle.roundness).to_equal(1)
    expect(@rectangle.segments).to_equal(16)
  end

  But "if thickness is too low, raise an error" do
    expect {
      @rectangle.thickness = -1
    }.to_raise(ArgumentError, "Thickness must be greater than 0")
  end

  Or "if roundness is too low" do
    expect {
      @rectangle.roundness = -0.1
    }.to_raise(ArgumentError, "Roundness must be within (0.0..1.0)")
  end

  Or "if roundness is too high" do
    expect {
      @rectangle.roundness = 1.1
    }.to_raise(ArgumentError, "Roundness must be within (0.0..1.0)")
  end

  Or "if segments is too low" do
    expect {
      @rectangle.segments = 0
    }.to_raise(ArgumentError, "Segments must be greater than 0")
  end

  Then "clean up" do
    @rectangle = nil
  end
end

@unit.describe "Rectangle#to_h" do
  Given "we have a rectangle" do
    @rectangle = Rectangle.new(x: 3, y: 4, width: 5, height: 6, colour: Colour[7, 8, 9, 10], outline: Colour[11, 12, 13, 14], thickness: 15, roundness: 0.75, segments: 16)
  end

  Then "to_h returns a hash with all the attributes" do
    expect(@rectangle.to_h).to_equal(
      {
        x: 3,
        y: 4,
        width: 5,
        height: 6,
        colour: {
          red: 7,
          green: 8,
          blue: 9,
          alpha: 10
        },
        outline: {
          red: 11,
          green: 12,
          blue: 13,
          alpha: 14
        },
        thickness: 15,
        roundness: 0.75,
        segments: 16
      }
    )
  end

  Given "we have a rectangle with only some attributes" do
    @rectangle = Rectangle.new(x: 3, y: 4, width: 5, height: 6, colour: Colour[7, 8, 9, 10])
  end

  Then "to_h returns a hash with all the attributes" do
    expect(@rectangle.to_h).to_equal(
      {
        x: 3,
        y: 4,
        width: 5,
        height: 6,
        colour: {
          red: 7,
          green: 8,
          blue: 9,
          alpha: 10
        },
        outline: {},
        thickness: 1,
        roundness: 0,
        segments: 6
      }
    )
  end

  Then "clean up" do
    @rectangle = nil
  end
end

@unit.describe "Rectangle#draw" do
  When "we draw a rectangle" do
    Rectangle.new(x: 4, y: 5, width: 6, height: 7, colour: Colour[8, 9, 10, 11]).draw
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawRectangleRec) { " \
          "rec: { " \
            "x: 4.000000 " \
            "y: 5.000000 " \
            "width: 6.000000 " \
            "height: 7.000000 " \
          "} " \
          "color: { " \
            "r: 8 " \
            "g: 9 " \
            "b: 10 " \
            "a: 11 " \
          "} " \
        "}"
      ]
    )
  end

  When "we draw a rectangle with an outline" do
    Rectangle.new(x: 5, y: 6, width: 7, height: 8, colour: Colour[9, 10, 11, 12], outline: Colour[13, 14, 15, 16], thickness: 17).draw
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawRectangleRec) { " \
          "rec: { " \
            "x: 5.000000 " \
            "y: 6.000000 " \
            "width: 7.000000 " \
            "height: 8.000000 " \
          "} " \
          "color: { " \
            "r: 9 " \
            "g: 10 " \
            "b: 11 " \
            "a: 12 " \
          "} " \
        "}",
        "(DrawRectangleLinesEx) { " \
          "rec: { " \
            "x: 5.000000 " \
            "y: 6.000000 " \
            "width: 7.000000 " \
            "height: 8.000000 " \
          "} " \
          "lineThick: 17.000000 " \
          "color: { " \
            "r: 13 " \
            "g: 14 " \
            "b: 15 " \
            "a: 16 " \
          "} " \
        "}"
      ]
    )
  end

  When "we draw a rounded rectangle" do
    Rectangle.new(x: 6, y: 7, width: 8, height: 9, colour: Colour[10, 11, 12, 13], roundness: 0.14, segments: 15).draw
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawRectangleRounded) { " \
          "rec: { " \
            "x: 6.000000 " \
            "y: 7.000000 " \
            "width: 8.000000 " \
            "height: 9.000000 " \
          "} " \
          "roundness: 0.140000 " \
          "segments: 15 " \
          "color: { " \
            "r: 10 " \
            "g: 11 " \
            "b: 12 " \
            "a: 13 " \
          "} " \
        "}"
      ]
    )
  end

  When "we draw a rounded rectangle with an outline" do
    Rectangle.new(x: 7, y: 8, width: 9, height: 10, colour: Colour[11, 12, 13, 14], outline: Colour[15, 16, 17, 18], thickness: 19, roundness: 0.20, segments: 21).draw
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawRectangleRounded) { " \
          "rec: { " \
            "x: 7.000000 " \
            "y: 8.000000 " \
            "width: 9.000000 " \
            "height: 10.000000 " \
          "} " \
          "roundness: 0.200000 " \
          "segments: 21 " \
          "color: { " \
            "r: 11 " \
            "g: 12 " \
            "b: 13 " \
            "a: 14 " \
          "} " \
        "}",
        "(DrawRectangleRoundedLinesEx) { " \
          "rec: { " \
            "x: 7.000000 " \
            "y: 8.000000 " \
            "width: 9.000000 " \
            "height: 10.000000 " \
          "} " \
          "roundness: 0.200000 " \
          "segments: 21 " \
          "lineThick: 19.000000 " \
          "color: { " \
            "r: 15 " \
            "g: 16 " \
            "b: 17 " \
            "a: 18 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Rectangle#begin_scissoring" do
  When "we call begin_scissoring" do
    Rectangle.new(x: 13.3, y: 14.4, width: 15.5, height: 16.6, colour: Colour::GREEN).begin_scissoring
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(BeginScissorMode) { x: 13 y: 14 width: 15 height: 16 }"
      ]
    )
  end
end

@unit.describe "Rectangle#end_scissoring" do
  When "we call end_scissoring" do
    Rectangle[0, 0, 0, 0].end_scissoring
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(EndScissorMode) { }"
      ]
    )
  end
end

@unit.describe "Rectangle#scissor" do
  When "we call scissor" do
    Rectangle.new(x: 11, y: 12, width: 13, height: 14.4, colour: Colour::GREEN).scissor do
      Window.clear(colour: Colour[1, 0, 0, 0])
    end
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(BeginScissorMode) { x: 11 y: 12 width: 13 height: 14 }",
        "(IsWindowReady) { }",
        "(ClearBackground) { color: { r: 1 g: 0 b: 0 a: 0 } }",
        "(EndScissorMode) { }"
      ]
    )
  end

  But "if there's an error in the block" do
    Rectangle.new(x: 12, y: 13, width: 14, height: 15, colour: Colour::GREEN).scissor do
      Window.clear(colour: Colour[2, 0, 0, 0])
      raise StandardError, "Oops!"
      Window.clear(colour: Colour[3, 0, 0, 0]) # standard:disable Lint/UnreachableCode
    end
  rescue => error
    expect(error.message).to_equal("Oops!")
  end

  Then "we still end scissoring" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(BeginScissorMode) { x: 12 y: 13 width: 14 height: 15 }",
        "(IsWindowReady) { }",
        "(ClearBackground) { color: { r: 2 g: 0 b: 0 a: 0 } }",
        "(EndScissorMode) { }"
      ]
    )
  end
end

@unit.describe "Rectangle#overlaps?" do
  Given "we have a rectangle and a vector" do
    @rectangle = Rectangle.new(x: 3, y: 4, width: 2, height: 3)
    @vector = Vector2.new(x: 0, y: 0)
  end

  Then "it's outside so we return false" do
    expect(@rectangle.overlaps?(@vector)).to_be_false
  end

  When "the vector is inside the rectangle" do
    @vector.x = 4
    @vector.y = 6
  end

  Then "it's inside so we return true" do
    expect(@rectangle.overlaps?(@vector)).to_be_true
  end

  When "the vector is on the top edge" do
    @vector.x = 4
    @vector.y = 4
  end

  Then "it's considered inside so we return true" do
    expect(@rectangle.overlaps?(@vector)).to_be_true
  end

  When "the vector is on the bottom edge" do
    @vector.x = 4
    @vector.y = 7
  end

  Then "it's considered inside so we return true" do
    expect(@rectangle.overlaps?(@vector)).to_be_true
  end

  When "the vector is on the left edge" do
    @vector.x = 3
    @vector.y = 6
  end

  Then "it's considered inside so we return true" do
    expect(@rectangle.overlaps?(@vector)).to_be_true
  end

  When "the vector is on the right edge" do
    @vector.x = 5
    @vector.y = 6
  end

  Then "it's considered inside so we return true" do
    expect(@rectangle.overlaps?(@vector)).to_be_true
  end

  When "the vector is further out than the rectangle" do
    @vector.x = 10
    @vector.y = 10
  end

  Then "it's not inside so we return false" do
    expect(@rectangle.overlaps?(@vector)).to_be_false
  end

  When "passed in anything other than a vector raise an error" do
    expect {
      @rectangle.overlaps?("string")
    }.to_raise(ArgumentError, "Must pass in a Vector2")
  end

  And "cleanup" do
    @rectangle = nil
    @vector = nil
  end
end
