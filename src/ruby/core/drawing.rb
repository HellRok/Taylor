# Clear the screen with the specified colour
# @param colour [Colour]
# @return [nil]
def clear(colour: Colour::RAYWHITE)
  clear_background(colour)
end

# Allows you to call rendering functions within the block
# @yield The block that calls your rendering logic
# @return [nil]
def drawing(&block)
  begin_drawing
  block.call
ensure
  end_drawing
end

# Allows you to call rendering functions within the block but limits the output
# to within the bounds of `section`
# @yield The block that calls your rendering logic
# @param section [Rectangle]
# @return [nil]
def scissor_mode(section, &block)
  begin_scissor_mode(section.x, section.y, section.width, section.height)
  block.call
ensure
  end_scissor_mode
end
