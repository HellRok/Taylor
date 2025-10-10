class Object
  include ReferenceCounter
end

@unit.describe "ReferenceCounter#count" do
  Given "the garbage collector has just run" do
    GC.start
  end

  When "we create a string" do
    @string = "hello"
  end

  Then "no counts are required" do
    expect(@string.reference_count).to_equal(0)
    expect(ReferenceCounter.tracked_objects_count).to_equal(0)
    @string = nil
  end

  When "we assign a circle with a colour" do
    @colour = Colour[1, 1, 1, 1]
    @circle = Circle.new(x: 1, y: 1, radius: 1, colour: @colour)
  end

  Then "we track the colour" do
    expect(@circle.reference_count).to_equal(0)
    expect(@colour.reference_count).to_equal(1)
    expect(ReferenceCounter.tracked_objects_count).to_equal(1)
  end

  When "we remove the circle" do
    @circle = nil
    GC.start
  end

  Then "there are no more references" do
    expect(@colour.reference_count).to_equal(0)
    expect(ReferenceCounter.tracked_objects_count).to_equal(0)
  end

  When "we assign the colour to many circles" do
    @circles = 10.times.map {
      Circle.new(x: 1, y: 1, radius: 1, colour: @colour)
    }
  end

  Then "the colour references are tracked" do
    expect(@colour.reference_count).to_equal(10)
    expect(ReferenceCounter.tracked_objects_count).to_equal(1)
  end

  When "we remove all the circles" do
    @circles = nil
    GC.start
  end

  Then "there are no more references" do
    expect(@colour.reference_count).to_equal(0)
    expect(ReferenceCounter.tracked_objects_count).to_equal(0)
  end

  Then "clean up" do
    @colour = nil
  end
end

@unit.describe "ReferenceCounter Circle" do
  Given "we have a circle" do
    @circle = Circle.new(
      x: 1, y: 1, radius: 1, colour: Colour[1, 1, 1, 1],
      outline: Colour[1, 1, 1, 1], thickness: 1
    )
  end

  Then "we track the references" do
    expect(@circle.reference_count).to_equal(0)
    expect(@circle.colour.reference_count).to_equal(1)
    expect(@circle.outline.reference_count).to_equal(1)
    expect(ReferenceCounter.tracked_objects_count).to_equal(2)
  end

  When "we clean up the circle" do
    @circle = nil
    GC.start
  end

  Then "there are no more tracked objects" do
    expect(ReferenceCounter.tracked_objects_count).to_equal(0)
  end
end

@unit.describe "ReferenceCounter Rectangle" do
  Given "we have a rectangle" do
    @rectangle = Rectangle.new(
      x: 2, y: 3, width: 4, height: 5, colour: Colour[6, 7, 8, 9],
      outline: Colour[10, 11, 12, 13], thickness: 14,
      roundness: 0.5, segments: 15
    )
  end

  Then "we track the references" do
    expect(@rectangle.reference_count).to_equal(0)
    expect(@rectangle.colour.reference_count).to_equal(1)
    expect(@rectangle.outline.reference_count).to_equal(1)
    expect(ReferenceCounter.tracked_objects_count).to_equal(2)
  end

  When "we clean up the rectangle" do
    @rectangle = nil
    GC.start
  end

  Then "there are no more tracked objects" do
    expect(ReferenceCounter.tracked_objects_count).to_equal(0)
  end
end

@unit.describe "ReferenceCounter Font" do
  Given "we have a font" do
    @font = Font.new("./assets/tiny.ttf")
  end

  Then "we track the references" do
    expect(@font.reference_count).to_equal(0)
    expect(ReferenceCounter.tracked_objects_count).to_equal(1)
  end

  When "we clean up the font" do
    @font = nil
    GC.start
  end

  Then "there are no more tracked objects" do
    expect(ReferenceCounter.tracked_objects_count).to_equal(0)
  end
end

@unit.describe "ReferenceCounter RenderTexture" do
  Given "we have a render_texture" do
    @render_texture = RenderTexture.new(width: 100, height: 100)
  end

  Then "we track the references" do
    expect(@render_texture.reference_count).to_equal(0)
    expect(ReferenceCounter.tracked_objects_count).to_equal(1)
  end

  When "we clean up the render_texture" do
    @render_texture = nil
    GC.start
  end

  Then "there are no more tracked objects" do
    expect(ReferenceCounter.tracked_objects_count).to_equal(0)
  end
end

@unit.describe "ReferenceCounter Line" do
  Given "we have a line" do
    @line = Line.new(start: Vector2[1, 1], end: Vector2[1, 1], colour: Colour[1, 1, 1, 1])
  end

  Then "we track the references" do
    expect(@line.reference_count).to_equal(0)
    expect(@line.start.reference_count).to_equal(1)
    expect(@line.end.reference_count).to_equal(1)
    expect(@line.colour.reference_count).to_equal(1)
    expect(ReferenceCounter.tracked_objects_count).to_equal(3)
  end

  When "we clean up the line" do
    @line = nil
    GC.start
  end

  Then "there are no more tracked objects" do
    expect(ReferenceCounter.tracked_objects_count).to_equal(0)
  end
end

@unit.describe "ReferenceCounter Camera2D" do
  Given "we have a camera" do
    @camera = Camera2D.new(
      target: Vector2.new(x: 1, y: 1),
      offset: Vector2.new(x: 1, y: 1),
      rotation: 1,
      zoom: 1
    )
  end

  Then "we track the references" do
    expect(@camera.offset.reference_count).to_equal(1)
    expect(@camera.target.reference_count).to_equal(1)
    expect(ReferenceCounter.tracked_objects_count).to_equal(2)
  end

  When "we clean up the camera" do
    @camera = nil
    GC.start
  end

  Then "there are no more tracked objects" do
    expect(ReferenceCounter.tracked_objects_count).to_equal(0)
  end
end

@unit.describe "ReferenceCounter Window" do
  Given "we have a window" do
    Window.minimum_resolution = Vector2[1, 1]
  end

  Then "we track the references" do
    expect(Window.minimum_resolution.reference_count).to_equal(1)
    expect(ReferenceCounter.tracked_objects_count).to_equal(1)
  end

  When "we clean up" do
    Window.close
    GC.start
  end

  Then "there are no more tracked objects" do
    expect(ReferenceCounter.tracked_objects_count).to_equal(0)
  end
end
