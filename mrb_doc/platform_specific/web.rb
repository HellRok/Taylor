# Gets the attribute from the specified element. If it's a data attribute you
# can just pass 'data-blah'
# @param selector [String]
# @param attribute [String]
# @return [String]
def get_attribute_from_element(selector, attribute)
  # mrb_get_attribute_from_element
  # src/platform_specific/web.cpp
  'Hi!'
end

# A class for interacting with the browser's LocalStorage
class LocalStorage
  # Returns the value stored in localStorage in the browser, if it doesn't exist
  # it will just return an empty string
  # @param key [String]
  # @return [String]
  def get_item(key)
    # mrb_local_storage_get_item
    # src/platform_specific/web.cpp
    'Hi!'
  end

  # Sets the value in localStorage in the browser
  # @param key [String]
  # @param value [String]
  # @return [nil]
  def set_item(key, value)
    # mrb_local_storage_set_item
    # src/platform_specific/web.cpp
    nil
  end
end
