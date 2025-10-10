@unit.describe "Circle#initialize" do
  When "we initialize a circle" do
    @circle = Circle.new(x: 1, y: 2, radius: 3, colour: Colour[4, 5, 6, 7])
  end

  Then "it has the expected attributes" do
    expect(@circle).to_be_a(Circle)
    expect(@circle.x).to_equal(1)
    expect(@circle.y).to_equal(2)
    expect(@circle.radius).to_equal(3)
    expect(@circle.colour).to_equal(Colour[4, 5, 6, 7])
    expect(@circle.outline).to_be_nil
    expect(@circle.thickness).to_equal(1)
    expect(@circle.gradient).to_be_nil
  end

  When "we initialize a circle with all the arguments" do
    @circle = Circle.new(x: 2, y: 3, radius: 4, colour: Colour[5, 6, 7, 8], outline: Colour[9, 10, 11, 12], thickness: 13, gradient: Colour[13, 14, 15, 16])
  end

  Then "it has the expected attributes" do
    expect(@circle).to_be_a(Circle)
    expect(@circle.x).to_equal(2)
    expect(@circle.y).to_equal(3)
    expect(@circle.radius).to_equal(4)
    expect(@circle.colour).to_equal(Colour[5, 6, 7, 8])
    expect(@circle.outline).to_equal(Colour[9, 10, 11, 12])
    expect(@circle.thickness).to_equal(13)
    expect(@circle.gradient).to_equal(Colour[13, 14, 15, 16])
  end

  When "we initialize with an invalid radius" do
    expect {
      Circle.new(x: 0, y: 0, radius: 0, colour: Colour[0, 0, 0, 0])
    }.to_raise(ArgumentError, "Radius must be greater than 0")
  end

  When "we initialize with an invalid thickness" do
    expect {
      Circle.new(x: 0, y: 0, radius: 1, colour: Colour[0, 0, 0, 0], thickness: 0)
    }.to_raise(ArgumentError, "Thickness must be greater than 0")
  end

  Then "clean up" do
    @circle = nil
  end
end

@unit.describe "Circle.[]" do
  When "we initialize a circle" do
    @circle = Circle[1, 2, 3, Colour::GREEN]
  end

  Then "it has the expected attributes" do
    expect(@circle).to_be_a(Circle)
    expect(@circle.x).to_equal(1)
    expect(@circle.y).to_equal(2)
    expect(@circle.radius).to_equal(3)
    expect(@circle.colour).to_equal(Colour::GREEN)
    expect(@circle.outline).to_be_nil
    expect(@circle.thickness).to_equal(1)
    expect(@circle.gradient).to_be_nil
  end

  Then "clean up" do
    @circle = nil
  end
end

@unit.describe "Circle attributes" do
  When "we initialize a circle" do
    @circle = Circle.new(x: 3, y: 4, radius: 5, colour: Colour[6, 7, 8, 9], outline: Colour[10, 11, 12, 13], thickness: 14, gradient: Colour[14, 15, 16, 17])
  end

  And "we update all the attributes" do
    @circle.x = 4
    @circle.y = 5
    @circle.radius = 6
    @circle.colour = Colour[7, 8, 9, 10]
    @circle.outline = Colour[11, 12, 13, 14]
    @circle.thickness = 15
    @circle.gradient = Colour[15, 16, 17, 18]
  end

  Then "it has the expected attributes" do
    expect(@circle.x).to_equal(4)
    expect(@circle.y).to_equal(5)
    expect(@circle.radius).to_equal(6)
    expect(@circle.colour).to_equal(Colour[7, 8, 9, 10])
    expect(@circle.outline).to_equal(Colour[11, 12, 13, 14])
    expect(@circle.thickness).to_equal(15)
    expect(@circle.gradient).to_equal(Colour[15, 16, 17, 18])
  end

  When "we try to assign an invalid radius" do
    expect {
      @circle.radius = 0
    }.to_raise(ArgumentError, "Radius must be greater than 0")
  end

  When "we try to assign an invalid thickness" do
    expect {
      @circle.thickness = 0
    }.to_raise(ArgumentError, "Thickness must be greater than 0")
  end

  Then "clean up" do
    @circle = nil
  end
end

@unit.describe "Circle#.to_h" do
  When "we initialize a circle" do
    @circle = Circle.new(
      x: 4, y: 5, radius: 6,
      colour: Colour[7, 8, 9, 10],
      outline: Colour[11, 12, 13, 14], thickness: 15,
      gradient: Colour[16, 17, 18, 19]
    )
  end

  Then "return a hash  with all the attributes" do
    expect(@circle.to_h).to_equal({
      x: 4,
      y: 5,
      radius: 6,
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
      gradient: {
        red: 16,
        green: 17,
        blue: 18,
        alpha: 19
      }
    })
  end
