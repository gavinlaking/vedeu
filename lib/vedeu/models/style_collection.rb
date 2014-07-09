require 'virtus'

require_relative '../support/esc'

module Vedeu
  class StyleCollection < Virtus::Attribute
    def coerce(values)
      return '' if values.nil? || values.empty?

      if values.is_a?(::Array)
        values.map { |value| Esc.string(value) }.join

      elsif values.is_a?(::String)
        Esc.string(values)

      end
    end
  end
end
