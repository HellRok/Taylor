# Used for handling logging
module Logging
  @@level = 0

  # @return [Integer]
  def self.level = @@level

  # @!group Logging levels

  # Used to show all logs
  ALL = 0
  # Used to show Trace logs and above
  TRACE = 1
  # Used to show Debug logs and above
  DEBUG = 2
  # Used to show Info logs and above
  INFO = 3
  # Used to show Warning logs and above
  WARNING = 4
  # Used to show Error logs and above
  ERROR = 5
  # Used to show Fatal logs
  FATAL = 6
  # Used to disable logging
  NONE = 7

  # @!endgroup
end
