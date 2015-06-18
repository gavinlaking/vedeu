#!/usr/bin/env ruby

# require 'vedeu'

module YourAppName

  class Application

    def self.start(argv = ARGV)
      new(argv).start
    end

    def initialize(argv)
      @argv = argv
    end

    def start
      [:configuration_path,
       :interface_path,
       :keymap_path].each do |path|
        load(path)
      end

      Vedeu::Launcher.execute!(argv)
    end

    protected

    attr_reader :argv

    private

    def configuration_path
      File.dirname(__FILE__) + '/config/**/*'
    end

    def interface_path
      File.dirname(__FILE__) + '/app/views/interfaces/**/*'
    end

    def keymap_path
      File.dirname(__FILE__) + '/app/models/keymaps/**/*'
    end

    def load(path)
      files = send(path)

      Dir.glob(files).select do |file|
        File.file?(file) && File.extname(file) == '.rb'
      end.each do |file|
        Kernel.load(file)
      end
    end

  end

end

YourAppName::Application.start(ARGV)
