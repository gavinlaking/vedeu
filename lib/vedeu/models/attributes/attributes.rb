module Vedeu
  module Attributes
    extend self

    def coercer(value, model, key)
      return [] if value.nil? || value.empty?

      [value].flatten.map do |v|
        if v.is_a?(model)
          v

        else
          model.new(v)

        end
      end
    end

    def coerce_styles(value_or_values)
      return '' if value_or_values.nil? || value_or_values.empty?

      if value_or_values.is_a?(::Array)
        value_or_values.map { |s| Esc.string(s) }.join

      else
        Esc.string(value_or_values)

      end
    end
  end
end
