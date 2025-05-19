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
