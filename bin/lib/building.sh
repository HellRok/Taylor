function build_docker_image_for() {
  platform=$1

  start "Building ${platform} docker images"
  job_output=$(bundle exec rake docker:build:${platform} 2>&1)
  result $?
}

function compile_taylor_through_docker_for() {
  platform=$1
  rake_command=$2

  USER_ID=$(id -u ${USER})
  GROUP_ID=$(id -g ${USER})

  start "Compiling for ${platform}"
  job_output=$(
    docker run \
      --mount type=bind,src=./,dst=/app/taylor \
      --user ${USER_ID}:${GROUP_ID} \
      -it hellrok/taylor:${platform}-latest \
      bash -c "unset EXPORT; cd /app/taylor; rake ${rake_command}" 2>&1
    )
    result $?
  }
