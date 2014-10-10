module Vedeu

  # When the client application has defined interfaces to be used, the Registrar
  # stores these interfaces into various repositories for later use.
  #
  # @api private
  class Registrar

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
      Vedeu::Buffers.add(attributes)

      Vedeu::Offsets.add(attributes)

      Vedeu::Interfaces.add(attributes)

      Vedeu::Cursors.add(attributes)

      Vedeu::Groups.add(attributes)

      Vedeu::Focus.add(attributes)

      true
    end

    private

    attr_reader :attributes

  end # Registrar

end # Vedeu
