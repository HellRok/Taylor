class Object
  include ReferenceCounter
end

# standard:disable Lint/UselessAssignment
class Test
  class ReferenceCounter_Test < Test::Base
    def test_core_count
      GC.start

      string = "hello"

      assert_equal 0, string.reference_count
      assert_equal 0, ReferenceCounter.tracked_objects_count
    end

    def test_reference_count_for_many_assignments
      GC.start

      colour = Colour[1, 1, 1, 1]
      circle = Circle.new(x: 1, y: 1, radius: 1, colour: colour)

      assert_equal 0, circle.reference_count
      assert_equal 1, colour.reference_count
      assert_equal 1, ReferenceCounter.tracked_objects_count

      circle = nil
      GC.start

      assert_equal 0, colour.reference_count
      assert_equal 0, ReferenceCounter.tracked_objects_count

      circles = 10.times.map { Circle.new(x: 1, y: 1, radius: 1, colour: colour) }

      assert_equal 10, colour.reference_count
      assert_equal 1, ReferenceCounter.tracked_objects_count

      circles = nil
      GC.start

      assert_equal 0, colour.reference_count
      assert_equal 0, ReferenceCounter.tracked_objects_count
    end

    def test_Circle_reference_count
      GC.start

      circle = Circle.new(
        x: 1, y: 1, radius: 1, colour: Colour[1, 1, 1, 1],
        outline: Colour[1, 1, 1, 1], thickness: 1
      )

      assert_equal 0, circle.reference_count
      assert_equal 1, circle.colour.reference_count
      assert_equal 1, circle.outline.reference_count
      assert_equal 2, ReferenceCounter.tracked_objects_count

      circle = nil
      GC.start

      assert_equal 0, ReferenceCounter.tracked_objects_count
    end

    def test_Rectangle_reference_count
      GC.start

      rectangle = Rectangle.new(
        x: 2, y: 3, width: 4, height: 5, colour: Colour[6, 7, 8, 9],
        outline: Colour[10, 11, 12, 13], thickness: 14,
        roundness: 0.5, segments: 15
      )

      assert_equal 0, rectangle.reference_count
      assert_equal 1, rectangle.colour.reference_count
      assert_equal 1, rectangle.outline.reference_count
      assert_equal 2, ReferenceCounter.tracked_objects_count

      rectangle = nil
      GC.start

      assert_equal 0, ReferenceCounter.tracked_objects_count
    end

    def test_Font_reference_count
      GC.start

      font = Font.new("./assets/tiny.ttf")

      assert_equal 0, font.reference_count
      assert_equal 1, ReferenceCounter.tracked_objects_count

      font = nil
      GC.start

      assert_equal 0, ReferenceCounter.tracked_objects_count
    end

    def test_RenderTexture_reference_count
      GC.start

      render_texture = RenderTexture.new(100, 100)

      assert_equal 0, render_texture.reference_count
      assert_equal 1, ReferenceCounter.tracked_objects_count

      render_texture = nil
      GC.start

      assert_equal 0, ReferenceCounter.tracked_objects_count
    end

    def test_Line_reference_count
      GC.start

      line = Line.new(start: Vector2[1, 1], end: Vector2[1, 1], colour: Colour[1, 1, 1, 1])

      assert_equal 0, line.reference_count
      assert_equal 1, line.start.reference_count
      assert_equal 1, line.end.reference_count
      assert_equal 1, line.colour.reference_count
      assert_equal 3, ReferenceCounter.tracked_objects_count

      line = nil
      GC.start

      assert_equal 0, ReferenceCounter.tracked_objects_count
    end

    def test_Camera2D_reference_count
      GC.start

      camera = Camera2D.new(
        target: Vector2.new(1, 1),
        offset: Vector2.new(1, 1),
        rotation: 1,
        zoom: 1
      )

      assert_equal 1, camera.offset.reference_count
      assert_equal 1, camera.target.reference_count
      assert_equal 2, ReferenceCounter.tracked_objects_count

      camera = nil
      GC.start

      assert_equal 0, ReferenceCounter.tracked_objects_count
    end

    def test_Window_reference_count
      GC.start

      Window.minimum_resolution = Vector2[1, 1]

      assert_equal 1, Window.minimum_resolution.reference_count
      assert_equal 1, ReferenceCounter.tracked_objects_count
    end
  end
end
# standard:enable Lint/UselessAssignment
