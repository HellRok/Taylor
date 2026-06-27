# Local Development

## Setting Up

> [!NOTE]
> These instructions have not been tested on Window, but may work.

1. [Install git](https://git-scm.com/install/)
2. Install Docker
  2.1 For Linux, install [Docker Engine](https://docs.docker.com/engine/)
  2.2 For OSX/Windows, install [Docker Desktop](https://docs.docker.com/desktop/)
3. Run `git clone git@github.com:HellRok/Taylor.git && cd Taylor`
4. Run `dx/build` to build the development Docker environment (this step will
   take some time)
5. Run `dx/start` to start the Docker environment
6. Run `dx/exec bin/setup` to finish the setup inside of the Docker environment
7. Run `dx/exec bundle exec rake ci` to confirm everything is working
8. Run `git config core.hooksPath ./.git-hooks` to setup the git hooks

## Coming Back

1. `cd` into the Taylor directory
2. Run `git pull` to make sure you have the latest changes
3. Run `dx/build && dx/start && dx/exec bin/setup` to get everything setup

## Developing

1. Do the above steps to get the environment setup
2. Run `dx/exec bash` to get a shell in the development environment
3. Make your changes in your preferred editor
4. In the development shell run `dx/exec bundle exec rake ci:testing` to test
   your changes

## Once You're Done

1. Run `dx/exec stop` to stop the development environment

## Using Development Taylor

1. Compile the development binary
  1.1 For Linux run `dx/exec bin/build-for-linux`
  1.2 For Windows run `dx/exec bin/build-for-windows`
  1.3 For OSX run `dx/exec bin/build-for-osx`
2. Run the development binary
  2.1 For Linux run `./dist/linux/debug/taylor ./cli-tool/cli.rb`
  2.2 For Windows run `./dist/windows/debug/taylor.exe ./cli-tool/cli.rb`
  2.3 For OSX ARM run `./dist/osx/apple/debug/taylor ./cli-tool/cli.rb`
  2.4 For OSX Intel run `./dist/osx/intel/debug/taylor ./cli-tool/cli.rb`
3. For a nicer experience on Linux/OSX you can save this script as `taylor-dev`:  
    ```bash
    #!/usr/bin/env bash
    TAYLOR_PATH=/home/sean/code/taylor/ # Change to where you cloned the repo

    "$TAYLOR_PATH/dist/linux/debug/taylor" "$TAYLOR_PATH/cli-tool/cli.rb" "$@"
    ```
4. Put that script somewhere in your $PATH, I recommend
   `~/.local/bin/taylor-dev`

## Building Taylor in Release Mode

1. Enter the development environment with `dx/exec bash`
2. Run `bundle exec rake` to ensure you have a debug `taylor`
3. Run `bundle exec rake docker:build:all` to build all the images (this
   step will take some time)
4. `cd cli-tool && ../dist/linux/debug/taylor cli.rb export`
5. You should have all the zip files in `cli-tool/exports`
