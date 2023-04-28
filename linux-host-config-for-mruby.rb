MRuby::Build.new do |conf|
  conf.toolchain

  conf.cc.flags += %w[-DMRB_ARY_LENGTH_MAX=0 -DMRB_STR_LENGTH_MAX=0]

  # These are the default libraries
  conf.gembox "stdlib"
  conf.gembox "stdlib-ext"
  conf.gembox "stdlib-io"
  conf.gembox "math"
  conf.gembox "metaprog"

  # Generate mrbc command
  conf.gem core: "mruby-bin-mrbc"

  conf.gem core: 'mruby-exit'
  conf.gem core: 'mruby-sleep'

  conf.gem github: 'iij/mruby-dir', branch: "master"
  conf.gem github: 'iij/mruby-env'
  conf.gem github: 'iij/mruby-iijson'
  conf.gem github: 'iij/mruby-mtest'
  conf.gem github: 'hellrok/mruby-regexp-pcre'
  conf.gem github: 'katzer/mruby-tiny-opt-parser'
  conf.gem github: 'Asmod4n/mruby-uri-parser'
  #conf.gem github: 'matsumotory/mruby-simplehttp'
  conf.gem github: 'matsumotory/mruby-simplehttpserver'
  conf.gem github: 'mattn/mruby-base64'
  conf.gem github: 'iij/mruby-require'
=begin
  #conf.gem github: 'ksss/mruby-at_exit'
  #conf.gem github: 'awfulcooking/mruby-file-stat'
  conf.gem github: 'ksss/mruby-ostruct'
=end
  conf.gem github: 'ksss/mruby-file-stat'
end

