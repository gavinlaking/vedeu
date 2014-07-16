module Vedeu
  module Collection
    extend self

    def coercer(value, model, key)
      return [] if value.nil? || value.empty?

      if value.is_a?(::String)
        [model.new({ key => value })]

      else
        [value].flatten.map { |v| model.new(v) }

      end
    end
  end
end
