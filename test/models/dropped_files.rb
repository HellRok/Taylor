class Test
  class Models
    class DroppedFiles_Test < Test::Base
      def test_any?
        Taylor::Raylib.mock_call("IsFileDropped", "true")
        Taylor::Raylib.mock_call("IsFileDropped", "false")

        assert_true DroppedFiles.any?
        assert_false DroppedFiles.any?

        assert_called [
          "(IsFileDropped) { }",
          "(IsFileDropped) { }"
        ]
      end

      def test_all
        Taylor::Raylib.mock_call("LoadDroppedFiles", "file1 path/file2 more/path/file3")

        assert_equal ["file1", "path/file2", "more/path/file3"], DroppedFiles.all
        assert_equal [], DroppedFiles.all

        assert_called [
          "(LoadDroppedFiles) { }",
          "(UnloadDroppedFiles) { files: { capacity: 8 count: 3 } }",
          "(LoadDroppedFiles) { }",
          "(UnloadDroppedFiles) { files: { capacity: 8 count: 0 } }"
        ]
      end
    end
  end
end
