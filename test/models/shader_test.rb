@unit.describe "Shader#initialize" do
  When "we initalise a new shader" do
    Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 1))
    @shader = Shader.new(fragment: "fragment.shader", vertex: "vertex.shader")
  end

  Then "it has the expected attributes" do
    expect(@shader).to_be_a(Shader)
    expect(@shader.id).to_equal(1)
  end

  When "initialised with only a fragment shader" do
    Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 2))
    @fragment_shader = Shader.new(fragment: "fragment.shader")
  end

  Then "it has the expected attributes" do
    expect(@fragment_shader).to_be_a(Shader)
    expect(@fragment_shader.id).to_equal(2)
  end

  When "initialised with only a vertex shader" do
    Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 3))
    @vertex_shader = Shader.new(vertex: "vertex.shader")
  end

  Then "it has the expected attributes" do
    expect(@vertex_shader).to_be_a(Shader)
    expect(@vertex_shader.id).to_equal(3)
  end

  Given "it can't find the fragment shader" do
    Taylor::Raylib.mock_call("FileExists", "false")
  end

  Then "raise an error" do
    expect {
      Shader.new(fragment: "./assets/fragment.fs")
    }.to_raise(Shader::NotFoundError, "Unable to find './assets/fragment.fs'")
  end

  Given "it can't find the vertex shader" do
    Taylor::Raylib.mock_call("FileExists", "false")
  end

  Then "raise an error" do
    expect {
      Shader.new(vertex: "./assets/vertex.vs")
    }.to_raise(Shader::NotFoundError, "Unable to find './assets/vertex.vs'")
  end

  Given "it can't find either shader" do
    Taylor::Raylib.mock_call("FileExists", "false")
    Taylor::Raylib.mock_call("FileExists", "false")
  end

  Then "raise an error" do
    expect {
      Shader.new(fragment: "./assets/fragment.fs", vertex: "./assets/vertex.vs")
    }.to_raise(
      Shader::NotFoundError,
      "Unable to find './assets/fragment.fs' and './assets/vertex.vs'"
    )
  end
end

@unit.describe "Shader#unload" do
  Given "we have a shader" do
    Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 4))
    @shader = Shader.new(vertex: "vertex.shader")
    Taylor::Raylib.reset_calls
  end

  When "we call unload" do
    @shader.unload
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(UnloadShader) { shader: { id: 4 } }"
      ]
    )
  end
end

@unit.describe "Shader.load_code" do
  When "we load code for both fragment and vertex shaders" do
    Taylor::Raylib.mock_call("LoadShaderFromMemory", Shader.mock_return(id: 5))
    @shader = Shader.load_code(fragment: "fragment shader code", vertex: "vertex shader code")
  end

  Then "it has the expected attributes" do
    expect(@shader).to_be_a(Shader)
    expect(@shader.id).to_equal(5)
  end

  When "load only a fragment shader" do
    Taylor::Raylib.mock_call("LoadShaderFromMemory", Shader.mock_return(id: 6))
    @fragment_shader = Shader.load_code(fragment: "fragment shader code")
  end

  Then "it has the expected attributes" do
    expect(@fragment_shader).to_be_a(Shader)
    expect(@fragment_shader.id).to_equal(6)
  end

  When "initialised with only a vertex shader" do
    Taylor::Raylib.mock_call("LoadShaderFromMemory", Shader.mock_return(id: 7))
    @vertex_shader = Shader.load_code(vertex: "vertex shader code")
  end

  Then "it has the expected attributes" do
    expect(@vertex_shader).to_be_a(Shader)
    expect(@vertex_shader.id).to_equal(7)
  end
end

@unit.describe "Shader#valid?" do
  When "we have an invalid shader" do
    Taylor::Raylib.mock_call("IsShaderValid", "false")
    @shader = Shader.new
  end

  Then "return false" do
    expect(@shader.valid?).to_be_false
  end

  When "we have an valid shader" do
    Taylor::Raylib.mock_call("IsShaderValid", "true")
  end

  Then "return true" do
    expect(@shader.valid?).to_be_true
  end
end

