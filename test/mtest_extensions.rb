module MTest
  module Assertions
    def diff exp, act
      if [exp, act].all? { |obj| obj.is_a?(Array) && obj.all? { |item| item.is_a?(Colour) } }
        return "Expected:\n#{print_colour_data(exp)}\n Actual:\n#{print_colour_data(act)}"
      else
        super
      end
    end
  end
end
