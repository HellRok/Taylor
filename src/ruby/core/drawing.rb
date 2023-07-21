def clear(colour: RAYWHITE)
  clear_background(colour)
end

def drawing(&block)
  begin_drawing
  block.call
ensure
  end_drawing
end

def scissor_mode(section, &block)
  begin_scissor_mode(section.x, section.y, section.width, section.height)
  block.call
ensure
  end_scissor_mode
end
