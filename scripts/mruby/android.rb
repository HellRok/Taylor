# Requires Android NDK r13 or later.
MRuby::CrossBuild.new('android-arm64-v8a') do |conf|
  params = {
    arch: 'arm64-v8a',
    sdk_version: 29,
    toolchain: :clang,
  }
  toolchain :android, params

  conf.cc.flags += %w[-DMRB_ARY_LENGTH_MAX=0 -DMRB_STR_LENGTH_MAX=0]

  conf.archiver.command = 'llvm-ar'

  conf.build_target = "x86_64-pc-linux-gnu"
  conf.host_target = "aarch64-android-linux"

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
