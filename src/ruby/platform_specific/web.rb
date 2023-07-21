class LocalStorage
  def self.get_item(key)
    raise PlatformSpecificMethodCalledOnWrongPlatformError, 'LocalStorage.get_item is only available for Web exports'
  end

  def self.set_item(key, value)
    raise PlatformSpecificMethodCalledOnWrongPlatformError, 'LocalStorage.set_item is only available for Web exports'
  end
end
