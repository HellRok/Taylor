class Test
  class Models
    class Camera2D_Test < MTest::Unit::TestCaseWithAnalytics
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
        skip_unless_display_present

        set_window_title(__method__.to_s)
        set_target_fps 5
        rectangle = Rectangle.new(2, 2, 6, 6)
        camera = Camera2D.new

        clear_and_draw do
          camera.draw do
            rectangle.draw(colour: Colour::RED)
          end
        end

        assert_equal fixture_camera2d_draw[0], get_screen_data.data
        clear_background(Colour::RAYWHITE)

        camera.offset.x = -2
        camera.offset.y = -2

        clear_and_draw do
          camera.draw do
            draw_rectangle_rec(rectangle, Colour::RED)
          end
        end

        assert_equal fixture_camera2d_draw[1], get_screen_data.data
      end

      def test_as_in_viewport
        camera = Camera2D.new(target: Vector2[2, 1], offset: Vector2[3, 2])
        vector = Vector2[3, 3]

        assert_equal Vector2[4, 4], camera.as_in_viewport(vector)
      end

      def test_as_in_world
        camera = Camera2D.new(target: Vector2[2, 1], offset: Vector2[3, 2])
        vector = Vector2[4, 4]

        assert_equal Vector2[3, 3], camera.as_in_world(vector)
      end
    end
  end
end
