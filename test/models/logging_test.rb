@unit.describe "Logging.log" do
  When "called without a level" do
    Logging.log(message: "Hello!")
  end

  Then "Raylib is called with Logging::INFO" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(TraceLog) { logLevel: 3 text: 'Hello!' }"
      ]
    )
  end

  When "called with a level" do
    Logging.log(level: Logging::FATAL, message: "Oops :(")
  end

  Then "Raylib is called with the level" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(TraceLog) { logLevel: 6 text: 'Oops :(' }"
      ]
    )
  end

  But "raises an error if called with a negative level" do
    expect {
      Logging.log(level: -1, message: "!")
    }.to_raise(ArgumentError, "Logging level must be within (0..7)")
  end

  Or "with a level greater than 7" do
    expect {
      Logging.log(level: 8, message: "!")
    }.to_raise(ArgumentError, "Logging level must be within (0..7)")
  end
end

@unit.describe "Logging.level=" do
  When "no level has been set" do
  end

  Then "it defaults to Logging::INFO" do
    expect(Logging.level).to_equal(Logging::INFO)
  end

  When "set to a value" do
    Logging.level = Logging::WARNING
  end

  Then "it is set to that value" do
    expect(Logging.level).to_equal(Logging::WARNING)
  end

  And "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetTraceLogLevel) { logLevel: 4 }"
      ]
    )
  end

  But "raises an error if called with a negative level" do
    expect {
      Logging.level = -1
    }.to_raise(ArgumentError, "Logging level must be within (0..7)")
  end

  Or "with a level greater than 7" do
    expect {
      Logging.level = 8
    }.to_raise(ArgumentError, "Logging level must be within (0..7)")
  end
end
