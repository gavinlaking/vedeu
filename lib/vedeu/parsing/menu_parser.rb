module Vedeu
  class MenuParser
    # Convert a Vedeu::Menu into an interface view.
    #
    # @param output [Hash] a key/value pair.
    #
    # @return [Hash]
    def self.parse(output = {})
      new(output).parse
    end

    def initialize(output = {})
      @output = output
    end

    def parse
      { interfaces: interface }
    end

    private

    attr_reader :output

    def interface
      { name: name, lines: lines }
    end

    def lines
      lines = []
      items.each do |sel, cur, item|
        if sel && cur
          lines << { streams: { text: "*> #{item}" } }

        elsif cur
          lines << { streams: { text: " > #{item}" } }

        elsif sel
          lines << { streams: { text: "*  #{item}" } }

        else
          lines << { streams: { text: "   #{item}" } }

        end
      end
      lines
    end

    def items
      output.last
    end

    def name
      output.first
    end
  end
end
