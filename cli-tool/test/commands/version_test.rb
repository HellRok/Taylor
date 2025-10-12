@unit.describe "Version" do
  When "we call `taylor --version`" do
    @version_command = Taylor::Commands::Version.new
  end

  Then "we output the current version" do
    expect(@version_command.puts_data).to_equal("Taylor #{TAYLOR_VERSION}")
  end
end
