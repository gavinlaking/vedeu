#!/usr/bin/env ruby

# Find all methods which don't have corresponding test method, or all test
# methods without corresponding method. Produces quite a few false positives,
# but useful for a quick check.

source_files = Dir.glob("lib/vedeu/**/*.rb")
test_files   = Dir.glob("test/lib/vedeu/**/*_test.rb")

test_files.each do |test_file|
  source_file = test_file.gsub(/^test\/|_test/, '')
  if File.exist?(source_file)
    source_defs = File.readlines(source_file).select { |line| line[/def /] }.map(&:lstrip).map do |line|
      line.chomp!
      line.gsub!(/^def /, '')
      line.gsub(/\(.*/, '')
    end

    defs = File.readlines(test_file).select { |line| line[/describe /] }.map(&:lstrip).map do |line|
      line.chomp!
      line.gsub!(/^describe /, '')
      line.gsub!(/ do$/, '')
    end
    test_defs = defs.keep_if { |line| line =~ /\'/ }.map { |line| line.gsub!(/\'|#|\./, '') }

    unless (test_defs - source_defs).empty?
      puts "\e[33m#{test_file} \e[31m(test without source)\e[39m\n #{(test_defs - source_defs).inspect}"
    end

    unless (source_defs - test_defs).empty?
      puts "\e[34m#{source_file} \e[31m(source without test)\e[39m\n #{(source_defs - test_defs).inspect}"
    end

    puts

  else
    puts "#{test_file} has no matching source file."

  end
end


