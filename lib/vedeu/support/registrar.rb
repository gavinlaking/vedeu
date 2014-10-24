module Vedeu

  # When the client application has defined an interface to be used, the
  # Registrar stores the attributes into various repositories for later use.
  #
  # @api private
  class Registrar

    # @param attributes [Hash]
    # @return [TrueClass|MissingRequired]
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
      [Buffers, Offsets, Interfaces, Cursors, Groups, Focus].map do |repository|
        repository.add(attributes)
      end

      true
    end

    private

    attr_reader :attributes

  end # Registrar

end # Vedeu
