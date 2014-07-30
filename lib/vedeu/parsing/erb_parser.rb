require 'erb'
require 'vedeu/support/helpers'

module Vedeu
  class ERBParser
    include Helpers

    def self.parse(attributes = {})
      new(attributes).parse
    end

    def initialize(attributes = {})
      @attributes = attributes
    end

    def parse
      ERB.new(template, nil, '-', "@output").result(get_binding)
    end

    private

    attr_reader :attributes

    def template
      File.read(template_path)
    end

    def template_path
      attributes.fetch(:path)
    end

    def get_binding
      object.send(:binding)
    end

    def object
      attributes.fetch(:object)
    end
  end
end
