# frozen_string_literal: true

module Vedeu

  module Input

    # Directly read from the terminal.
    #
    # @example
    #   Vedeu.read(input, options)
    #
    # @api private
    #
    class Read

      include Vedeu::Common

      # @api public
      # @see Vedeu::Input::Read#initialize
      def self.read(input = nil, options = {})
        new(input, options).read
      end

      # Returns a new instance of Vedeu::Input::Read.
      #
      # @param input [NilClass|String]
      # @param options [Hash<Symbol => Symbol]
      # @option mode [Symbol] Either :cooked (default) or :raw
      # @return [Vedeu::Input::Read]
      def initialize(input = nil, options = {})
        @input   = input
        @options = options
      end

      # @return [String]
      def read
        if cooked?
          Vedeu.trigger(:_command_, input)

        elsif raw?
          Vedeu.trigger(:_keypress_, input)

        elsif fake?
          input

        end

        input
      end

      protected

      # @!attribute [r] input
      # @return [NilClass|String]
      attr_reader :input

      private

      # @return [IO]
      def console
        @console ||= Vedeu::Terminal.console
      end

      # @return [Boolean]
      def cooked?
        mode == :cooked
      end

      # @return [Hash<Symbol => Symbol>]
      def defaults
        {
          mode: :cooked
        }
      end

      # @return [Boolean]
      def fake?
        mode == :fake
      end

      # @return [String]
      def mouse_off
        Vedeu.esc.mouse_x10_off
      end

      # @return [String]
      def show_cursor
        Vedeu.esc.show_cursor
      end

      # @return [String]
      def input
        @_input ||= if input?
                      @input

                    elsif cooked?
                      console.gets.chomp

                    elsif raw?
                      keys = Vedeu::Input::Raw.read

                      Vedeu::Input::Translator.translate(keys)

                    elsif fake?
                      console.cooked do
                        Vedeu::Terminal.debugging!

                        console.gets.chomp
                      end

                    end
      end

      # @return [Boolean]
      def input?
        present?(@input)
      end

      # @return [Symbol]
      def mode
        unless valid_mode?
          fail Vedeu::Error::InvalidSyntax,
               ':mode must be `:raw`, `:fake` or `:cooked`.'
        end

        options[:mode]
      end

      # @return [Array<Symbol>]
      def modes
        [
          :cooked,
          :fake,
          :raw,
        ]
      end

      # @return [Hash<Symbol => Symbol>]
      def options
        defaults.merge!(@options)
      end

      # @return [Boolean]
      def raw?
        mode == :raw
      end

      # @return [Boolean]
      def valid_mode?
        modes.include?(options[:mode])
      end

    end # Read

  end # Input

  # @!method read
  #   @see Vedeu::Input::Read#read
  def_delegators Vedeu::Input::Read,
                 :read

end # Vedeu
