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

module ExitTrapper
  attr_accessor :exit_status

  def exit!(status) = @exit_status = status
end

module ConstantRemovalGrabber
  @@removed_constants = []
  def removed_constants = @@removed_constants

  def removed_constants=(val)
    @@removed_constants = val
  end

  def remove_const(const)
    @@removed_constants << const
  end
end

module Taylor
  extend ConstantRemovalGrabber

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
      include ExitTrapper
    end

    class Squash
      include PutsGrabber
    end

    class Version
      include PutsGrabber
    end
  end
end
