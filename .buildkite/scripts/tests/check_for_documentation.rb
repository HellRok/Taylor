#!/usr/bin/env ruby

IGNORED_FILES = [
  "./src/mruby_integration/buildkite_analytics.cpp",
  "./src/platform_specific/web.cpp"
]

def cpp_methods
  (
    Dir.glob("./src/mruby_integration/**/*.cpp") +
    Dir.glob("./src/platform_specific/*.cpp") +
    Dir.glob("./src/*.cpp")
  ).reject { |file|
    IGNORED_FILES.include?(file)
  }.flat_map { |file|
    klass = nil

    lines = File.read(file).each_line.to_a
    lines.map.with_index { |line, index|
      if line =~ /^\s*class\s*(.*)/
        klass = $~[1].chomp
        nil # we don't want to just return the klass
      end

      # mrb_define_method(mrb, Font_class, "initialize"
      if line =~ /^\s*mrb_define_method.*, (.*), "(.*)"/
        object, method = $~[1..2]
        if object == "mrb->kernel_module"
          method
        else
          "#{object.gsub("_class", "")}##{method}"
        end

      elsif /^\s*mrb_define_method/.match?(line)
        # mrb_define_method(
        #   mrb, Font_class, "initialize"
        if lines[index + 1] =~ /\s*mrb, (.*), "(.*)"/
          object, method = $~[1..2]

        # mrb_define_method(mrb,
        #                   Font_class,
        #                   "initialize"
        else
          object = lines[index + 1].strip.delete(",")
          method = lines[index + 2].strip.delete(",").delete('"')
        end

        if object == "mrb->kernel_module"
          method
        else
          "#{object.gsub("_class", "")}##{method}"
        end

      elsif line =~ /^\s*mrb_define_class_method.*, (.*), "(.*)"/
        object, method = $~[1..2]
        if object == "mrb->kernel_module"
          method
        else
          "#{object.gsub("_class", "")}.#{method}"
        end

      elsif line =~ /^\s*def\s+(.*)/ && !line.include?("mrb_define_class")
        method = $~[1].split("(").first
        if klass
          if method.start_with?("self.")
            method.slice!("self.")
            "#{klass}.#{method}"
          else
            "#{klass}##{method}"
          end
        else
          method
        end
      end
    }.compact
  }
end

def documented_methods
  Dir.glob("./mrb_doc/**/*.rb")
    .reject { |file|
      IGNORED_FILES.include?(file)
    }.flat_map { |file|
      klass = nil

      File.read(file).each_line.to_a.map { |line|
        if line =~ /^\s*class\s*(.*)/
          klass = $~[1].chomp
          nil # we don't want to just return the klass

        elsif line =~ /^\s*def\s*(.*)/
          method = $~[1].split("(").first
          if klass
            if method.start_with?("self.")
              method.slice!("self.")
              "#{klass}.#{method}"
            else
              "#{klass}##{method}"
            end
          else
            method
          end
        end
      }.compact
    }
end

undocumented_methods = cpp_methods - documented_methods
not_coded_methods = documented_methods - cpp_methods
overlap = cpp_methods & documented_methods

puts "These methods are documented:"
overlap.sort.each { |method| puts "\t✓ #{method}" }

if undocumented_methods.any?
  puts "Found these methods without documentation:"
  undocumented_methods.sort.each { |method| puts "\t✗ #{method}" }
end

if not_coded_methods.any?
  puts "Found these documented methods without any correlating code:"
  not_coded_methods.sort.each { |method| puts "\t✗ #{method}" }
end

if undocumented_methods.any? || not_coded_methods.any?
  exit 1
else
  puts "All #{overlap.size} methods are documented!"
end
