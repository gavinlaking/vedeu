require 'vedeu/support/common'

module Vedeu

  # Provides means to convert attributes into the correct model.
  #
  # @api private
  module Coercions

    include Vedeu::Common

    # Produces new objects of the correct class from attributes hashes,
    # ignores objects that have already been coerced.
    #
    # @param values [Array|Hash]
    # @return [Array]
    def coercer(values)
      return [] unless defined_value?(values)

      [values].flatten.map do |value|
        if value.is_a?(self)
          value

        else
          self.new(value)

        end
      end
    end

    # Whenever this module {Vedeu::Coercions} is included in another class or
    # module, make its methods into class methods, so they may be called
    # directly.
    #
    # @param receiver [Class] The class in which this module is included.
    # @return []
    def self.included(receiver)
      receiver.extend(self)
    end

  end # Coercions

end # Vedeu
