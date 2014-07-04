require 'oj'

require_relative '../models/composition'

module Vedeu
  class Parser
    class << self
      def parse(output)
        new(output).parse
      end
    end

    def initialize(output)
      @output = output || ''
    end

    def parse
      Composition.new(as_hash)
    end

    private

    attr_reader :output

    def as_hash
      Oj.load(output)
    end
  end
end

# {
#   interface: {
#     name: 'dummy',
#     lines: [{
#       streams: [{
#         text: 'Some text...'
#       }]
#     }]
#   }
# }

# 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
# 'Aliquam pellentesque metus id lacinia viverra. Cras malesuada'
# 'hendrerit neque, a pharetra risus posuere elementum. Ut felis elit,'
# 'semper vel ornare ut, vestibulum sit amet orci. Donec eu tortor.'
