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

        else
          Vedeu.trigger(:_keypress_, input)

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

      # @return [String]
      def input
        @_input ||= if input?
                      @input

                    elsif cooked?
                      console.gets.chomp

                    else
                      keys = console.getch

                      if keys.ord == Vedeu::ESCAPE_KEY_CODE
                        keys << console.read_nonblock(4) rescue nil
                        keys << console.read_nonblock(3) rescue nil
                        keys << console.read_nonblock(2) rescue nil
                      end

                      Vedeu::Input::Translator.translate(keys)

                    end
      end

      # @return [Boolean]
      def input?
        present?(@input)
      end

      # @return [Symbol]
      def mode
        fail Vedeu::Error::InvalidSyntax,
             'mode option must be `:raw` or `:cooked`.' unless valid_mode?

        options[:mode]
      end

      # @return [Array<Symbol>]
      def modes
        [
          :cooked,
          :raw,
        ]
      end

      # @return [Hash<Symbol => Symbol>]
      def options
        defaults.merge!(@options)
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
