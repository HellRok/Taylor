def build_docker(file, path: ".", tags: [], export: false, pull: true)
  pull = false if ENV["NO_DOCKER_PULL"] == "true"

  tag_flags = tags.map { |tag| "--tag #{tag}" }.join(" ")

  if export
    sh "docker build --output ./ #{path} --file #{file} #{tag_flags}"
  else
    sh "docker build #{path} --file #{file} #{"--pull" if pull}  #{tag_flags}"
  end
end

namespace :docker do
  namespace :build do
    desc "Build all docker images required for building and export Taylor projects"
    task all: [:all_bases, "docker:build:export:all"]
    task all_bases: [:android, :linux, :windows, :osx, :web]

    desc "Build the docker image for producing production Android builds"
    task :android do
      build_docker("./scripts/docker/Dockerfile.android", tags: ["taylor/build-android"])
    end

    desc "Build the docker image for producing production Linux builds"
    task :linux do
      build_docker("./scripts/docker/Dockerfile.linux", tags: ["taylor/build-linux"])
    end

    desc "Build the docker image for producing production Windows builds"
    task :windows do
      build_docker("./scripts/docker/Dockerfile.windows", tags: ["taylor/build-windows"])
    end

    desc "Build the docker image for producing production OSX builds"
    task :osx do
      build_docker("./scripts/docker/Dockerfile.osx", tags: ["taylor/build-osx"])
    end

    desc "Build the docker image for producing production Web builds"
    task :web do
      build_docker("./scripts/docker/Dockerfile.web", tags: ["taylor/build-web"])
    end

    namespace :export do
      task base: "docker:build:linux"
      task :base do
        build_docker("Dockerfile.export", tags: ["taylor/export"], pull: false)
      end

      task android: "docker:build:export:base"
      task android: "docker:build:android"
      task :android do
        build_docker(
          "./scripts/export/Dockerfile.android",
          path: "./scripts/export",
          pull: false,
          tags: ["hellrok/taylor:android-v#{VERSION}", "hellrok/taylor:android-latest"]
        )
      end

      task linux: "docker:build:export:base"
      task linux: "docker:build:linux"
      task :linux do
        build_docker(
          "./scripts/export/Dockerfile.linux",
          path: "./scripts/export",
          pull: false,
          tags: ["hellrok/taylor:linux-v#{VERSION}", "hellrok/taylor:linux-latest"]
        )
      end

      task windows: "docker:build:export:base"
      task windows: "docker:build:windows"
      task :windows do
        build_docker(
          "./scripts/export/Dockerfile.windows",
          path: "./scripts/export",
          pull: false,
          tags: ["hellrok/taylor:windows-v#{VERSION}", "hellrok/taylor:windows-latest"]
        )
      end

      task osx: "docker:build:export:base"
      task osx: "docker:build:osx"
      task :osx do
        build_docker(
          "./scripts/export/Dockerfile.osx",
          path: "./scripts/export",
          pull: false,
          tags: ["hellrok/taylor:osx-v#{VERSION}", "hellrok/taylor:osx-latest"]
        )
      end

      task web: "docker:build:export:base"
      task web: "docker:build:web"
      task :web do
        build_docker(
          "./scripts/export/Dockerfile.web",
          path: "./scripts/export",
          pull: false,
          tags: ["hellrok/taylor:web-v#{VERSION}", "hellrok/taylor:web-latest"]
        )
      end

      task all: [:android, :linux, :windows, :osx, :web]
    end

    desc "Build the mruby dependency inside docker"
    task mruby: "docker:build:all_bases"
    task :mruby do |task|
      sh "rm -rf ./vendor/mruby"
      build_docker("./scripts/mruby/Dockerfile.mruby", tags: ["taylor/mruby"], export: true)
      sh "mv ./vendor/mruby/mruby/mruby.h ./vendor/mruby/mruby/mrbconf.h ./vendor/mruby"
    end

    desc "Build the raylib dependency inside docker"
    task raylib: "docker:build:all_bases"
    task :raylib do |task|
      build_docker("./scripts/raylib/Dockerfile.raylib", tags: ["taylor/raylib"], export: true)
    end
  end
end
