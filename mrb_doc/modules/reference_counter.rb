# This class is only used in testing that memory is properly cleaned up in CPP
# after Ruby is done with it.
#
# If you want to use this, I suggest just doing the following to include it in
# every single Object:
#
# ```ruby
# class Object
#   include ReferenceCounter
# end
# ```
class ReferenceCounter
  # How many tracked objects are there?
  #
  # @return [Integer]
  def self.tracked_objects_count
    # mrb_ReferenceCounter_tracked_objects_count
    # src/mruby_integration/modules/struct_types.cpp
    12
  end

  # How many references are there to this Object?
  #
  # @return [Integer]
  def reference_count
    # mrb_ReferenceCounter_reference_count
    # src/mruby_integration/modules/struct_types.cpp
    1
  end
end
