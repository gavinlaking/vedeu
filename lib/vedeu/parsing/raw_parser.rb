require 'vedeu/parsing/text_adaptor'

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
          lines: TextAdaptor.adapt(content)
        }
      end
    end

    def stringified_keys
      attributes.inject({}) { |a, (k, v)| a[k.to_s] = v; a }
    end
  end
end
