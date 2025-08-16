module Logging
  # Sets the {Logging} level, this means that only logs of this level or higher
  # will be logged.
  #
  # @example Basic usage
  #   Logging.level = Logging::TRACE
  #
  # @param level [Integer] What level of logging to output, valid options are:
  #   {Logging::ALL}, {Logging::TRACE}, {Logging::DEBUG}, {Logging::INFO},
  #   {Logging::WARNING}, {Logging::ERROR}, {Logging::FATAL}, or {Logging::NONE}
  # @return [nil]
  # @raise [ArgumentError] Raised when passed an invalid level.
  def self.level=(level)
    # mrb_Logging_set_level
    # src/mruby_integration/models/logging.cpp
    nil
  end

  # Log the message if it's equal or above the level set in {Logging}.
  #
  # @example Basic usage
  #   Logging.level = Logging::WARNING
  #
  #   Logging.log(level: Logging::INFO, message: "It's a nice day :)")
  #   # Will not be logged because it's not a Logging::WARNING or higher
  #
  #   Logging.log(level: Logging::ERROR, message: "Woah!")
  #   # Will be logged because it's higher than Logging::WARNING
  #
  # @param level [Integer] What level of logging to output, valid options are:
  #   {Logging::ALL}, {Logging::TRACE}, {Logging::DEBUG}, {Logging::INFO},
  #   {Logging::WARNING}, {Logging::ERROR}, {Logging::FATAL}, or {Logging::NONE}
  # @param message [String]
  # @return [nil]
  # @raise [ArgumentError] Raised when passed an invalid level.
  def self.log(message:, level: Logging::TRACE)
    # mrb_Logging_log
    # src/mruby_integration/models/logging.cpp
    nil
  end
end
