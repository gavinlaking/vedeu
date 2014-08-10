module Vedeu
  module Collection
    extend self

    def coercer(value, model, key)
      return [] if value.nil? || value.empty?

      [value].flatten.map { |v| model.new(v) }
    end
  end
end
