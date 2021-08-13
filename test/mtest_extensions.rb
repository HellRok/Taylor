module MTest
  module Assertions
    def diff exp, act
      if [exp, act].all? { |obj| obj.is_a?(Array) && obj.all? { |item| item.is_a?(Colour) } }
        return "Expected:\n#{print_colour_data(exp)}\n Actual:\n#{print_colour_data(act)}"
      else
        super
      end
    end

    # Checks if the two arrays of colours are within a certain percantage of
    # each other.
    # @param percent [Number] a value between 0.0 and 100.0
    # @param exp [Array<Colour>]
    # @param act [Array<Colour>]
    # @param msg [String]
    # @return [true]
    def assert_within(percent, exp, act, msg = nil)
      unless exp.size == act.size && [exp, act].all? {
          |obj| obj.is_a?(Array) && obj.all? { |item| item.is_a?(Colour) }
      }
        raise ArgumentError, "Must be passed two arrays of Colour of equal size"
      end

      difference = exp.size.times.map { |i|
        left = exp[i]
        right = act[i]

        (
          (left.red - right.red).abs +
          (left.green - right.green).abs +
          (left.blue - right.blue).abs +
          (left.alpha - right.alpha).abs
        ) / 4.0 / 255.0
      }.inject(&:+) / exp.size

      actual_percent = 100 - (difference * 100)

      assert_operator percent, :<=, actual_percent, msg
    end
  end
end
