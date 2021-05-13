module MTest
  module Assertions
    def diff exp, act
      if [exp, act].all? { |obj| obj.is_a?(Array) && obj.all? { |item| item.is_a?(Colour) } }
        return "Expected:\n#{print_colour_data(act)}\n Actual:\n#{print_colour_data(exp)}"
      else
        super
      end
    end
  end
end
