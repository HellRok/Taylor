require_relative "builder"
require_relative "helpers"

class AndroidBuilder < Builder
  def setup_platform
    @name = "libmain.so"
    @platform = "android"
    @cxx = "aarch64-linux-android29-clang++"
    @cxxflags = <<-EOS.chomp
      -Oz \
      -stdlib=libc++ \
      -fPIC \
      -ffunction-sections -funwind-tables -fstack-protector-strong \
      -no-canonical-prefixes \
      -static-libstdc++ \
      -D ANRDOID \
      -D ANDROID_API__29
    EOS
    @includes = "-I /ndk/android-ndk-r25b/sources/android/native_app_glue/"

    @static_links += [
      "-shared",
      "-l log",
      "-l android",
      "-l EGL",
      "-l GLESv2",
      "-l OpenSLES",
      "-l atomic",
      "-u ANativeActivity_onCreate",
      "-Wl,-soname,libmain.so",
      "./vendor/android/libmruby.a",
      "./vendor/android/raylib/lib/libraylib.a",
      "/ndk/android-ndk-r25b/sources/android/native_app_glue/android_native_app_glue"
    ]
  end

  def name
    "libmain.so"
  end

  def apk_name(final: false)
    "#{@options["name"]}#{"-unzipped" unless final}.apk"
  end
end

builder = AndroidBuilder.new
Builder.register(builder)

namespace :android do
  multitask build_depends: builder.depends
  multitask build_objects: builder.objects
  task build: builder.build_dependencies
  desc "Build for android in debug mode"
  task build: "build:android:debug"

  namespace :release do
    task :strip do
      sh <<-CMD
        /ndk/android-ndk-r25b/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-strip \
          "./dist/#{builder.platform}/#{builder.variant}/#{builder.name}"
      CMD
    end

    task :native_app_glue do
      sh <<-CMD
        aarch64-linux-android29-clang \
          -c /ndk/android-ndk-r25b/sources/android/native_app_glue/android_native_app_glue.c \
          -o /ndk/android-ndk-r25b/sources/android/native_app_glue/native_app_glue.o \
          -ffunction-sections \
          -funwind-tables \
          -fstack-protector-strong \
          -fPIC \
          -Wall \
          -Wformat \
          -Werror=format-security \
          -no-canonical-prefixes \
          -DANDROID \
          -DPLATFORM_ANDROID \
          -D__ANDROID_API__=29
      CMD
      sh <<-CMD
        llvm-ar rcs \
          /ndk/android-ndk-r25b/sources/android/native_app_glue/android_native_app_glue.a \
          /ndk/android-ndk-r25b/sources/android/native_app_glue/native_app_glue.o
      CMD
    end
    task build: :native_app_glue

    multitask build_depends: builder.depends("release")
    multitask build_objects: builder.objects("release")
    task build: builder.build_dependencies
    task build: "build:android:release"

    task :build_apk do
      sh <<-CMD
        mkdir -p android/build/dex
        mkdir -p android/build/res
        mkdir -p android/build/res/drawable-ldpi/
        mkdir -p android/build/src
        mkdir -p android/build/lib/arm64-v8a/
      CMD

      # Generate key, probably not needed here? Should just be a helper command
      sh <<-CMD
       # keytool -genkeypair -validity 1000 -dname "CN=raylib,O=Android,C=ES" -keystore raylib.keystore -storepass 'raylib' -keypass 'raylib' -alias projectKey -keyalg RSA
       # keytool -genkey -v \
       #   -noprompt \
       #   -dname "CN=app.taylor.com" \
       #   -keystore /app/game/raylib.keystore \
       #   -storepass buttsbuttsbutts \
       #   -keyalg RSA \
       #   -keysize 2048 \
       #   -validity 10000 \
       #   -alias app
      CMD

      sh <<-CMD
        cp scripts/android/check.png android/build/res/drawable-ldpi/icon.png
        aapt package -f -m \
          -S android/build/res \
          -J android/build/src \
          -M /app/taylor/scripts/android/AndroidManifest.xml \
          -I /sdk/platforms/android-29/android.jar
      CMD

      sh <<-CMD
        javac -verbose -source 1.8 -target 1.8 -d android/build/obj \
          -bootclasspath jre/lib/rt.jar \
          -classpath /sdk/platforms/android-29/android.jar:android/build/obj \
          -sourcepath src android/build/src/com/raylib/game/R.java \
          /app/taylor/scripts/android/NativeLoader.java
      CMD

      sh <<-CMD
        dx --verbose --dex --output=android/build/dex/classes.dex android/build/obj
      CMD

      sh <<-CMD
        mkdir /app/game/tmp_assets
        mv /app/game/assets /app/game/tmp_assets/
        mv /app/game/tmp_assets /app/game/assets
      CMD

      sh <<-CMD
        mkdir /app/game/exports/android/
        aapt package -f \
          -M /app/taylor/scripts/android/AndroidManifest.xml \
          -S android/build/res \
          -A /app/game/assets \
          -I /sdk/platforms/android-29/android.jar \
          -F /app/game/exports/android/#{builder.apk_name} android/build/dex

        mv /app/taylor/dist/android/release/#{builder.name} /app/taylor/android/build/lib/arm64-v8a/libmain.so

        cd /app/taylor/android/build
        aapt add /app/game/exports/android/#{builder.apk_name} lib/arm64-v8a/libmain.so
        cd -
      CMD

      sh <<-CMD
        #jarsigner -keystore android/raylib.keystore -storepass raylib -keypass raylib \
        #  -signedjar android/#{builder.apk_name} android/#{builder.apk_name} projectKey

        zipalign -f 4 /app/game/exports/android/#{builder.apk_name} /app/game/exports/android/#{builder.apk_name(final: true)}
        rm /app/game/exports/android/#{builder.apk_name}
      CMD

      sh <<-CMD
        apksigner sign \
          --ks-key-alias app \
          --ks /app/game/raylib.keystore \
          --ks-pass pass:buttsbuttsbutts \
          --key-pass pass:buttsbuttsbutts \
          /app/game/exports/android/#{builder.apk_name(final: true)}
      CMD
    end

    desc "Build for android in release mode"
    task build: :build_apk
  end
end