@unit.describe "Shader#location_of" do
  Given "we have a shader" do
    @shader = Shader.new
  end

  When "we call location_of with a variable that doesn't exist" do
    Taylor::Raylib.mock_call("GetShaderLocation", "-1")
  end

  Then "it returns nil" do
    expect(@shader.location_of("non_existant")).to_be_nil
  end

  When "we call location_of with a variable that does exist" do
    Taylor::Raylib.mock_call("GetShaderLocation", "3")
  end

  Then "it returns the location" do
    expect(@shader.location_of("red")).to_equal(3)
  end
end

@unit.describe "Shader#set" do
  Given "we have a shader" do
    Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 10))
    @shader = Shader.new(fragment: "fragment shader path")
    Taylor::Raylib.reset_calls
  end

  When "setting by location" do
    @shader.set(
      location: 1,
      value: 0.4745
    )
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 1 value: ???  uniformType: 0 count: 1 }"
      ]
    )
  end

  When "setting by variable" do
    Taylor::Raylib.mock_call("GetShaderLocation", "2")
    @shader.set(
      variable: "green",
      value: 1
    )
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(GetShaderLocation) { shader: { id: 10 } uniformName: 'green' }",
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 2 value: ???  uniformType: 4 count: 1 }"
      ]
    )
  end

  But "when setting both location and variable, raise an error" do
    expect {
      @shader.set(
        location: 1,
        variable: "green",
        value: 0.4745
      )
    }.to_raise(ArgumentError, "Can't pass both 'location' and 'variable'")
  end

  Or "when passing their location nor variable" do
    expect {
      @shader.set(value: 0.0)
    }.to_raise(ArgumentError, "Must pass either 'location' or 'variable'")
  end

  When "passing a single float to value" do
    @shader.set(location: 1, value: 0.0)
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 1 value: ???  uniformType: 0 count: 1 }"
      ]
    )
  end

  When "passing an array with two floats to value" do
    @shader.set(location: 2, value: [0.1, 0.2])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 2 value: ???  uniformType: 1 count: 1 }"
      ]
    )
  end

  When "passing an array with three floats to value" do
    @shader.set(location: 3, value: [0.3, 0.4, 0.5])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 3 value: ???  uniformType: 2 count: 1 }"
      ]
    )
  end

  When "passing an array with four floats to value" do
    @shader.set(location: 4, value: [0.6, 0.7, 0.8, 0.9])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 4 value: ???  uniformType: 3 count: 1 }"
      ]
    )
  end

  When "passing a single integer to value" do
    @shader.set(location: 5, value: 1)
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 5 value: ???  uniformType: 4 count: 1 }"
      ]
    )
  end

  When "passing an array with two integers to value" do
    @shader.set(location: 6, value: [2, 3])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 6 value: ???  uniformType: 5 count: 1 }"
      ]
    )
  end

  When "passing an array with three integers to value" do
    @shader.set(location: 7, value: [4, 5, 6])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 7 value: ???  uniformType: 6 count: 1 }"
      ]
    )
  end

  When "passing an array with four integers to value" do
    @shader.set(location: 8, value: [7, 8, 9, 10])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 8 value: ???  uniformType: 7 count: 1 }"
      ]
    )
  end

  When "passing an array of single float to values" do
    @shader.set(location: 9, values: [0.0, 0.1])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 9 value: ???  uniformType: 0 count: 2 }"
      ]
    )
  end

  When "passing an array of array with two floats to values" do
    @shader.set(location: 10, values: [[0.1, 0.2], [0.3, 0.4]])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 10 value: ???  uniformType: 1 count: 2 }"
      ]
    )
  end

  When "passing an array of array with three floats to values" do
    @shader.set(location: 11, values: [[0.3, 0.4, 0.5], [0.6, 0.7, 0.8]])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 11 value: ???  uniformType: 2 count: 2 }"
      ]
    )
  end

  When "passing an array of array with four floats to values" do
    @shader.set(location: 12, values: [[0.6, 0.7, 0.8, 0.9], [0.10, 0.11, 0.12, 0.13]])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 12 value: ???  uniformType: 3 count: 2 }"
      ]
    )
  end

  When "passing an array of single integer to values" do
    @shader.set(location: 13, values: [1, 2])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 13 value: ???  uniformType: 4 count: 2 }"
      ]
    )
  end

  When "passing an array of array with two integers to values" do
    @shader.set(location: 14, values: [[2, 3], [4, 5]])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 14 value: ???  uniformType: 5 count: 2 }"
      ]
    )
  end

  When "passing an array of array with three integers to values" do
    @shader.set(location: 15, values: [[4, 5, 6], [7, 8, 9]])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 15 value: ???  uniformType: 6 count: 2 }"
      ]
    )
  end

  When "passing an array of array with four integers to values" do
    @shader.set(location: 16, values: [[7, 8, 9, 10], [11, 12, 13, 14]])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 16 value: ???  uniformType: 7 count: 2 }"
      ]
    )
  end

  When "passing in a hundred values" do
    @shader.set(location: 15, values: [[1, 2]] * 100)
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetShaderValueV) { shader: { id: 10 } locIndex: 15 value: ???  uniformType: 5 count: 100 }"
      ]
    )
  end

  But "when passing in both value and values, raise an error" do
    expect {
      @shader.set(
        location: 1,
        value: 0.4745,
        values: [1, 2]
      )
    }.to_raise(ArgumentError, "Can't pass both 'value' and 'values'")
  end

  Or "When passing in neither value nor values" do
    expect {
      @shader.set(location: 1)
    }.to_raise(ArgumentError, "Must pass either 'value' or 'values'")
  end

  Or "when passing more than 4 floats in an array to values" do
    expect {
      @shader.set(
        location: 1,
        values: [[1.0, 1.0, 1.0, 1.0, 1.0]]
      )
    }.to_raise(ArgumentError, "Passed 5 floats, you must pass no more than 4")
  end

  Or "when passing more than 4 floats to value" do
    expect {
      @shader.set(
        location: 1,
        value: [1.0, 1.0, 1.0, 1.0, 1.0]
      )
    }.to_raise(ArgumentError, "Passed 5 floats, you must pass no more than 4")
  end

  Or "when passing an array with a single float to values" do
    expect {
      @shader.set(
        location: 1,
        values: [[1.0]]
      )
    }.to_raise(ArgumentError, "Passed 1 floats, you must pass at least 2")
  end

  Or "when passing an array with a single float to value" do
    expect {
      @shader.set(
        location: 1,
        value: [1.0]
      )
    }.to_raise(ArgumentError, "Passed 1 floats, you must pass at least 2")
  end

  Or "when passing more than 4 integers in an array to values" do
    expect {
      @shader.set(
        location: 1,
        values: [[1, 1, 1, 1, 1]]
      )
    }.to_raise(ArgumentError, "Passed 5 integers, you must pass no more than 4")
  end

  Or "when passing more than 4 integers to value" do
    expect {
      @shader.set(
        location: 1,
        value: [1, 1, 1, 1, 1]
      )
    }.to_raise(ArgumentError, "Passed 5 integers, you must pass no more than 4")
  end

  Or "when passing an array with a single integer to values" do
    expect {
      @shader.set(
        location: 1,
        values: [[1]]
      )
    }.to_raise(ArgumentError, "Passed 1 integers, you must pass at least 2")
  end

  Or "when passing an array with a single integer to value" do
    expect {
      @shader.set(
        location: 1,
        value: [1]
      )
    }.to_raise(ArgumentError, "Passed 1 integers, you must pass at least 2")
  end

  Or "when passing variable length arrays of floats to values" do
    expect {
      @shader.set(
        location: 1,
        values: [
          [1.0, 1.0],
          [1.0, 1.0, 1.0]
        ]
      )
    }.to_raise(ArgumentError, "All arrays must be the same length")

    expect {
      @shader.set(
        location: 1,
        values: [
          [1.0, 1.0, 1.0],
          [1.0, 1.0]
        ]
      )
    }.to_raise(ArgumentError, "All arrays must be the same length")
  end

  Or "when passing variable length arrays of integers to values" do
    expect {
      @shader.set(
        location: 1,
        values: [
          [1, 1],
          [1, 1, 1]
        ]
      )
    }.to_raise(ArgumentError, "All arrays must be the same length")

    expect {
      @shader.set(
        location: 1,
        values: [
          [1, 1, 1],
          [1, 1]
        ]
      )
    }.to_raise(ArgumentError, "All arrays must be the same length")
  end

  Or "when passing both integers and floats to values" do
    expect {
      @shader.set(
        location: 1,
        values: [
          [1.0, 1.0],
          [1.0, 1]
        ]
      )
    }.to_raise(ArgumentError, "Must be all integers or all floats")

    expect {
      @shader.set(
        location: 1,
        values: [
          [1, 1.0],
          [1.0, 1.0]
        ]
      )
    }.to_raise(ArgumentError, "Must be all integers or all floats")

    expect {
      @shader.set(
        location: 1,
        values: [
          [1, 1],
          [1.0, 1.0]
        ]
      )
    }.to_raise(ArgumentError, "Must be all integers or all floats")
  end

  Or "when passing mixed unsupported types" do
    expect {
      @shader.set(
        location: 1,
        values: [
          [1, 1],
          1.0
        ]
      )
    }.to_raise(ArgumentError, "Must be all integers or all floats")

    expect {
      @shader.set(
        location: 1,
        values: [
          [1, "green"]
        ]
      )
    }.to_raise(ArgumentError, "Must be all integers or all floats")

    expect {
      @shader.set(
        location: 1,
        values: [
          [1.0, "green"]
        ]
      )
    }.to_raise(ArgumentError, "Must be all integers or all floats")
  end

  Or "When passing the wrong type to values" do
    expect {
      @shader.set(
        location: 1,
        values: "green"
      )
    }.to_raise(ArgumentError, "Values must be an Array")
  end

  Or "When passing the wrong type to value" do
    expect {
      @shader.set(
        location: 1,
        value: "green"
      )
    }.to_raise(ArgumentError, "Value must be either an Integer, Float, or Array")
  end

  Or "when passing in a non-existant variable" do
    Taylor::Raylib.mock_call("GetShaderLocation", "-1")

    expect {
      @shader.set(
        variable: "non-existant",
        value: 0.4745
      )
    }.to_raise(ArgumentError, "Couldn't locate variable 'non-existant'")
  end
