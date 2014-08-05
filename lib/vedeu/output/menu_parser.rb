module Vedeu
  class MenuParser
    def self.parse(args)
      new(args).parse
    end

    def initialize(args)
      @args = args
    end

    def parse
      { interfaces: interface }
    end

    private

    attr_reader :args

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
      args.last
    end

    def name
      args.first
    end
  end
end
