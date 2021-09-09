MRuby::CrossBuild.new('emscripten') do |conf|
  toolchain :clang

  conf.cc.command = 'emcc'
  conf.cc.flags  += %w[ -s ASSERTIONS=1 -s ASYNCIFY]
  conf.cxx.command = 'em++'
  conf.cxx.flags  += %w[ -s ASSERTIONS=1 -s ASYNCIFY]
  conf.linker.command = 'em++'
  conf.archiver.command = 'emar'

   #These are the default libraries
  conf.gembox "stdlib"
  conf.gembox "stdlib-ext"
  conf.gembox "stdlib-io"
  conf.gembox "math"
  conf.gembox "metaprog"

  conf.gem core: 'mruby-exit'
  conf.gem github: 'iij/mruby-dir'
  conf.gem github: 'iij/mruby-env'
  conf.gem github: 'iij/mruby-iijson'
  conf.gem github: 'iij/mruby-mtest'
  conf.gem github: 'katzer/mruby-tiny-opt-parser'
  conf.gem github: 'hellrok/mruby-require'
end
