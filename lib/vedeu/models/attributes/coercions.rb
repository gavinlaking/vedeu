module Vedeu
  module Coercions
    module ClassMethods

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
