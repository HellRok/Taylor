#include "mruby.h"
#include "mruby/compile.h"

#ifdef _WIN32
#include <shtypes.h>
#include <winbase.h>
#include <wincon.h>
#include <windef.h>

void workarounds_mingw_msg_dontwait(mrb_state* mrb)
{
  // We don't have this populated on windows, so let's just whack it in at 0.
  // This gets the webserver properly responding to requests on my machine.
  mrb_load_string(mrb, R"(
    Socket::MSG_DONTWAIT = 0 if Taylor::Platform.windows?
  )");
}
#endif
