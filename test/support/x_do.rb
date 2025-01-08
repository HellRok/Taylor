module XDo
  def self.available?
    linux? && `which xdotool` != ""
  end

  def self.command
    "xdotool"
  end

  class Mouse
    BUTTON = {
      left: 1,
      middle: 2,
      right: 3,
      wheel_up: 4,
      wheel_down: 5
    }

    def self.move_to(x, y, sync: false)
      command = "#{XDo.command} mousemove "
      command << "--sync " if sync
      command << "#{x} #{y}"

      `#{command}`
    end

    def self.move_by(x, y, sync: false)
      command = "#{XDo.command} mousemove_relative "
      command << "--sync " if sync
      command << "#{x} #{y}"

      `#{command}`
    end

    def self.button_down(button) = `#{XDo.command} mousedown #{button}`

    def self.button_up(button) = `#{XDo.command} mouseup #{button}`

    def self.scroll_up = `#{XDo.command} click 4`

    def self.scroll_down = `#{XDo.command} click 5`

    def self.scroll_left = `#{XDo.command} click 6`

    def self.scroll_right = `#{XDo.command} click 7`
  end

  class Key
    def self.down(key, modifier: nil) = `#{XDo.command} keydown #{modifier ? "#{modifier}+#{key}" : key}`

    def self.up(key) = `#{XDo.command} keyup #{key}`
  end
end
