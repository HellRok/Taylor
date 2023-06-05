# Taylor
## Made for Games

[![Build status](https://badge.buildkite.com/0cb81ca8e3b8f43a2998bc15f90323a2eb8429669e819b7697.svg)](https://buildkite.com/oequacki/taylor)
![GitHub all releases](https://img.shields.io/github/downloads/HellRok/Taylor/total?label=Total%20Downloads&style=plastic)

**Website**: [http://taylor.oequacki.com](http://taylor.oequacki.com)  
**Documentation**: [https://taylor.oequacki.com/documentation/taylor/latest/](https://taylor.oequacki.com/documentation/taylor/latest/)  
**Try it out online**: [http://taylor.oequacki.com/playground/](http://taylor.oequacki.com/playground/)

## What's this?

Taylor is a game engine I've built using [mruby](http://mruby.org/) and
[raylib](https://www.raylib.com/). I'm trying to build a very simple way for
people to get into game development. This is trying to replicate the simplicity
of QBasic but with a more of a modern approach.

## Getting Started

Check out my tutorial over on the [official Taylor
website](http://taylor.oequacki.com/documentation/tutorials/getting_started/).

## Examples

If you'd like to see some examples, check them out
[here!](https://taylor.oequacki.com/playground/)

## Compile Yourself!

There's a couple reasons you may want to compile Taylor yourself and thankfully
it's pretty straight forward for Linux.

1. Install the build dependencies:  
  **Fedora:**  
  `$ sudo dnf groupinstall "Development Tools" "Development Libraries"; sudo dnf install ruby`  
  **Ubuntu/Debian:**  
  `$ sudo apt-get install build-essential ruby`

2. You should now just be able to run `$ rake` and wait a few seconds.
3. You'll now have a binary you can run like `$ ./dist/linux/debug/taylor`
4. If you want the nice command line interface, you'll need to run:  
  `$ ./dist/linux/debug/taylor ./cli-tool/cli.rb`
5. Take make it easier to run, you can create a `taylor-dev` script and populate
   it with:
   ```shell
   #!/usr/bin/env bash
   TAYLOR_PATH=/home/sean/code/taylor/

   "$TAYLOR_PATH/dist/linux/debug/taylor" "$TAYLOR_PATH/cli-tool/cli.rb" "$@"
   ```
6. Then you can just `$ ./taylor-dev`

## Building All the Docker Images

To build all the docker images you can run the following command:

```
$ bundle exec rake docker:build:all
```

If you also want to compile the mruby and raylib dependencies yourself there are
docker images for that too, just run:

```
$ bundle exec rake docker:build:{mruby,raylib}
```
