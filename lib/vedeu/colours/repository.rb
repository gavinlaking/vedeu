# frozen_string_literal: true

module Vedeu

  module Colours

    # Allows the storing of HTML/CSS colours and their respective
    # escape sequences.
    #
    # @api private
    #
    class Repository

      # @!attribute [r] storage
      # @return [Hash<String => String>]
      attr_reader :storage
      alias all storage

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

      # Returns a boolean indicating whether the colour has been
      # sregistered.
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

    end # Repository

  end # Colours

end # Vedeu
