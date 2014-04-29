module Vedeu
  module Composition
    class Row
      def self.render(rows)
        new(rows).render
      end

      def initialize(rows)
        @rows = rows
      end

      def render
        parsed.join(eol)
      end

      private

      attr_reader :rows

      def eol
        "\n"
      end

      def parsed
        container = []
        streams = []
        rows.map do |row|
          row.map do |stream|
            streams << if stream.is_a?(Array)
              Colours::Colour.set(stream)
            elsif stream.is_a?(Symbol)
              Colours::Colour.set(Array(stream))
            else
              stream
            end
          end
          container << streams.join
          streams = []
        end
        container
      end
    end
  end
end
