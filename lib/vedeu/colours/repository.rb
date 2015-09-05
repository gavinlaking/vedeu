module Vedeu

  module Colours

    # Allows the storing of HTML/CSS colours and their respective escape
    # sequences.
    #
    class Repository

      # @!attribute [r] storage
      # @return [Hash<String => String>]
      attr_reader :storage

      # Returns a new instance of Vedeu::Colours::Repository.
      #
      # @return [Vedeu::Colours::Repository]
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
      # @param colour [String]
      # @return [Boolean]
      def registered?(colour)
        return false unless colour

        storage.key?(colour)
      end

      # Removes all stored colours.
      #
      # @return [Hash]
      def reset!
        storage.clear
      end

      # Retrieves the escape sequence of a registered colour.
      #
      # @return [String]
      def retrieve(colour)
        storage.fetch(colour, '')
      end

      # Retrieves the escape sequence of a registered colour, or registers the
      # colour with its respective escape sequence.
      #
      # @return [String]
      def retrieve_or_register(colour, escape_sequence)
        if registered?(colour)
          retrieve(colour)

        else
          register(colour, escape_sequence)

        end
      end

    end # Repository

  end # Colours

end # Vedeu
