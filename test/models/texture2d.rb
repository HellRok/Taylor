class TestTexture2D < MTest::Unit::TestCase
  def test_initialize
    texture = Texture2D.new(1, 2, 3, 4, 5)

    assert_kind_of Texture2D, texture
    assert texture.id      == 1
    assert texture.width   == 2
    assert texture.height  == 3
    assert texture.mipmaps == 4
    assert texture.format  == 5
  end

  def test_assignment
    texture = Texture2D.new(0, 0, 0, 0, 0)
    texture.id = 5
    texture.width = 4
    texture.height = 3
    texture.mipmaps = 2
    texture.format  = 1

    assert texture.id      == 5
    assert texture.width   == 4
    assert texture.height  == 3
    assert texture.mipmaps == 2
    assert texture.format  == 1
  end

  def test_to_h
    texture = Texture2D.new(1, 2, 3, 4, 5)

    assert texture.to_h == {
      id: 1,
      width: 2,
      height: 3,
      mipmaps: 4,
      format: 5
    }
  end
end
