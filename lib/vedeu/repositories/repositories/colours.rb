module Vedeu

  # Allows the storing of HTML/CSS colours and their respective escape
  # sequences.
  #
  class Colours

    # @!attribute [r] storage
    # @return [Hash<String => String>]
    attr_reader :storage

    # Returns a new instance of Vedeu::Colours.
    #
    # @return [Vedeu::Colours]
    def initialize
      @storage = {}
    end

    # Registers a colour with respective escape sequence.
    #
    # @return [String]
    def register(colour, escape_sequence)
      storage.store(colour, escape_sequence)
    end

    # Returns a boolean indicating whether the colour has been registered.
    #
    # @return [Boolean]
    def registered?(colour)
      storage.key?(colour)
    end

    # Removes all stored colours.
    #
    # @return [Hash]
    def reset!
      storage.clear
    end

    # Retrieves a registered colour.
    #
    # @return [String]
    def retrieve(colour)
      storage.fetch(colour, '')
    end

    # Retrieves a registered colour, or registers the colour with its respective
    # escape sequence.
    #
    # @return [String]
    def retrieve_or_register(colour, escape_sequence)
      if registered?(colour)
        retrieve(colour)

      else
        register(colour, escape_sequence)

      end
    end

  end # Colours

end # Vedeu
