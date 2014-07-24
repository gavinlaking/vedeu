require 'vedeu/parsing/text_adaptor'

module Vedeu
  class HashParser
    # Convert a hash into a collection of interfaces.
    #
    # @param output [Hash] a collection of interface pairs of the
    #   format:
    #
    #   {
    #     interface_1: "A block of text containing\n" \
    #                  "new line characters.\n",
    #     interface_2: "Some content destined for the " \
    #                  "other interface.\n"
    #   }
    #
    #   becomes:
    #
    #   {
    #     interfaces: [
    #       {
    #         name:  'interface_1',
    #         lines: [{
    #             streams: { text: "A block of text containing" }
    #           }, {
    #             streams: { text: "new line characters." }
    #         }]
    #       }, {
    #         name:  'interface_2',
    #         lines: [{
    #             streams: { text: "Some content destined for the " \
    #                              "other interface." }
    #         }]
    #       }
    #     ]
    #   }
    #
    # @return [Hash]
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
