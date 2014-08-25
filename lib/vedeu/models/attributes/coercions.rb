module Vedeu
  module Coercions
    module ClassMethods

      # Produces new objects of the correct class from attributes hashes,
      # ignores objects that have already been coerced.
      #
      # @param values [Array|Hash]
      # @return [Array]
      def coercer(values)
        return [] if values.nil? || values.empty?

        [values].flatten.map do |value|
          if value.is_a?(self)
            value

          else
            self.new(value)

          end
        end
      end
    end

    def self.included(receiver)
      receiver.extend(ClassMethods)
    end

  end
end
