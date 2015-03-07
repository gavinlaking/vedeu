require 'erb'

module Vedeu

  # Generic class to loading a template and parsing it via ERb.
  #
  class Template

    # @param object [Class]
    # @param path [String]
    # @return [void]
    def self.parse(object, path)
      new(object, path).parse
    end

    # @param object [Class]
    # @param path [String]
    # @return [Template]
    def initialize(object, path)
      @object, @path = object, path
    end

    # @return [void]
    def parse
      ERB.new(load, nil, '-').result(binding)
    end

    private

    # @!attribute [r] object
    # @return [Class]
    attr_reader :object

    # @!attribute [r] path
    # @return [String]
    attr_reader :path

    # @return [String]
    def load
      File.read(path)
    end

  end # Template

end # Vedeu
