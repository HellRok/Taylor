module PutsGrabber
  attr_accessor :puts_data

  def puts(str)
    @puts_data ||= ""
    @puts_data << str
  end
end

module BacktickGrabber
  attr_accessor :backtick_data

  def `(str)
    @backtick_data ||= []
    @backtick_data << str
  end
end

module RequireGrabber
  attr_accessor :require_list

  def require(str)
    @require_list ||= []
    @require_list << str
  end
end

module Taylor
  def self.remove_const(const)
    $removed_const = const
  end

  module Commands
    class Export
      include PutsGrabber
      include BacktickGrabber
    end

    class New
      include PutsGrabber
    end

    class Run
      include PutsGrabber
      include RequireGrabber
    end

    class Squash
      include PutsGrabber
    end

    class Version
      include PutsGrabber
    end
  end
end
