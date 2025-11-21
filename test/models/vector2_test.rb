@unit.describe "Vector2#initialize" do
  When "we initialise a vector" do
    @vector = Vector2.new(x: 1, y: 2)
  end

  Then "it has the correct attributes" do
    expect(@vector).to_be_a(Vector2)
    expect(@vector.x).to_equal(1)
    expect(@vector.y).to_equal(2)
  end
end

@unit.describe "Vector2.[]" do
  When "we get a vector" do
    @vector = Vector2[2, 3]
  end

  Then "it has the correct attributes" do
    expect(@vector).to_be_a(Vector2)
    expect(@vector.x).to_equal(2)
    expect(@vector.y).to_equal(3)
  end
end

@unit.describe "Vector2#==" do
  When "we have two different vectors with the same attributes" do
    @vector = Vector2[3, 4]
    @other_vector = Vector2[3, 4]
  end

  Then "they are considered equal" do
    expect { @vector == @other_vector }.to_be_true
  end

  And "returns false if compared to a different class altogether" do
    expect { @vector == "Hello" }.to_be_false
  end
end

@unit.describe "Vector2#width" do
  Given "we have a vector" do
    @vector = Vector2.new(x: 5, y: 6)
  end

  Then "width returns the x value" do
    expect(@vector.width).to_equal(5)
  end
end

@unit.describe "Vector2#height" do
  Given "we have a vector" do
    @vector = Vector2.new(x: 5, y: 6)
  end

  Then "height returns the y value" do
    expect(@vector.height).to_equal(6)
  end
end

@unit.describe "Vector2#+" do
  Given "we have a vector" do
    @vector = Vector2.new(x: 1, y: 3)
  end

  Then "we can add another Vector2 to it" do
    result = @vector + Vector2.new(x: 2, y: 5)
    expect(result).to_be_a(Vector2)
    expect(result.x).to_equal(3)
    expect(result.y).to_equal(8)
  end

  And "we can add a number to it" do
    result = @vector + 3
    expect(result).to_be_a(Vector2)
    expect(result.x).to_equal(4)
    expect(result.y).to_equal(6)

    result = @vector + 1.5
    expect(result).to_be_a(Vector2)
    expect(result.x).to_equal(2.5)
    expect(result.y).to_equal(4.5)
  end

  But "if we pass something else, raise an error" do
    expect {
      @vector + "hello"
    }.to_raise(ArgumentError, "can only add Numeric and Vector2")
  end
end

@unit.describe "Vector2#-" do
  Given "we have a vector" do
    @vector = Vector2.new(x: 1, y: 3)
  end

  Then "we can subtract another Vector2 from it" do
    result = @vector - Vector2.new(x: 2, y: 5)
    expect(result).to_be_a(Vector2)
    expect(result.x).to_equal(-1)
    expect(result.y).to_equal(-2)
  end

  And "we can subtract a number from it" do
    result = @vector - 3
    expect(result).to_be_a(Vector2)
    expect(result.x).to_equal(-2)
    expect(result.y).to_equal(0)

    result = @vector - 1.5
    expect(result).to_be_a(Vector2)
    expect(result.x).to_equal(-0.5)
    expect(result.y).to_equal(1.5)
  end

  But "if we pass something else, raise an error" do
    expect {
      @vector - "hello"
    }.to_raise(ArgumentError, "can only subtract Numeric and Vector2")
  end
end

@unit.describe "Vector2#*" do
  Given "we have a vector" do
    @vector = Vector2.new(x: 1, y: 3)
  end

  Then "we can multiply it by a number" do
    integer_result = @vector * 3
    expect(integer_result).to_be_a(Vector2)
    expect(integer_result.x).to_equal(3)
    expect(integer_result.y).to_equal(9)

    float_result = @vector * 1.5
    expect(float_result).to_be_a(Vector2)
    expect(float_result.x).to_equal(1.5)
    expect(float_result.y).to_equal(4.5)
  end

  But "if we pass something else, raise an error" do
    expect {
      @vector * "hello"
    }.to_raise(TypeError, "String cannot be converted to Float")
  end
