require 'vedeu/models/composition'
require 'vedeu/parsing/erb_parser'
require 'vedeu/parsing/hash_parser'
require 'vedeu/parsing/json_parser'
require 'vedeu/parsing/menu_parser'

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
        hash:    HashParser,
        menu:    MenuParser,
      }.fetch(type)
    end
  end
end

# ERBParser:  { :interface, :path, :object }
# HashParser: { 'interface_name' => String|Array }
#             { :interface_name  => String|Array }
# JSONParser: output (string which is converted into a hash)
# MenuParser: ['interface_name', Vedeu::Menu instance]
