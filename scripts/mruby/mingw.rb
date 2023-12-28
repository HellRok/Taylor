MRuby::CrossBuild.new("windows") do |conf|
  conf.toolchain :gcc

  conf.cc.flags += %w[-DMRB_ARY_LENGTH_MAX=0 -DMRB_STR_LENGTH_MAX=0]

  conf.host_target = "x86_64-w64-mingw32"  # required for `for_windows?` used by `mruby-socket` gem

  conf.cc.command = "#{conf.host_target}-gcc-posix"
  conf.cc.flags += %w[-O2]
  conf.linker.command = conf.cc.command
  conf.archiver.command = "#{conf.host_target}-gcc-ar"
  conf.exts.executable = ".exe"

  conf.gembox File.expand_path("taylor", File.dirname(__FILE__))
end