end

@unit.describe "Vector2#/" do
  Given "we have a vector" do
    @vector = Vector2.new(x: 2, y: 4)
  end

  Then "we can divide it by a number" do
    integer_result = @vector / 2
    expect(integer_result).to_be_a(Vector2)
    expect(integer_result.x).to_equal(1)
    expect(integer_result.y).to_equal(2)

    float_result = @vector / 0.5
    expect(float_result).to_be_a(Vector2)
    expect(float_result.x).to_equal(4)
    expect(float_result.y).to_equal(8)
  end

  But "if we pass something else, raise an error" do
    expect {
      @vector / "hello"
    }.to_raise(TypeError, "String cannot be converted to Float")
  end
end

@unit.describe "Vector2#length" do
  Given "we have a vector" do
    @vector = Vector2.new(x: 3, y: -4)
  end

  Then "we can get its length" do
    expect(@vector.length).to_equal(5)
  end
end

@unit.describe "Vector2#to_h" do
  Given "we have a vector" do
    @vector = Vector2.new(x: 3, y: -4)
  end

  Then "return a hash with all its attributes" do
    expect(@vector.to_h).to_equal(
      {
        x: 3,
        y: -4
      }
    )
  end
end

@unit.describe "Vector2#draw" do
  Given "we have a vector" do
    @vector = Vector2[4, 5]
  end

  When "we call draw with a colour" do
    @vector.draw(Colour[6, 7, 8, 9])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawPixelV) { " \
          "position: { " \
            "x: 4.000000 " \
            "y: 5.000000 " \
          "} " \
          "color: { " \
            "r: 6 " \
            "g: 7 " \
            "b: 8 " \
            "a: 9 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Vector2#inspect" do
  Given "we have a vector" do
    @vector = Vector2[3, 4]
  end

  Then "inspect returns all the info" do
    expect(@vector.inspect).to_equal(
      "#<Vector2:0x#{@vector.object_id.to_s(16)} x:3.0 y:4.0>"
    )
  end
end

@unit.describe "Vector2#overlaps?" do
  Given "we have a rectangle and a vector" do
    @vector = Vector2.new(x: 0, y: 0)
    @rectangle = Rectangle.new(x: 3, y: 4, width: 2, height: 3)
  end

  Then "it's outside so we return false" do
    expect(@vector.overlaps?(@rectangle)).to_be_false
  end

  When "the vector is inside the rectangle" do
    @vector.x = 4
    @vector.y = 6
  end

  Then "it's inside so we return true" do
    expect(@vector.overlaps?(@rectangle)).to_be_true
  end

  When "the vector is on the top edge" do
    @vector.x = 3
    @vector.y = 6
  end

  Then "it's considered inside so we return true" do
    expect(@vector.overlaps?(@rectangle)).to_be_true
  end

  When "the vector is on the bottom edge" do
    @vector.x = 5
    @vector.y = 6
  end

  Then "it's considered inside so we return true" do
    expect(@vector.overlaps?(@rectangle)).to_be_true
  end

  When "the vector is on the left edge" do
    @vector.x = 4
    @vector.y = 4
  end

  Then "it's considered inside so we return true" do
    expect(@vector.overlaps?(@rectangle)).to_be_true
  end

  When "the vector is on the bottom edge" do
    @vector.x = 4
    @vector.y = 7
  end

  Then "it's considered inside so we return true" do
    expect(@vector.overlaps?(@rectangle)).to_be_true
  end

  When "the vector is further out than the rectangle" do
    @vector.x = 10
    @vector.y = 10
  end

  Then "it's not inside so we return false" do
    expect(@vector.overlaps?(@rectangle)).to_be_false
  end

  When "passed in something that doesn't respond to #overlaps? we raise an error" do
    expect {
      @vector.overlaps?("string")
    }.to_raise(ArgumentError, "Must respond to #overlaps?")
  end

  And "cleanup" do
    @rectangle = nil
    @vector = nil
  end
end
