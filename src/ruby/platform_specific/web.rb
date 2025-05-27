# Gets the attribute from the specified element. If it's a data attribute you
# can just pass 'data-blah'.
# @param selector [String]
# @param attribute [String]
# @return [String]
# @raise [Taylor::Platform::MethodCalledOnInvalidPlatformError] If run on non-web platforms.
def get_attribute_from_element(selector, attribute)
  raise Taylor::Platform::MethodCalledOnInvalidPlatformError, "get_attribute_from_element is only available for Web exports"
end

# A class for interacting with the browser's LocalStorage.
class LocalStorage
  # Returns the value stored in localStorage in the browser, if it doesn't exist
  # it will just return an empty string.
  # @param key [String]
  # @return [String]
  # @raise [Taylor::Platform::MethodCalledOnInvalidPlatformError] If run on non-web platforms.
  def self.get_item(key)
    raise Taylor::Platform::MethodCalledOnInvalidPlatformError, "LocalStorage.get_item is only available for Web exports"
  end

  # Sets the value in localStorage in the browser.
  # @param key [String]
  # @param value [String]
  # @return [nil]
  # @raise [Taylor::Platform::MethodCalledOnInvalidPlatformError] If run on non-web platforms.
  def self.set_item(key, value)
    raise Taylor::Platform::MethodCalledOnInvalidPlatformError, "LocalStorage.set_item is only available for Web exports"
  end
end
