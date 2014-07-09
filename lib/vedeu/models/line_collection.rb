require 'virtus'

require_relative 'line'

module Vedeu
  class InvalidLine < StandardError; end

  class LineCollection < Virtus::Attribute
    def coerce(values)
      return [] if values.nil? || values.empty?

      if values.is_a?(::String)
        [Line.new({ streams: values })]

      else
        [values].flatten.map { |value| Line.new(value) }

      end
    end
  end
end
