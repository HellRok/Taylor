@unit.describe "Taylor.released?" do
  if ENV["BUILDKITE_BUILD_ID"]
    When "in CI" do
    end

    Then "we are released" do
      expect(Taylor.released?).to_be_true
    end

  else
    Then "return if we are released" do
      expect(Taylor.released?).to_be_in([true, false])
    end
  end
end
