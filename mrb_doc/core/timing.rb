# Returns the amount of time the last frame took in seconds.
# @return [Float]
def get_frame_time
  # mrb_frame_time
  # src/mruby_integration/core/timing.cpp
  0.01633
end

# Returns the amount of time the has passed since {Window.open} was called.
# @return [Float]
def get_time
  # mrb_time
  # src/mruby_integration/core/timing.cpp
  36.345
end
