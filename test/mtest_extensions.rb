module MTest
  module Assertions
    alias_method :original_diff, :diff
    def diff(exp, act)
      if [exp, act].all? { |obj| obj.is_a?(Array) && obj.all? { |item| item.is_a?(Colour) } }
        # Format big blocks of colour in a reasonable-ish way, I mean we're
        # in a terminal, it can only be so good.
        if exp.length != act.length
          "Expected length: #{exp.length}\n Actual length: #{act.length}"
        elsif exp.all? { |obj| obj == exp.first } && act.all? { |obj| obj == act.first }
          "Expected: #{exp.first.to_h}\n Actual: #{act.first.to_h}"
        else
          "Expected:\n#{colour_data(exp)}\n Actual:\n#{colour_data(act)}"
        end

      elsif [exp, act].all? { |obj| obj.is_a?(Array) && obj.all? { |item| item.is_a?(String) } }
        # When comparing arrays of strings, I find this formatting way more useful,
        # especially since Raylib call checks are now just arrays of strings.
        format_array = lambda { |arr|
          return "[]" if arr.empty?

          "[\n".tap { |result|
            arr.each { result << "    #{mu_pp _1},\n" }
            result << "  ]"
          }
        }

        "\n  Expected: #{format_array.call(exp)}\nGot: #{format_array.call(act)}"

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

    # Checks if the calls were made to Raylib.
    # @param calls [String[]] The expected calls
    # @return [true]
    def assert_called(calls)
      assert_equal calls, Taylor::Raylib.calls
    end

    # Checks if no calls were made to Raylib
    # @return [true]
    def assert_no_calls
      assert_empty Taylor::Raylib.calls
    end

    def assert_raise_with_message(error, message, &block)
      block.call
      flunk "Did not raise any error"
    rescue error => e
      assert_equal message, e.message
    rescue => e
      flunk "Raised '#{e.class}' instead of '#{error}'"
    end
  end
end
