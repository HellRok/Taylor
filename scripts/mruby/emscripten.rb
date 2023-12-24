MRuby::CrossBuild.new("emscripten") do |conf|
  toolchain :clang

  conf.cc.flags += %w[-DMRB_ARY_LENGTH_MAX=0 -DMRB_STR_LENGTH_MAX=0]

  conf.cc.command = "emcc"
  conf.cc.flags += %w[-O2]
  conf.linker.command = "emcc"
  conf.archiver.command = "emar"

  # These are the default libraries
  conf.gembox "stdlib"
  conf.gembox "stdlib-ext"
  conf.gembox "stdlib-io"
  conf.gembox "math"
  conf.gembox "metaprog"

  conf.gem core: "mruby-exit"
  conf.gem core: "mruby-sleep"
  conf.gem github: "iij/mruby-dir"
  conf.gem github: "iij/mruby-env"
  conf.gem github: "iij/mruby-iijson"
  conf.gem github: "iij/mruby-mtest"
  conf.gem github: "hellrok/mruby-regexp-pcre"
  conf.gem github: "hellrok/mruby-tiny-opt-parser"
  conf.gem github: "Asmod4n/mruby-uri-parser"
  conf.gem github: "matsumotory/mruby-simplehttp"
  conf.gem github: "mattn/mruby-base64"
  conf.gem github: "mattn/mruby-require"
end
