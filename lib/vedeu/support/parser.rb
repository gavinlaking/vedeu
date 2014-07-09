require_relative '../models/composition'
require_relative 'parsing/hash_parser'
require_relative 'parsing/json_parser'

module Vedeu
  class ParseError < StandardError; end

  class Parser
    def self.parse(output)
      new(output).parse
    end

    def initialize(output = {})
      @output = output
    end

    def parse
      return nil if empty?

      Composition.enqueue(parsed_output)
    end

    private

    attr_reader :output

    def parsed_output
      @parsed ||= parser.parse(output)
    end

    def parser
      return JSONParser if json?
      return HashParser if hash?

      fail ParseError, 'Cannot process output from command.'
    end

    def hash?
      output.is_a?(Hash)
    end

    def json?
      output.is_a?(String)
    end

    def empty?
      output.nil? || output.empty?
    end
  end
end
