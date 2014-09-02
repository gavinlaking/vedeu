module Vedeu
  module Coercions
    module ClassMethods

      include Vedeu::Common

      # Produces new objects of the correct class from attributes hashes,
      # ignores objects that have already been coerced.
      # When provided with a parent argument, will allow the new object to know
      # the colour and style of its parent.
      #
      # @param values [Array|Hash]
      # @param parent [Object|Nil]
      # @return [Array]
      def coercer(values, parent = nil)
        return [] unless defined_value?(values)

        [values].flatten.map do |value|
          if value.is_a?(self)
            value

          else
            self.new(value.merge!({ parent: parent }))

          end
        end
      end
    end

    # Whenever this module is included in another class or module, make its
    # methods into class methods, so they may be called directly.
    def self.included(receiver)
      receiver.extend(ClassMethods)
    end

  end
end
