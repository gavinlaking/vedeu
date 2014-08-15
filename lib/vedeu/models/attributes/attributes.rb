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

    def coerce_styles(values)
      return '' if values.nil? || values.empty?

      Array(values).flatten.map { |s| Esc.string(s) }.join
    end
  end
end
