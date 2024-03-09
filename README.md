<h1 align="center">
  <br>
  <a href="https://www.taylormadetech.dev/"><img src="https://github.com/Chadowo/Taylor/assets/83732118/d99706ca-5582-406e-b7ee-287de154fc12" alt="Taylor"></a>
  <br>
  Taylor
  <br>
</h1>
<h4 align="center">Made for Games</h4>

![GitHub Release](https://img.shields.io/github/v/release/HellRok/Taylor)
[![Build status](https://badge.buildkite.com/0cb81ca8e3b8f43a2998bc15f90323a2eb8429669e819b7697.svg)](https://buildkite.com/oequacki/taylor)
![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/HellRok/Taylor/total?label=total%20downloads)
![GitHub License](https://img.shields.io/github/license/HellRok/Taylor)


[Website](https://www.taylormadetech.dev) | [Cheat Sheet](https://www.taylormadetech.dev/documentation/tutorials/cheat_sheet/) | [Documentation](https://www.taylormadetech.dev/documentation/taylor/latest/) | [Try it Out Online](https://www.taylormadetech.dev/playground/)

## What's This?

Taylor is a game engine I've built using [mruby](https://mruby.org/) and
[raylib](https://www.raylib.com/). I'm trying to build a very simple way for
people to get into game development. This is trying to replicate the simplicity
of [QBasic](https://es.wikipedia.org/wiki/QBASIC) but with a more of a modern approach.

## Getting Started

Check out my tutorial over on the [official Taylor
website](https://www.taylormadetech.dev/documentation/tutorials/getting_started/).

## Examples

If you'd like to see some examples, check them out on the [online playground!](https://www.taylormadetech.dev/playground/)

## Compile Yourself!

**Note**: Currently there are no instructions for Windows and OSX.

There's a couple reasons you may want to compile Taylor yourself and thankfully
it's pretty straight forward for Linux.

### Linux

1. Install the build dependencies:  
  - **Fedora:**  
    ```console
    $ sudo dnf groupinstall "Development Tools" "Development Libraries"; sudo dnf install ruby
    ```  
  - **Ubuntu/Debian:**  
    ```console
    $ sudo apt-get install build-essential ruby
    ```
3. You should now just be able to run `rake` and wait a few seconds.
4. The final binary will be located on `dist/linux/debug/taylor`.
5. **Optional**: if you want the nice command line interface, you'll need to run this:  
     ```console
      $ ./dist/linux/debug/taylor ./cli-tool/cli.rb
      ```

You can make make a script that runs Taylor with the CLI directly:
```shell
#!/usr/bin/env bash
TAYLOR_PATH=/home/sean/code/taylor/

"$TAYLOR_PATH/dist/linux/debug/taylor" "$TAYLOR_PATH/cli-tool/cli.rb" "$@"
```

Save it as `taylor` and mark it as executable (`chmod +x taylor`), then put it in your 
PATH (You can drop it on `~/.local/bin/`) so you can execute it from anywhere.

### Docker

To build all the Docker images you can run the following command:

```console
$ bundle exec rake docker:build:all
```

If you also want to compile the mruby and raylib dependencies yourself there are
docker images for that too, just run:

```console
$ bundle exec rake docker:build:{mruby,raylib}
```

## License

Taylor is free and open-source, licensed under the [MIT license](https://github.com/HellRok/Taylor/blob/main/LICENSE).
