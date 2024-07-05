module XDo
  def self.available?
    linux? && `which xdotool` != ""
  end

  class Mouse
    def self.move_to(x, y, sync: true)
      command = "xdotool mousemove "
      command << "--sync " if sync
      command << "#{x} #{y}"

      `#{command}`
    end
  end
end
