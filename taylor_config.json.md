# The Config File

The `taylor_config.json` file is the file where all the configuration for your
Taylor game goes.

A freshly created Taylor game will come with a `taylor_config.json` that looks
like this:

```json
{
  "name": "taylor_game",
  "version": "v0.0.1",
  "input": "game.rb",
  "export_directory": "./exports",
  "export_targets": [
    "linux",
    "windows",
    "osx/intel",
    "osx/apple",
    "web"
  ],
  "load_paths": [
    "./",
    "./vendor"
  ],
  "copy_paths": [
    "./assets"
  ]
}
```

Let's go through each option one by one.

## Name

`"name": "taylor_game",`

This specifies the name when you export your game, this would cause you to get a
`taylor_game.exe` on Windows when you export. It also sets your window title in
the default `game.rb` that's created.

## Version

`"version": "v0.0.1",`

This specifies the version of your game and is part of the name of the exported
zip files. For instance you'd get the file `taylor_game-linux-v0.0.1.zip` if you
exported this for Linux.

This field is never parsed anywhere and can be anything, but I suggest sticking
to [semantic versioning](https://semver.org/) for your version numbers.

## Input

`"input": "game.rb",`

This is the Ruby file that Taylor will run if you run `taylor` in this folder
and it will be where the export process starts from. I expect this field to
change in the future to `entrypoint`.

## Export Directory

`"export_directory": "./exports",`

When you run `taylor export` this is the folder where it will save your exports
to.

## Export Targets

```json
"export_targets": [
  "linux",
  "windows",
  "osx/intel",
  "osx/apple",
  "web"
],
```

What platforms do you want to support when you export your game. The default
list is all of the officially support platforms for Taylor. All of the supported
platforms are:

- Linux (glibc 2.28+)
- Windows (Windows 7+ tested)
- OSX Intel CPU based computers
- OSX Apple (ARM) CPU based computers
- Web (Chrome has best performance, Firefox works but has a huge performance
  hit)

Now, there is pre-alpha support for Android which you can enable by adding
`"android"` to this list but be warned, it's incredibly early access and at time
of writing this document, is broken.

## Load Paths

```json
"load_paths": [
  "./",
  "./vendor"
],
```

This defines all the load paths that Ruby will look for when you do
`require "blah"`. With the default `load_paths` this would look first for
`./blah.rb` and then `./vendor/blah.rb`.

## Copy Paths

```json
"copy_paths": [
  "./assets"
]
```

This is where you will be putting all files you want copied into your exported
zip files. I will probably rename this to `resource_paths` in the future. These
are usually the folders where you keep your images/sounds/fonts/etc that your
game will load.

## Extra Options

There are actually a couple more options that aren't specified by default, right
now they are only for web builds but I expect more and more of these to come
into existence as Taylor evolves.

## Web

This sections if for web export specific configuration.

### Shell Path

```json
"web": {
  "shell_path": "shell.html"
}
```

This defines the
[shell file](https://emscripten.org/docs/tools_reference/emcc.html#emcc-shell-file)
that is passed to
[emscripten](https://emscripten.org/). You can see this used in the
[Taylor Playground](https://github.com/HellRok/TaylorPlayground) to setup a
completely different web based environment. The default file looks like
[this](https://github.com/HellRok/Taylor/blob/main/scripts/export/emscripten_shell.html)
and is a good jumping off point for your own custom shell.

### Total Memory

```json
"web": {
  "total_memory": 64
}
```

This sets the total memory that is allowed to be used by web export in
megabytes. If this is set to `-1` it allows for
(memory growth)[https://emscripten.org/docs/optimizing/Optimizing-Code.html?highlight=total%20memory#memory-growth]
but I've had issues with that recently causing memory to bloat out to 8GB on
page load and then come back down, so I've decided to set it to `64` by default,
but this may change in the future to be a bit higher depending on actual use.

## Putting It All Together

A file with every option set would end up looking like this:

```json
{
  "name": "taylor_game",
  "version": "v0.0.1",
  "input": "game.rb",
  "export_directory": "./exports",
  "export_targets": [
    "linux",
    "windows",
    "osx/intel",
    "osx/apple",
    "web"
  ],
  "load_paths": [
    "./",
    "./vendor"
  ],
  "copy_paths": [
    "./assets"
  ],
  "web": {
    "shell_path": "shell.html",
    "total_memory": 64
  }
}
```
