require 'virtus'

require_relative 'line'
require_relative 'coercions'

module Vedeu
  class InvalidLine < StandardError; end

  class LineCollection < Virtus::Attribute
    include Coercions

    def coerce(values)
      return [] if empty?(values)

      if multiple?(values)
        values.map { |v| Line.new(v) }

      elsif single?(values)
        [Line.new(values)]

      elsif just_text?(values)
        [Line.new({ streams: values })]

      end
    end
  end
end
