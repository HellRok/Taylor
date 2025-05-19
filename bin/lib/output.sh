function log() { echo -e "[ ${BLUE}$0${NC} ] $@"; }
function clear_line() { echo -e; }
function running() { echo -ne "[ ${BLUE}$0${NC} ][ ] $@..."; }
function complete() { echo -e "${CLEAR}[ ${BLUE}$0${NC} ][${GREEN}✓${NC}] $@"; }
function fail() { echo -e "${CLEAR}[ ${BLUE}$0${NC} ][${RED}✗${NC}] $@"; }
