MRuby::CrossBuild.new('x86_64-w64-mingw32') do |conf|
  conf.toolchain :gcc

  conf.host_target = "x86_64-w64-mingw32"  # required for `for_windows?` used by `mruby-socket` gem

  conf.cc.command = "#{conf.host_target}-gcc-posix"
  conf.linker.command = conf.cc.command
  conf.archiver.command = "#{conf.host_target}-gcc-ar"
  conf.exts.executable = ".exe"

  conf.gembox "default"

  conf.gem core: 'mruby-exit'
  conf.gem github: 'iij/mruby-dir'
  conf.gem github: 'iij/mruby-env'
  conf.gem github: 'iij/mruby-iijson'
  conf.gem github: 'iij/mruby-mtest'
  conf.gem github: 'katzer/mruby-tiny-opt-parser'
  conf.gem github: 'hellrok/mruby-require'
end
