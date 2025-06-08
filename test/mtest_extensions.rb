module MTest
  module Assertions
    alias_method :original_diff, :diff
    def diff(exp, act)
      if [exp, act].all? { |obj| obj.is_a?(Array) && obj.all? { |item| item.is_a?(Colour) } }
        if exp.length != act.length
          "Expected length: #{exp.length}\n Actual length: #{act.length}"
        elsif exp.all? { |obj| obj == exp.first } && act.all? { |obj| obj == act.first }
          "Expected: #{exp.first.to_h}\n Actual: #{act.first.to_h}"
        else
          "Expected:\n#{colour_data(exp)}\n Actual:\n#{colour_data(act)}"
        end
      else
        original_diff(exp, act)
      end
    end

    # Checks if the two arrays of colours are within a certain percentage of
    # each other.
    # @param percent [Number] a value between 0.0 and 100.0
    # @param exp [Array<Colour>]
    # @param act [Array<Colour>]
    # @param msg [String]
    # @return [true]
    def assert_within(percent, exp, act, msg = nil)
      unless exp.size == act.size && [exp, act].all? { |obj|
        obj.is_a?(Array) && obj.all? { |item| item.is_a?(Colour) }
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
