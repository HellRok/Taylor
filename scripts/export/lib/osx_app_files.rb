# We only have this installed in dev and for OSX exports
begin
  require "plist"
rescue LoadError
end

module Osx
  module PkgInfo
    def self.generate(path)
      File.write(File.join(path, "..", "PkgInfo"), "APPL????APPL????")
    end
  end

  module Plist
    def self.generate(path, config)
      File.write(
        File.join(path, "..", "Info.plist"),
        {
          CFBundleExecutable: config.name,
          CFBundleGetInfoString: "#{config.name} #{config.version}",
          CFBundleVersion: config.version,
          CFBundleShortVersionString: config.version
        }.to_plist
      )
    end
  end
end
