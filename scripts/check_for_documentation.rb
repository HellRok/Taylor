#!/usr/bin/env ruby

def cpp_methods
  (
    Dir.glob('./src/mruby_integration/**/*.cpp') +
    Dir.glob('./src/web.cpp')
  ).flat_map { |file|
    klass = nil

    File.read(file).each_line.to_a.map { |line|
      if line =~ /^\s*class\s*(.*)/
        klass = $~[1].chomp
        nil # we don't want to just return the klass
      end

      if line =~ /^\s*mrb_define_method.*, (.*), "(.*)"/
        object, method = $~[1..2]
        if object == 'mrb->kernel_module'
          method
        else
          "#{object.gsub('_class', '')}##{method}"
        end

      elsif line =~ /^\s*def\s*(.*)/ && !line.include?('mrb_define_class')
        method = $~[1].split('(').first
        if klass
          "#{klass}##{method}"
        else
          method
        end
      end
    }.compact
  }
end

def documented_methods
  Dir.glob('./mrb_doc/**/*.rb').flat_map { |file|
    klass = nil

    File.read(file).each_line.to_a.map { |line|
      if line =~ /^\s*class\s*(.*)/
        klass = $~[1].chomp
        nil # we don't want to just return the klass

      elsif line =~ /^\s*def\s*(.*)/
        method = $~[1].split('(').first
        if klass
          "#{klass}##{method}"
        else
          method
        end
      end
    }.compact
  }
end

undocumented_methods = cpp_methods - documented_methods
not_coded_methods = documented_methods - cpp_methods

if undocumented_methods.any?
  puts "Found these methods without documentation:"
  undocumented_methods.each { |method| puts "\t- #{method}" }
end

if not_coded_methods.any?
  puts "Found these documented methods without any correlating code:"
  not_coded_methods.each { |method| puts "\t- #{method}" }
end

if undocumented_methods.any? || not_coded_methods.any?
  exit 1
else
  puts "All documentation seems to be in order!"
end
