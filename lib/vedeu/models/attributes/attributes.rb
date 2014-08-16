module Vedeu
  module Attributes
    extend self

    def coercer(values, model, key)
      return [] if values.nil? || values.empty?

      [values].flatten.map do |value|
        if value.is_a?(model)
          value

        else
          model.new(value)

        end
      end
    end

    def coerce_styles(values)
      return '' if values.nil? || values.empty?

      Array(values).flatten.map { |value| Esc.string(value) }.join
    end
  end
end
