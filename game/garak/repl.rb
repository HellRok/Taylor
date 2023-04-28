require "garak/ansi"

TOP_LEVEL ||= self

module ::Garak
  class REPL
    attr_accessor :stdin, :stdout, :prompt, :buffer
    attr_accessor :prompt_color, :error_color, :result_color
    attr_accessor :last_result

    def initialize(stdin=$stdin, stdout=$stdout,
      prompt: "repl> ",
      prompt_color: :bright_green,
      error_color: :bright_magenta,
      result_color: :bright_yellow
    )
      @buffer = ""
      @stdin = stdin
      @stdout = stdout
      @prompt = prompt
      @prompt_color = prompt_color
      @error_color = error_color
      @result_color = result_color
    end

    def tick!
      did_read = false
      while IO.select([@stdin], nil, nil, 0)
        @buffer += @stdin.getc.to_s
        did_read = true
      end

      if !did_read and !@buffer.empty?
        begin
          eval! @buffer
        ensure
          @buffer.clear
          prompt!
        end
      end
    end

    def run_blocking!(...)
      prompt!
      while line = @stdin.readline rescue nil
        eval!(line, ...)
        prompt!
      end
    end

    def puts(*msgs)
      for line in msgs.map! { |msg| msg.to_s.lines }.flatten
        print "\e7"
        print "\r\n"
        print "\e[1F"
        print "\e[1L"
        print "\e6"
        super(line.chomp!)
        print "\e8"
        print "\e[1B"
        print "\e9"
      end
    end

    def sprint(*args)
      puts args.inspect
    end

    def _() = @last_result

    def eval!(code)
      return if code.strip.empty?

      _ = @last_result
      @last_result = TOP_LEVEL.eval(code)
      print_result!        
    rescue Exception => ex
      print_error! ex
    end
    
    def prompt!(prompt=@prompt, color=@prompt_color, input_color=@input_color)
      print ANSI.color(color, prompt), ANSI.reset
    end
    
    def print_error!(ex, color=@error_color)
      print ANSI.color(color, <<~error)
        #{ex.message.strip}
          #{ex.backtrace.join("\n  ")}
      error
      print ANSI.reset
    end
    
    def print_result!(object=@last_result, color=@result_color)
      print ANSI.color(color, "  => #{object.inspect}\n"), ANSI.reset
    end
  end
end
