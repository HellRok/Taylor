module Taylor
  module Commands
    class Version
      def self.call
        new
      end

      def initialize
        display_version
      end

      def display_version
        puts "Taylor #{TAYLOR_VERSION}"
      end
    end
  end
end
