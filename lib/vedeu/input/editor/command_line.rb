module Vedeu

  module Editor

    class CommandLine

      # Return a new instance of Vedeu::Editor::CommandLine.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes name [String] The name of the interface which 'owns'
      #   this command line. This is used to get display options and geometry.
      # @option attributes text [String] The text already entered if any.
      # @option attributes x [Fixnum] The cursor x position within the
      #   entered text.
      # @option attributes y [Fixnum] The cursor y position within the
      #   entered text.
      # @return [Vedeu::Editor::CommandLine]
      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      def input
        # loop do

        # end
      end

      protected

      # @!attribute [rw] y
      # @return [String]
      attr_reader :name

      # @!attribute [rw] text
      # @return [String]
      attr_accessor :text

      # @!attribute [rw] x
      # @return [Fixnum]
      attr_accessor :x

      # @!attribute [rw] y
      # @return [Fixnum]
      attr_accessor :y

      private

      # @return [Hash<Symbol => void>]
      def attributes
        {
          text: text,
          x:    x,
          y:    y,
        }
      end

      # @return [Hash<Symbol => Fixnum,String>]
      def defaults
        {
          name: '',
          text: '',
          x:    0,
          y:    0,
        }
      end

    end # CommandLine

  end # Editor

end # Vedeu
