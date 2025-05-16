# The {Audio} class is used for the high level management of the {Audio} system.
class Audio
  # Used for alerting the user they're trying to use the {Audio} system without
  # first opening it.
  class NotOpenError < StandardError; end
end
