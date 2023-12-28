MRuby::Build.new do |conf|
  conf.toolchain

  conf.cc.flags += %w[-DMRB_ARY_LENGTH_MAX=0 -DMRB_STR_LENGTH_MAX=0]
  conf.cc.flags += %w[-O2]

  # Generate mrbc command
  conf.gem core: "mruby-bin-mrbc"

  conf.gembox File.expand_path("taylor", File.dirname(__FILE__))
end
