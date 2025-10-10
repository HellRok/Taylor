@unit.describe "Taylor::Platform.to_s" do
  expect(Taylor::Platform.to_s).to_be_in([
    "arm64-android",
    "wasm32-browser",
    "amd64-linux",
    "amd64-osx",
    "arm64-osx",
    "amd64-windows"
  ])
end

@unit.describe "Taylor::Platform.os" do
  expect(Taylor::Platform.os).to_be_in([
    :android, :browser, :linux, :osx, :windows
  ])
end

@unit.describe "Taylor::Platform.arch" do
  expect(Taylor::Platform.arch).to_be_in([
    :amd64, :arm64, :wasm32
  ])
end

@unit.describe "Taylor::Platform platform checks" do
  if Taylor::Platform == "arm64-android"
    expect(Taylor::Platform.os).to_equal(:android)
    expect(Taylor::Platform.arch).to_equal(:arm64)
    expect(Taylor::Platform.android?).to_be_true
    expect(Taylor::Platform.browser?).to_be_false
    expect(Taylor::Platform.linux?).to_be_false
    expect(Taylor::Platform.osx?).to_be_false
    expect(Taylor::Platform.windows?).to_be_false

  elsif Taylor::Platform == "wasm32-browser"
    expect(Taylor::Platform.os).to_equal(:browser)
    expect(Taylor::Platform.arch).to_equal(:wasm32)
    expect(Taylor::Platform.android?).to_be_false
    expect(Taylor::Platform.browser?).to_be_true
    expect(Taylor::Platform.linux?).to_be_false
    expect(Taylor::Platform.osx?).to_be_false
    expect(Taylor::Platform.windows?).to_be_false

  elsif Taylor::Platform == "amd64-linux"
    expect(Taylor::Platform.os).to_equal(:linux)
    expect(Taylor::Platform.arch).to_equal(:amd64)
    expect(Taylor::Platform.android?).to_be_false
    expect(Taylor::Platform.browser?).to_be_false
    expect(Taylor::Platform.linux?).to_be_true
    expect(Taylor::Platform.osx?).to_be_false
    expect(Taylor::Platform.windows?).to_be_false

  elsif Taylor::Platform == "amd64-osx"
    expect(Taylor::Platform.os).to_equal(:osx)
    expect(Taylor::Platform.arch).to_equal(:amd64)
    expect(Taylor::Platform.android?).to_be_false
    expect(Taylor::Platform.browser?).to_be_false
    expect(Taylor::Platform.linux?).to_be_false
    expect(Taylor::Platform.osx?).to_be_true
    expect(Taylor::Platform.windows?).to_be_false

  elsif Taylor::Platform == "arm64-osx"
    expect(Taylor::Platform.os).to_equal(:osx)
    expect(Taylor::Platform.arch).to_equal(:arm64)
    expect(Taylor::Platform.android?).to_be_false
    expect(Taylor::Platform.browser?).to_be_false
    expect(Taylor::Platform.linux?).to_be_false
    expect(Taylor::Platform.osx?).to_be_true
    expect(Taylor::Platform.windows?).to_be_false

  elsif Taylor::Platform == "amd64-windows"
    expect(Taylor::Platform.os).to_equal(:windows)
    expect(Taylor::Platform.arch).to_equal(:amd64)
    expect(Taylor::Platform.android?).to_be_false
    expect(Taylor::Platform.browser?).to_be_false
    expect(Taylor::Platform.linux?).to_be_false
    expect(Taylor::Platform.osx?).to_be_false
    expect(Taylor::Platform.windows?).to_be_true

  else
    raise StandardError, "No platform checks for '#{Taylor::Platform}'"
  end
end
