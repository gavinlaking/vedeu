module Vedeu

  # When the client application has defined interfaces to be used, the Registrar
  # stores these interfaces into various repositories for later use.
  #
  # @api private
  class Registrar

    include Common

    # @param attributes [Hash]
    # @return [TrueClass|]
    def self.record(attributes = {})
      new(attributes).record
    end

    # @param attributes [Hash]
    # @return [Registrar]
    def initialize(attributes = {})
      @attributes = attributes
    end

    # Adds the attributes to a variety of repositories to use later.
    #
    # @return [TrueClass|MissingRequired]
    def record
      validate_attributes!

      Vedeu::Buffers.add(attributes)

      Vedeu::Interfaces.add(attributes)

      Vedeu::Groups.add(attributes)

      Vedeu::Focus.add(attributes)

      true
    end

    private

    # Client application defined settings for interfaces etc.
    attr_reader :attributes

    # At present, validates that attributes has a `:name` key that is not nil or
    # empty.
    #
    # @api private
    # @return [TrueClass|MissingRequired]
    def validate_attributes!
      return exception unless attributes.key?(:name)
      return exception unless defined_value?(attributes[:name])

      true
    end

    # Raises the MissingRequired exception.
    #
    # @see Vedeu::MissingRequired
    def exception
      fail MissingRequired, 'Cannot store data without a name attribute.'
    end

  end

end
