module Vedeu
  class MenuParser
    def self.parse(menu)
      new(menu).parse
    end

    def initialize(menu)
      @menu = menu
    end

    def parse
      { interfaces: interface }
    end

    private

    attr_reader :menu

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
      menu.last
    end

    def name
      menu.first
    end
  end
end
