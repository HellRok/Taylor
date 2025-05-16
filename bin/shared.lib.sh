BLACK="\033[0;30m"
BLACK_BG="\033[0;40m"
RED="\033[0;31m"
RED_BG="\033[0;41m"
GREEN="\033[0;32m"
GREEN_BG="\033[0;42m"
YELLOW="\033[0;33m"
YELLOW_BG="\033[0;43m"
BLUE="\033[0;34m"
BLUE_BG="\033[0;44m"
MAGENTA="\033[0;35m"
MAGENTA_BG="\033[0;45m"
CYAN="\033[0;36m"
CYAN_BG="\033[0;46m"
GRAY="\033[0;90m"
GRAY_BG="\033[0;100m"
WHITE="\033[0;97m"
WHITE_BG="\033[0;107m"
LIGHT_GRAY="\033[0;37m"
LIGHT_GRAY_BG="\033[0;47m"
LIGHT_RED="\033[0;91m"
LIGHT_RED_BG="\033[0;101m"
LIGHT_GREEN="\033[0;92m"
LIGHT_GREEN_BG="\033[0;102m"
LIGHT_YELLOW="\033[0;93m"
LIGHT_YELLOW_BG="\033[0;103m"
LIGHT_BLUE="\033[0;94m"
LIGHT_BLUE_BG="\033[0;104m"
LIGHT_MAGENTA="\033[0;95m"
LIGHT_MAGENTA_BG="\033[0;105m"
LIGHT_CYAN="\033[0;96m"
LIGHT_CYAN_BG="\033[0106m"
CLEAR="\033[1K\r";
NC="\033[0m";

# Output related functions
function log() { echo -e "[ ${BLUE}$0${NC} ] $@"; }
function clear_line() { echo -e; }
function running() { echo -ne "[ ${BLUE}$0${NC} ][ ] $@..."; }
function complete() { echo -e "${CLEAR}[ ${BLUE}$0${NC} ][${GREEN}✓${NC}] $@"; }
function fail() { echo -e "${CLEAR}[ ${BLUE}$0${NC} ][${RED}✗${NC}] $@"; }

# Test related functions
function timer_now { date +%s%N; }

function timer_start {
  timer_start=${timer_start:-$(timer_now)}
}
function timer_stop {
  local delta_us=$((($(timer_now) - $timer_start) / 1000))
  local us=$((delta_us % 1000))
  local ms=$(((delta_us / 1000) % 1000))
  local s=$(((delta_us / 1000000) % 60))
  local m=$(((delta_us / 60000000) % 60))
  local h=$((delta_us / 3600000000))
  # Goal: always show around 3 digits of accuracy
  if ((h > 0)); then timer_show=${h}h${m}m
  elif ((m > 0)); then timer_show=${m}m${s}s
  elif ((s >= 10)); then timer_show=${s}.$((ms / 100))s
  elif ((s > 0)); then timer_show=${s}.$(printf %03d $ms)s
  elif ((ms >= 100)); then timer_show=${ms}ms
  elif ((ms > 0)); then timer_show=${ms}.$((us / 100))ms
  else timer_show=${us}us
  fi
  unset timer_start
}

job_title=;
job_output=;
function result() {
  timer_stop
  if [[ $1 -ne 0 ]]; then
    fail "${job_title}!!! ${BLUE}(${timer_show})${NC}"
    echo -e "${job_output}"
    exit $1
  else
    complete "${job_title} ${BLUE}(${timer_show})${NC}"
  fi
}

function barf_if_failed() {
  if [[ $1 -ne 0 ]]; then
    echo -e "${job_output}"
    exit $1
  fi
}

function start() {
  timer_start
  job_title=$@
  running $@
}
