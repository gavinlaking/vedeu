module Vedeu

  # When the client application has defined an interface to be used, the
  # Registrar stores the attributes into various repositories for later use.
  #
  # @api private
  class Registrar

    REPOSITORIES = [Buffers, Cursors, Focus, Groups, Interfaces]

    # @param attributes [Hash]
    # @return [TrueClass|MissingRequired]
    def self.record(attributes = {})
      new(attributes).record
    end

    # Removes all entities from all repositories. Use with caution.
    #
    # @return [TrueClass]
    def self.reset!
      REPOSITORIES.each { |repository| repository.reset }

      true
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
      REPOSITORIES.each { |repository| repository.add(attributes) }

      true
    end

    private

    attr_reader :attributes

  end # Registrar

end # Vedeu
