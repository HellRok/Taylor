log() {
  echo "[ ${0} ]" "${@}"
}

if [ -z $SCRIPT_DIR ]; then
  log "SCRIPT_DIR was not defined"
  exit 1
fi

ROOT_DIR=$(cd -- "${SCRIPT_DIR}"/.. > /dev/null 2>&1 && pwd)

if [ "$(uname)" == 'Darwin' ]; then
  log "Using 1000:1000 since we're on OSX"
  export USER_ID=1000
  export GROUP_ID=1000
else
  # Used so the app runs as your user on Linux
  export USER_ID=$(id -u)
  export GROUP_ID=$(id -g)
  log "Using ${USER_ID}:${GROUP_ID} since we're on Linux"
fi

check_for_docker() {
  if ! command -v "docker" > /dev/null 2>&1; then
    log "Docker is not installed."
    log "Please visit https://docs.docker.com/get-docker/"
    exit 1
  fi
  log "Docker is installed!"
}
