MRuby::CrossBuild.new("emscripten") do |conf|
  toolchain :clang

  conf.cc.flags += %w[-DMRB_ARY_LENGTH_MAX=0 -DMRB_STR_LENGTH_MAX=0]

  conf.cc.command = "emcc"
  conf.cc.flags += %w[-O2]
  conf.linker.command = "emcc"
  conf.archiver.command = "emar"

  conf.gembox File.expand_path('taylor', File.dirname(__FILE__))
end
