require 'erb'
require 'vedeu/output/helpers'

module Vedeu
  class Template
    include Helpers

    def self.parse(path, object)
      new(path, object).parse
    end

    def initialize(path, object)
      @path, @object = path, object
    end

    def parse
      ERB.new(load, nil, '-').result(binding)
    end

    private

    attr_reader :object, :path

    def load
      File.read(File.dirname(__FILE__) + path)
    end
  end
end
