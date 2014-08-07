require 'vedeu/models/composition'
require 'vedeu/output/dsl_parser'
require 'vedeu/output/json_parser'

module Vedeu
  class View
    def self.render(type, output)
      new(type, output).render
    end

    def initialize(type, output)
      @type, @output = type, output
    end

    def render
      Composition.enqueue(parsed_output)
    end

    private

    attr_reader :type, :output

    def parsed_output
      @parsed ||= parser.parse(output)
    end

    def parser
      {
        dsl:     DSLParser,
        json:    JSONParser,
      }.fetch(type)
    end
  end
end
