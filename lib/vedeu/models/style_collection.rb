require 'virtus'

require_relative '../support/cursor'
require_relative '../support/esc'

module Vedeu
  class StyleCollection < Virtus::Attribute
    def coerce(values)
      return '' if values.nil? || values.empty?

      if values.is_a?(::Array)
        values.map { |value| Esc.stylize(value) }.join

      elsif values.is_a?(::String)
        Esc.stylize(values)

      end
    end
  end
end
