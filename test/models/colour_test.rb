@unit.describe "Colour#initialize" do
  When "we make a colour" do
    @colour = Colour.new
  end

  Then "it has the correct values" do
    expect(@colour).to_be_a(Colour)
    expect(@colour.red).to_equal(0)
    expect(@colour.green).to_equal(0)
    expect(@colour.blue).to_equal(0)
    expect(@colour.alpha).to_equal(255)
  end

  When "we make a colour with all the arguments" do
    @colour = Colour.new(red: 1, green: 2, blue: 3, alpha: 4)
  end

  Then "it has the correct values" do
    expect(@colour).to_be_a(Colour)
    expect(@colour.red).to_equal(1)
    expect(@colour.green).to_equal(2)
    expect(@colour.blue).to_equal(3)
    expect(@colour.alpha).to_equal(4)
  end

  When "assigned new values" do
    @colour.red = 4
    @colour.green = 3
    @colour.blue = 2
    @colour.alpha = 1
  end

  Then "they are updated" do
    expect(@colour.red).to_equal(4)
    expect(@colour.green).to_equal(3)
    expect(@colour.blue).to_equal(2)
    expect(@colour.alpha).to_equal(1)
  end
end

@unit.describe "Colour.[]" do
  When "we make a colour" do
    @colour = Colour[]
  end

  Then "it has the correct values" do
    expect(@colour).to_be_a(Colour)
    expect(@colour.red).to_equal(0)
    expect(@colour.green).to_equal(0)
    expect(@colour.blue).to_equal(0)
    expect(@colour.alpha).to_equal(255)
  end

  When "we make a colour with all the arguments" do
    @colour = Colour[1, 2, 3, 4]
  end

  Then "it has the correct values" do
    expect(@colour).to_be_a(Colour)
    expect(@colour.red).to_equal(1)
    expect(@colour.green).to_equal(2)
    expect(@colour.blue).to_equal(3)
    expect(@colour.alpha).to_equal(4)
  end
end

@unit.describe "Colour#==" do
  Given "we have a colour that matches Colour::RAYWHITE" do
    @colour = Colour.new(red: 245, green: 245, blue: 245, alpha: 255)
  end

  Then "return true based on value comparison" do
    expect(@colour == Colour::RAYWHITE).to_be_true
  end

  But "return false if compared to a different value" do
    expect(@colour == Colour::GREEN).to_be_false
  end

  And "return false if compared to a different class" do
    expect(@colour == Vector2[0, 0]).to_be_false
  end
end

@unit.describe "Colour#to_h" do
  Given "we have a colour" do
    @colour = Colour.new(red: 3, green: 4, blue: 5, alpha: 6)
  end

  Then "return a hash with all the values" do
    expect(@colour.to_h).to_equal(
      {
        red: 3,
        green: 4,
        blue: 5,
        alpha: 6
      }
    )
  end
end

@unit.describe "Colour#fade" do
  Given "we have a colour" do
    Taylor::Raylib.mock_call("Fade", Colour.mock_return(red: 255, green: 255, blue: 255, alpha: 127))
    @colour = Colour.new(red: 255, green: 255, blue: 255, alpha: 255)
  end

  When "we fade the colour" do
    @faded_colour = @colour.fade(0.5)
  end

  Then "we have updated our values" do
    expect(@faded_colour.red).to_equal(255)
    expect(@faded_colour.green).to_equal(255)
    expect(@faded_colour.blue).to_equal(255)
    expect(@faded_colour.alpha).to_equal(127)
  end

  And "we have not updated our original values" do
    expect(@colour.red).to_equal(255)
    expect(@colour.green).to_equal(255)
    expect(@colour.blue).to_equal(255)
    expect(@colour.alpha).to_equal(255)
  end

  And "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(Fade) { color: { r: 255 g: 255 b: 255 a: 255 } alpha: 0.500000 }"
      ]
    )
  end

  But "when called with a negative fade" do
    expect {
      @colour.fade(-0.1)
    }.to_raise(ArgumentError, "Alpha must be within (0.0..1.0)")
  end

  Or "when called with a fade above 1" do
    expect {
      @colour.fade(1.1)
    }.to_raise(ArgumentError, "Alpha must be within (0.0..1.0)")
  end
end

@unit.describe "Colour#fade!" do
  Given "we have a colour" do
    Taylor::Raylib.mock_call("Fade", Colour.mock_return(red: 255, green: 255, blue: 255, alpha: 127))
    @colour = Colour.new(red: 255, green: 255, blue: 255, alpha: 255)
  end

  When "we fade! the colour" do
    @colour.fade!(0.5)
  end

  Then "we have updated our values" do
    expect(@colour.red).to_equal(255)
    expect(@colour.green).to_equal(255)
    expect(@colour.blue).to_equal(255)
    expect(@colour.alpha).to_equal(127)
  end

  And "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(Fade) { color: { r: 255 g: 255 b: 255 a: 255 } alpha: 0.500000 }"
      ]
    )
  end

  But "when called with a negative fade" do
    expect {
      @colour.fade!(-0.1)
    }.to_raise(ArgumentError, "Alpha must be within (0.0..1.0)")
  end

  Or "when called with a fade above 1" do
    expect {
      @colour.fade!(1.1)
    }.to_raise(ArgumentError, "Alpha must be within (0.0..1.0)")
  end
end