end

@unit.describe "Circle#draw" do
  When "we draw a circle" do
    Circle.new(x: 1, y: 2, radius: 3, colour: Colour[4, 5, 6, 7]).draw
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawCircle) { " \
          "centerX: 1 " \
          "centerY: 2 " \
          "radius: 3.000000 " \
          "color: { r: 4 g: 5 b: 6 a: 7 } " \
        "}"
      ]
    )
    Taylor::Raylib.reset_calls
  end

  When "we draw a circle with an outline" do
    Circle.new(x: 2, y: 3, radius: 4, colour: Colour[5, 6, 7, 8], outline: Colour[9, 10, 11, 12], thickness: 13).draw
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawCircle) { " \
          "centerX: 2 " \
          "centerY: 3 " \
          "radius: 4.000000 " \
          "color: { r: 5 g: 6 b: 7 a: 8 } " \
        "}",
        "(DrawPolyLinesEx) { " \
          "center: { x: 2.000000 y: 3.000000 } " \
          "sides: 60 " \
          "radius: 4.000000 " \
          "rotation: 0.000000 " \
          "lineThick: 13.000000 " \
          "color: { r: 9 g: 10 b: 11 a: 12 } " \
        "}"
      ]
    )
    Taylor::Raylib.reset_calls
  end

  When "we draw a circle with a gradient" do
    Circle.new(x: 3, y: 4, radius: 5, colour: Colour[6, 7, 8, 9], gradient: Colour[10, 11, 12, 13]).draw
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawCircleGradient) { " \
          "centerX: 3 " \
          "centerY: 4 " \
          "radius: 5.000000 " \
          "inner: { r: 6 g: 7 b: 8 a: 9 } " \
          "outer: { r: 10 g: 11 b: 12 a: 13 } " \
        "}"
      ]
    )
    Taylor::Raylib.reset_calls
  end

  When "we draw a circle with a gradient and an outline" do
    Circle.new(
      x: 4,
      y: 5,
      radius: 6,
      colour: Colour[7, 8, 9, 10],
      outline: Colour[11, 12, 13, 14],
      thickness: 15,
      gradient: Colour[16, 17, 18, 19]
    ).draw
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawCircleGradient) { " \
          "centerX: 4 " \
          "centerY: 5 " \
          "radius: 6.000000 " \
          "inner: { r: 7 g: 8 b: 9 a: 10 } " \
          "outer: { r: 16 g: 17 b: 18 a: 19 } " \
        "}",
        "(DrawPolyLinesEx) { " \
          "center: { x: 4.000000 y: 5.000000 } " \
          "sides: 60 " \
          "radius: 6.000000 " \
          "rotation: 0.000000 " \
          "lineThick: 15.000000 " \
          "color: { r: 11 g: 12 b: 13 a: 14 } " \
        "}"
      ]
    )
    Taylor::Raylib.reset_calls
  end

  Given "we have a circle" do
    @circle = Circle.new(x: 1, y: 2, radius: 3, colour: Colour[4, 5, 6, 7])
  end

  Then "we add an outline" do
    @circle.outline = Colour[5, 6, 7, 8]
  end

  When "we draw" do
    @circle.draw
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawCircle) { " \
          "centerX: 1 " \
          "centerY: 2 " \
          "radius: 3.000000 " \
          "color: { r: 4 g: 5 b: 6 a: 7 } " \
        "}",
        "(DrawPolyLinesEx) { " \
          "center: { x: 1.000000 y: 2.000000 } " \
          "sides: 60 " \
          "radius: 3.000000 " \
          "rotation: 0.000000 " \
          "lineThick: 1.000000 " \
          "color: { r: 5 g: 6 b: 7 a: 8 } " \
        "}"
      ]
    )
    Taylor::Raylib.reset_calls
  end

  Then "we remove the outline and add a gradient" do
    @circle.outline = nil
    @circle.gradient = Colour[6, 7, 8, 9]
  end

  When "we draw" do
    @circle.draw
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawCircleGradient) { " \
          "centerX: 1 " \
          "centerY: 2 " \
          "radius: 3.000000 " \
          "inner: { r: 4 g: 5 b: 6 a: 7 } " \
          "outer: { r: 6 g: 7 b: 8 a: 9 } " \
        "}"
      ]
    )
    Taylor::Raylib.reset_calls
  end

  Then "we remove the gradient" do
    @circle.gradient = nil
  end

  When "we draw" do
    @circle.draw
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawCircle) { " \
          "centerX: 1 " \
          "centerY: 2 " \
          "radius: 3.000000 " \
          "color: { r: 4 g: 5 b: 6 a: 7 } " \
        "}"
      ]
    )
  end
end