end

@unit.describe "Shader#begin_drawing" do
  Given "we have a shader" do
    Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 16))
    @shader = Shader.new(fragment: "fragment shader path")
    Taylor::Raylib.reset_calls
  end

  When "we call begin_drawing" do
    @shader.begin_drawing
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(BeginShaderMode) { shader: { id: 16 } }"
      ]
    )
  end
end

@unit.describe "Shader#end_drawing" do
  Given "we have a shader" do
    @shader = Shader.new(fragment: "fragment shader path")
    Taylor::Raylib.reset_calls
  end

  When "we call end_drawing" do
    @shader.end_drawing
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(EndShaderMode) { }"
      ]
    )
  end
end

@unit.describe "Shader#draw" do
  Given "we have a shader" do
    Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 14))
    @shader = Shader.new(fragment: "fragment shader path")
    Taylor::Raylib.reset_calls
  end

  When "we call draw" do
    @shader.draw do
      Window.clear(colour: Colour[1, 0, 0, 0])
    end
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(BeginShaderMode) { shader: { id: 14 } }",
        "(IsWindowReady) { }",
        "(ClearBackground) { color: { r: 1 g: 0 b: 0 a: 0 } }",
        "(EndShaderMode) { }"
      ]
    )
  end

  But "if an error occurs in the block" do
    @shader.draw do
      Window.clear(colour: Colour[2, 0, 0, 0])
      raise StandardError, "Oops!"
      Window.clear(colour: Colour[3, 0, 0, 0]) # standard:disable Lint/UnreachableCode
    end
  rescue => error
    expect(error.message).to_equal("Oops!")
  end

  Then "we still call end_drawing" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(BeginShaderMode) { shader: { id: 14 } }",
        "(IsWindowReady) { }",
        "(ClearBackground) { color: { r: 2 g: 0 b: 0 a: 0 } }",
        "(EndShaderMode) { }"
      ]
    )
  end
end
