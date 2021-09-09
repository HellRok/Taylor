MRuby::Build.new do |conf|
  conf.toolchain

  # These are the default libraries
  conf.gembox "stdlib"
  conf.gembox "stdlib-ext"
  conf.gembox "stdlib-io"
  conf.gembox "math"
  conf.gembox "metaprog"

  # Generate mrbc command
  conf.gem :core => "mruby-bin-mrbc"

  conf.gem core: 'mruby-exit'
  conf.gem github: 'iij/mruby-dir'
  conf.gem github: 'iij/mruby-env'
  conf.gem github: 'iij/mruby-iijson'
  conf.gem github: 'iij/mruby-mtest'
  conf.gem github: 'katzer/mruby-tiny-opt-parser'
  conf.gem github: 'hellrok/mruby-require'
end
