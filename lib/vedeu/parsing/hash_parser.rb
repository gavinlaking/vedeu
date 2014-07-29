require 'vedeu/parsing/text_adaptor'

module Vedeu
  class HashParser
    def self.parse(output = {})
      new(output).parse
    end

    def initialize(output = {})
      @output = output
    end

    def parse
      { interfaces: interfaces }
    end

    private

    attr_reader :output

    def interfaces
      stringified_keys.map do |name, content|
        {
          name:  name,
          lines: TextAdaptor.adapt(content)
        }
      end
    end

    def stringified_keys
      output.inject({}) { |a, (k, v)| a[k.to_s] = v; a }
    end
  end
end
