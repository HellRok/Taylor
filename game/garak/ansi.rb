module ::Garak
  module ANSI
    extend self

    COLORS = {
      black: 30, red: 31, green: 32, yellow: 33,
      blue: 34, magenta: 35, cyan: 36, white: 37,

      bright_black: "1;30", bright_red: "1;31", bright_green: "1;32",
      bright_yellow: "1;33", bright_blue: "1;34", bright_magenta: "1;35",
      bright_cyan: "1;36", bright_white: "1;37",
    }

    STYLES = {
      reset: 0, bold: 1, italic: 3, underline: 4,
      blink: 5, reverse: 6,
    }

    def color(name, text=self, suffix=reset)
      return text unless name
      "\e[#{COLORS[name] or raise ArgumentError.new("unknown color: #{name.inspect}")}m#{text}#{suffix}"
    end

    def style(name, text=self, suffix=reset)
      return text unless name
      "\e[#{STYLES[name] or raise ArgumentError.new("unknown style: #{name.inspect}")}m#{text}#{suffix}"
    end

    def method_missing(name, *)
      key = name.to_s.delete_prefix("ansi_").to_sym
      if COLORS.key?(key)
        send define_method(name) { |text=self,suffix=reset| color(key, text, suffix) }
      elsif STYLES.key?(key)
        send define_method(name) { |text=self,suffix=reset| style(key, text, suffix) }
      else
        super
      end
    end

    def reset(text="") = style(:reset, text, nil)
    def ansi_reset(text="") = style(:reset, text, nil)

    for name in [*COLORS.keys, *STYLES.keys]
      send(name)
      send("ansi_#{name}")
    end
  end
end
