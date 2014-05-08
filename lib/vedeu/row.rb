module Vedeu
  class Row < Composition
    def self.render(rows)
      new(rows).render
    end

    def initialize(rows)
      @rows = rows
    end

    def render
      parsed.join("\n")
    end

    private

    attr_reader :rows

    def parsed
      container = []
      streams = []
      rows.map do |row|
        row.map do |stream|
          streams << if stream.is_a?(Array)
            Output::Mask.set(stream)
          elsif stream.is_a?(Symbol)
            Output::Mask.set(Array(stream))
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
