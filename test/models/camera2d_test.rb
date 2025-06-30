class Test
  class Models
    class Camera2D_Test < Test::Base
      def test_initialize
        camera = Camera2D.new(
          target: Vector2.new(1, 2),
          offset: Vector2.new(3, 4),
          rotation: 5,
          zoom: 6
        )

        assert_kind_of Camera2D, camera
        assert_equal 1, camera.target.x
        assert_equal 2, camera.target.y
        assert_equal 3, camera.offset.x
        assert_equal 4, camera.offset.y
        assert_equal 5, camera.rotation
        assert_equal 6, camera.zoom
      end

      def test_initialize_with_defaults
        camera = Camera2D.new

        assert_kind_of Camera2D, camera
        assert_equal 0, camera.offset.x
        assert_equal 0, camera.offset.y
        assert_equal 0, camera.target.x
        assert_equal 0, camera.target.y
        assert_equal 0, camera.rotation
        assert_equal 1, camera.zoom
      end

      def test_assignment
        camera = Camera2D.new(
          offset: Vector2.new(0, 0),
          target: Vector2.new(0, 0),
          rotation: 0,
          zoom: 0
        )

        camera.target.x = 6
        camera.target.y = 5
        camera.offset.x = 4
        camera.offset.y = 3
        camera.rotation = 2
        camera.zoom = 1

        assert_equal 6, camera.target.x
        assert_equal 5, camera.target.y
        assert_equal 4, camera.offset.x
        assert_equal 3, camera.offset.y
        assert_equal 2, camera.rotation
        assert_equal 1, camera.zoom
      end

      def test_offset
        offset = Vector2[0, 0]
        camera = Camera2D.new(
          offset: offset,
          target: Vector2.new(0, 0),
          rotation: 0,
          zoom: 0
        )

        assert_equal offset, camera.offset
        assert_not_equal offset.object_id, camera.offset.object_id
      end

      def test_target
        target = Vector2[0, 0]
        camera = Camera2D.new(
          offset: Vector2.new(0, 0),
          target: target,
          rotation: 0,
          zoom: 0
        )

        assert_equal target, camera.target
        assert_not_equal target.object_id, camera.target.object_id
      end

      def test_to_h
        camera = Camera2D.new(
          target: Vector2.new(1, 2),
          offset: Vector2.new(3, 4),
          rotation: 5,
          zoom: 6
        )

        assert_equal(
          {
            target: {
              x: 1,
              y: 2
            },
            offset: {
              x: 3,
              y: 4
            },
            rotation: 5,
            zoom: 6
          },
          camera.to_h
        )
      end

      def test_draw
        rectangle = Rectangle[2, 2, 6, 6, Colour::RED]
        camera = Camera2D.new

        camera.draw do
          rectangle.draw
        end

        assert_called [
          "(BeginMode2D) { camera: { offset.x: 0.000000 offset.y: 0.000000 target.x: 0.000000 target.y: 0.000000 rotation: 0.000000 zoom: 1.000000 } }",
          "(DrawRectangleRec) { rec: { x: 2.000000 y: 2.000000 width: 6.000000 height: 6.000000 } color: { r: 230 g: 41 b: 55 a: 255 } }",
          "(EndMode2D) { }"
        ]

        Taylor::Raylib.reset_calls

        camera.offset.x = -2
        camera.offset.y = -3

        camera.draw do
          rectangle.draw
        end

        assert_called [
          "(BeginMode2D) { camera: { offset.x: -2.000000 offset.y: -3.000000 target.x: 0.000000 target.y: 0.000000 rotation: 0.000000 zoom: 1.000000 } }",
          "(DrawRectangleRec) { rec: { x: 2.000000 y: 2.000000 width: 6.000000 height: 6.000000 } color: { r: 230 g: 41 b: 55 a: 255 } }",
          "(EndMode2D) { }"
        ]
      end

      def test_as_in_viewport
        camera = Camera2D.new(target: Vector2[2, 1], offset: Vector2[3, 2])
        vector = Vector2[3, 3]

        camera.as_in_viewport(vector)

        assert_called [
          "(GetWorldToScreen2D) { position: { x: 3.000000 y: 3.000000 } camera: { offset.x: 3.000000 offset.y: 2.000000 target.x: 2.000000 target.y: 1.000000 rotation: 0.000000 zoom: 1.000000 } }"
        ]
      end

      def test_as_in_world
        camera = Camera2D.new(target: Vector2[2, 1], offset: Vector2[3, 2])
        vector = Vector2[4, 4]

        camera.as_in_world(vector)

        assert_called [
          "(GetScreenToWorld2D) { position: { x: 4.000000 y: 4.000000 } camera: { offset.x: 3.000000 offset.y: 2.000000 target.x: 2.000000 target.y: 1.000000 rotation: 0.000000 zoom: 1.000000 } }"
        ]
      end
    end
  end
end
