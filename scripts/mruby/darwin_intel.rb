MRuby::CrossBuild.new("osx-intel") do |conf|
  toolchain :clang

  [conf.cc, conf.linker].each do |cc|
    cc.command = "x86_64-apple-darwin20.4-clang"
    cc.flags += %w[-O2 -mmacosx-version-min=10.11 -stdlib=libc++]
  end
  conf.cc.flags += %w[-DMRB_ARY_LENGTH_MAX=0 -DMRB_STR_LENGTH_MAX=0]

  conf.cxx.command = "x86_64-apple-darwin20.4-clang++"
  conf.archiver.command = "x86_64-apple-darwin20.4-ar"

  conf.build_target = "x86_64-pc-linux-gnu"
  conf.host_target = "x86_64-apple-darwin20.4"

  conf.gembox File.expand_path('taylor', File.dirname(__FILE__))
end
