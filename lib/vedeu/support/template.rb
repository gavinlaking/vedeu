require 'erb'

module Vedeu

  # Generic class to loading a template and parsing it via ERb.
  #
  class Template

    def self.parse(object, path)
      new(object, path).parse
    end

    def initialize(object, path)
      @object, @path = object, path
    end

    def parse
      ERB.new(load, nil, '-').result(binding)
    end

    private

    attr_reader :object, :path

    def load
      File.read(path)
    end

  end # Template

end # Vedeu
