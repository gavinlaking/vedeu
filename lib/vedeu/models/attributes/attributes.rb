module Vedeu
  module Attributes
    extend self

    # param values []
    # param model []
    # param key []
    #
    # return []
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

    # param values [String|Array]
    #
    # return [Array]
    def coerce_styles(values)
      return '' if values.nil? || values.empty?

      Array(values).flatten.map { |value| Esc.string(value) }.join
    end
  end
end
