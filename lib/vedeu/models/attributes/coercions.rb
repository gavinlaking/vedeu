module Vedeu
  module Coercions
    module ClassMethods

      # Produces new objects of the correct class from attributes hashes,
      # ignores objects that have already been coerced.
      # When provided with a parent argument, will allow the new object to
      # know who its daddy is.
      #
      # @param values [Array|Hash]
      # @param parent [Object|Nil]
      # @return [Array]
      def coercer(values, parent = nil)
        return [] if values.nil? || values.empty?

        [values].flatten.map do |value|
          if value.is_a?(self)
            value

          else
            self.new(value.merge!({ parent: parent }))

          end
        end
      end
    end

    def self.included(receiver)
      receiver.extend(ClassMethods)
    end

  end
end
