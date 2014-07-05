require 'oj'

require_relative '../models/composition'

module Vedeu
  class Parser
    def self.parse(output)
      new(output).parse
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
      Oj.load(output, symbol_keys: true)
    end
  end
end
