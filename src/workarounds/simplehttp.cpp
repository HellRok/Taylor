#include "mruby.h"
#include "mruby/compile.h"

void workarounds_simplehttp(mrb_state *mrb) {
  // For some reason on windows the TCPSocket returns a full extra packet, so
  // we can detect the end of the body with the null terminating character
  // \x00. In my minimal testing this hasn't produced any weird results, but
  // time will tell what obvious case I've missed.
  mrb_load_string(mrb, R"(
    class SimpleHttp
      class SimpleHttpResponse
        def initialize(response_text)
          @response = {}
          @headers = {}
          if response_text.empty?
            @response["header"] = nil
          elsif response_text.include?(SEP + SEP)
            @response["header"], @response["body"] = response_text.split(SEP + SEP, 2)
            @response["body"] = @response["body"].split("\x00").first
          else
            @response["header"] = response_text
          end
          parse_header
          self
        end
      end
    end
  )");
}
