@unit.describe "DroppedFiles.any?" do
  Given "files have been dropped" do
    Taylor::Raylib.mock_call("IsFileDropped", "true")
  end

  Then "return true" do
    expect(DroppedFiles.any?).to_be_true
  end

  Given "no files have been dropped" do
    Taylor::Raylib.mock_call("IsFileDropped", "false")
  end

  Then "return false" do
    expect(DroppedFiles.any?).to_be_false
  end
end

@unit.describe "DroppedFiles.all" do
  Given "files have been dropped" do
    Taylor::Raylib.mock_call("LoadDroppedFiles", "file1 path/file2 more/path/file3")
  end

  Then "return true" do
    expect(DroppedFiles.all).to_equal(
      [
        "file1",
        "path/file2",
        "more/path/file3"
      ]
    )
  end

  Given "no files have been dropped" do
  end

  Then "return false" do
    expect(DroppedFiles.all).to_be_empty
  end
end
