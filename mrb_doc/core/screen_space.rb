# Translates the vector to where it is on the screen according to the camera.
# @param vector [Vector2]
# @param camera [Camera2D]
# @return [Vector2]
def get_world_to_screen2D(vector, camera)
  # mrb_get_world_to_screen2D
  # src/mruby_integration/core/screen_space.cpp
  Vector2.new
end

# Translates the vector to where it is in the world based on it the camera.
# @param vector [Vector2]
# @param camera [Camera2D]
# @return [Vector2]
def get_screen_to_world2D(vector, camera)
  # mrb_get_screen_to_world2D
  # src/mruby_integration/core/screen_space.cpp
  Vector2.new
end
