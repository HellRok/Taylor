# This is a pretty disgusting hack that I'm not 100% sure why needs to be here.
# It seems to be that this would have been useful for the `capture_io`
# assertion that.... doesn't seem to exist? Although weirdly, deleting these
# methods and trying to use the global `puts` and `print` also doesn't work?
#
# Given how little these tests are actually expected to run on Windows, let's
# just leave it here for now. Everything to do with console output has been a
# nightmare so far for Windows.

if windows?
  module MTest
    class Unit
      def puts *a
        super(*a)
      end

      def print *a
        super(*a)
      end
    end
  end
end
