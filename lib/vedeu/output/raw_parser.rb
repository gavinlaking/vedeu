require 'vedeu/output/text_adaptor'

module Vedeu
  class RawParser
    def self.parse(attributes)
      new(attributes).parse
    end

    def initialize(attributes)
      @attributes = attributes
    end

    def parse
      { interfaces: interfaces }
    end

    private

    attr_reader :attributes

    def interfaces
      stringified_keys.map do |name, content|
        {
          name:  name,
          lines: lines(content)
        }
      end
    end

    def lines(content)
      if content.is_a?(Array) && content.first.is_a?(Hash)
        content
      else
        TextAdaptor.adapt(content)
      end
    end

    def stringified_keys
      attributes.inject({}) { |a, (k, v)| a[k.to_s] = v; a }
    end
  end
end
