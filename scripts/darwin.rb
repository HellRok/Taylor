MRuby::CrossBuild.new('x86_64-apple-darwin19') do |conf|
  toolchain :clang

  [conf.cc, conf.linker].each do |cc|
    cc.command = 'x86_64-apple-darwin19-clang'
    cc.flags  += %w[-Oz -mmacosx-version-min=10.11 -stdlib=libc++]
  end

  conf.cxx.command      = 'x86_64-apple-darwin19-clang++'
  conf.archiver.command = 'x86_64-apple-darwin19-ar'

  conf.build_target     = 'x86_64-pc-linux-gnu'
  conf.host_target      = 'x86_64-apple-darwin19'

  conf.gembox "default"
end
