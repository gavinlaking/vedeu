require 'vedeu/models/composition'
require 'vedeu/output/erb_parser'
require 'vedeu/output/raw_parser'
require 'vedeu/output/json_parser'
require 'vedeu/output/menu_parser'
require 'vedeu/output/raw_parser'

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
        erb:     ERBParser,
        json:    JSONParser,
        hash:    RawParser,
        menu:    MenuParser,
        raw:     RawRarser,
      }.fetch(type)
    end
  end
end

# ERBParser:  { :interface, :path, :object }
# RawParser: { 'interface_name' => String|Array }
#             { :interface_name  => String|Array }
# JSONParser: output (string which is converted into a hash)
# MenuParser: ['interface_name', Vedeu::Menu instance]
