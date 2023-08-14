MRuby::CrossBuild.new("x86_64-apple-darwin20.4") do |conf|
  toolchain :clang

  [conf.cc, conf.linker].each do |cc|
    cc.command = "x86_64-apple-darwin20.4-clang"
    cc.flags += %w[-Oz -mmacosx-version-min=10.11 -stdlib=libc++]
  end
  conf.cc.flags += %w[-DMRB_ARY_LENGTH_MAX=0 -DMRB_STR_LENGTH_MAX=0]

  conf.cxx.command = "x86_64-apple-darwin20.4-clang++"
  conf.archiver.command = "x86_64-apple-darwin20.4-ar"

  conf.build_target = "x86_64-pc-linux-gnu"
  conf.host_target = "x86_64-apple-darwin20.4"

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
  conf.gem github: "katzer/mruby-tiny-opt-parser"
  conf.gem github: "Asmod4n/mruby-uri-parser"
  conf.gem github: "matsumotory/mruby-simplehttp"
  conf.gem github: "matsumotory/mruby-simplehttpserver"
  conf.gem github: "mattn/mruby-base64"
  conf.gem github: "mattn/mruby-require"
end
