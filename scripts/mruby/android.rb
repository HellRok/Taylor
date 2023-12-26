# Requires Android NDK r13 or later.
MRuby::CrossBuild.new("android") do |conf|
  params = {
    arch: "arm64-v8a",
    sdk_version: 29,
    toolchain: :clang
  }
  toolchain :android, params

  conf.cc.flags += %w[-DMRB_ARY_LENGTH_MAX=0 -DMRB_STR_LENGTH_MAX=0]
  conf.cc.flags += %w[-O2]

  conf.gembox File.expand_path('taylor', File.dirname(__FILE__))
end
