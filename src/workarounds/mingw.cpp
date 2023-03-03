#include "mruby.h"
#include "mruby/compile.h"

#ifdef _WIN32
#include <windef.h>
#include <winbase.h>
#include <shtypes.h>
#include <wincon.h>

void workarounds_mingw_attach_console() {
  // This allows us to write to a cmd.exe or powershell if we were run from
  // one, but otherwise don't open another window.
  if (AttachConsole(ATTACH_PARENT_PROCESS)) {
    freopen("CONIN$", "r", stdin);
    freopen("CONOUT$", "w", stdout);
    freopen("CONOUT$", "w", stderr);
  }
}

void workarounds_mingw_msg_dontwait(mrb_state *mrb) {
  // We don't have this populated on windows, so let's just whack it in at 0.
  // This gets the webserver properly responding to requests on my machine.
  mrb_load_string(mrb, R"(
    Socket::MSG_DONTWAIT = 0 if windows?
  )");
}
#endif
