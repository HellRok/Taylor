MRuby::CrossBuild.new('x86_64-w64-mingw32') do |conf|
  conf.toolchain :gcc

  conf.cc.flags += %w[-DMRB_ARY_LENGTH_MAX=0 -DMRB_STR_LENGTH_MAX=0]

  conf.host_target = "x86_64-w64-mingw32"  # required for `for_windows?` used by `mruby-socket` gem

  conf.cc.command = "#{conf.host_target}-gcc-posix"
  conf.linker.command = conf.cc.command
  conf.archiver.command = "#{conf.host_target}-gcc-ar"
  conf.exts.executable = ".exe"

  # These are the default libraries
  conf.gembox "stdlib"
  conf.gembox "stdlib-ext"
  conf.gembox "stdlib-io"
  conf.gembox "math"
  conf.gembox "metaprog"

  conf.gem core: 'mruby-exit'
  conf.gem core: 'mruby-sleep'
  conf.gem github: 'iij/mruby-dir'
  conf.gem github: 'iij/mruby-env'
  conf.gem github: 'iij/mruby-iijson'
  conf.gem github: 'iij/mruby-mtest'
  conf.gem github: 'hellrok/mruby-regexp-pcre'
  conf.gem github: 'katzer/mruby-tiny-opt-parser'
  # This causes issues with conflicting symbols, not sure why?
  # Will need to investigate and maybe fork.
  #conf.gem github: 'Asmod4n/mruby-uri-parser'
  conf.gem github: 'matsumotory/mruby-simplehttp'
  conf.gem github: 'matsumotory/mruby-simplehttpserver'
  conf.gem github: 'mattn/mruby-base64'
  conf.gem github: 'iij/mruby-require'
  conf.gem github: 'ksss/mruby-file-stat'
  conf.gem github: 'ksss/mruby-ostruct'
end
