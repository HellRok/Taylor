@unit.describe "Monitor.count" do
  Given "there are multiple monitors" do
    Taylor::Raylib.mock_call("GetMonitorCount", "2")
  end

  Then "return the count of monitors" do
    expect(Monitor.count).to_equal(2)
  end

  But "if called before opening a window" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Monitor.count
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Monitor.count"
    )
  end
end

@unit.describe "Monitor#initialize" do
  When "we initialise a monitor" do
    @monitor = Monitor.new(id: 1)
  end

  Then "it has the correct attributes" do
    expect(@monitor).to_be_a(Monitor)
    expect(@monitor.id).to_equal(1)
  end
end

@unit.describe "Monitor.[]" do
  When "we get a monitor" do
    @monitor = Monitor[0]
  end

  Then "it has the correct attributes" do
    expect(@monitor).to_be_a(Monitor)
    expect(@monitor.id).to_equal(0)
  end

  But "if we request a negative monitor, raise an error" do
    Taylor::Raylib.mock_call("GetMonitorCount", "2")

    expect {
      Monitor[-1]
    }.to_raise(ArgumentError, "Must be an integer in (0..1)")
  end

  Or "if we request too high a monitor, raise an error" do
    Taylor::Raylib.mock_call("GetMonitorCount", "3")

    expect {
      Monitor[3]
    }.to_raise(ArgumentError, "Must be an integer in (0..2)")
  end

  Or "if we get a monitor before opening the window" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")

    expect {
      Monitor[0]
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Monitor[]"
    )
  end
end

@unit.describe "Monitor.all" do
  Given "there are multiple monitors" do
    Taylor::Raylib.mock_call("GetMonitorCount", "2")
  end

  When "we get them all" do
    @monitors = Monitor.all
  end

  Then "they all have the correct attributes" do
    expect(@monitors.size).to_equal(2)
    expect(@monitors[0]).to_be_a(Monitor)
    expect(@monitors[0].id).to_equal(0)
    expect(@monitors[1]).to_be_a(Monitor)
    expect(@monitors[1].id).to_equal(1)
  end

  But "if called before opening the window" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Monitor.all
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Monitor.all"
    )
  end
end

@unit.describe "Monitor.current" do
  Given "the window is on monitor 3" do
    Taylor::Raylib.mock_call("GetCurrentMonitor", "3")
  end

  When "we get the current monitor" do
    @monitor = Monitor.current
  end

  Then "it's the third one" do
    expect(@monitor).to_be_a(Monitor)
    expect(@monitor.id).to_equal(3)
  end

  But "if called before the window is open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Monitor.current
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Monitor.current"
    )
  end
end

@unit.describe "Monitor#position" do
  Given "the monitor is at position 10, 20" do
    Taylor::Raylib.mock_call("GetMonitorPosition", "10 20")
  end

  When "we get the current monitor's position" do
    @monitor = Monitor[0]
    Taylor::Raylib.reset_calls
  end

  Then "it's at 10, 20" do
    expect(@monitor.position).to_equal(Vector2[10, 20])
  end

  But "if called before the window is open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      @monitor.position
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Monitor#position"
    )
  end
end

@unit.describe "Monitor#width" do
  Given "the monitor has a width of 1920" do
    Taylor::Raylib.mock_call("GetMonitorWidth", "1920")
  end

  When "we have a monitor" do
    @monitor = Monitor[0]
  end

  Then "return 1920" do
    expect(@monitor.width).to_equal(1920)
  end

  But "if called before the window is open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      @monitor.width
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Monitor#width"
    )
  end
end

@unit.describe "Monitor#height" do
  Given "the monitor has a height of 1080" do
    Taylor::Raylib.mock_call("GetMonitorHeight", "1080")
  end

  When "we have a monitor" do
    @monitor = Monitor[0]
  end

  Then "return 1080" do
    expect(@monitor.height).to_equal(1080)
  end

  But "if called before the window is open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      @monitor.height
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Monitor#height"
    )
  end
end

@unit.describe "Monitor#resolution" do
  Given "the monitor has a resolution of 1920x1080" do
    Taylor::Raylib.mock_call("GetMonitorWidth", "1920")
    Taylor::Raylib.mock_call("GetMonitorHeight", "1080")
  end

  When "we have a monitor" do
    @monitor = Monitor[0]
  end

  Then "return 1920, 1080" do
    expect(@monitor.resolution).to_equal(Vector2[1920, 1080])
  end

  But "if called before the window is open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      @monitor.resolution
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Monitor#resolution"
    )
  end
end

@unit.describe "Monitor#refresh_rate" do
  Given "the monitor has a refresh_rate of 60" do
    Taylor::Raylib.mock_call("GetMonitorRefreshRate", "60")
  end

  When "we have a monitor" do
    @monitor = Monitor[0]
  end

  Then "return 60" do
    expect(@monitor.refresh_rate).to_equal(60)
  end

  But "if called before the window is open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      @monitor.refresh_rate
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Monitor#refresh_rate"
    )
  end
end

@unit.describe "Monitor#name" do
  Given "the monitor has a name of the-monitor" do
    Taylor::Raylib.mock_call("*GetMonitorName", "the-monitor")
  end

  When "we have a monitor" do
    @monitor = Monitor[0]
  end

  Then "return the-monitor" do
    expect(@monitor.name).to_equal("the-monitor")
  end

  But "if called before the window is open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      @monitor.name
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Monitor#name"
    )
  end
end
