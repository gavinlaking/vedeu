module Vedeu
  class Style < Virtus::Attribute
    def coerce(value_or_values)
      return '' if value_or_values.nil? || value_or_values.empty?

      if value_or_values.is_a?(::Array)
        value_or_values.map { |s| Esc.string(s) }.join

      else
        Esc.string(value_or_values)

      end
    end
  end
end
