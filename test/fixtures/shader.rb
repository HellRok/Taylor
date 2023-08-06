# Firefox gets very slightly different results, so let's just tweak them

def fixture_load_shader
  100.times.map { Colour.new(0, 148, 219, 255) }
end

def fixture_set_shader_values_float
  100.times.map { BLUE }
end

def fixture_set_shader_values_vec2
  100.times.map { Colour.new(26, 128, 0, 255) }
end

def fixture_set_shader_values_vec3
  100.times.map { Colour.new(26, 128, 191, 255) }
end

def fixture_set_shader_values_vec4
  100.times.map { Colour.new(26, 128, 191, 255) }
end

def fixture_set_shader_values_int
  100.times.map { Colour.new(255, 0, 255, 255) }
end

def fixture_set_shader_values_ivec2
  100.times.map { Colour.new(0, 255, 0, 255) }
end

def fixture_set_shader_values_ivec3
  100.times.map { Colour.new(0, 255, 255, 255) }
end

def fixture_set_shader_values_ivec4
  100.times.map { Colour.new(255, 0, 0, 255) }
end
