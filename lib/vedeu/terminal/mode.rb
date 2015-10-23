module Vedeu

  module Terminal

    # Store the current mode of the terminal.
    #
    module Mode

      include Vedeu::Common
      extend self

      # Returns a boolean indicating whether the terminal is currently
      # in `cooked` mode.
      #
      # @return [Boolean]
      def cooked_mode?
        mode == :cooked
      end

      # Sets the terminal in to `cooked` mode.
      #
      # @return [Symbol]
      def cooked_mode!
        @mode = :cooked
      end

      # Returns a boolean indicating whether the terminal is currently
      # in `fake` mode.
      #
      # @return [Boolean]
      def fake_mode?
        mode == :fake
      end

      # Sets the terminal in to `fake` mode.
      #
      # @return [Symbol]
      def fake_mode!
        @mode = :fake
      end

      # Returns a boolean indicating whether the terminal is currently
      # in `raw` mode.
      #
      # @return [Boolean]
      def raw_mode?
        mode == :raw
      end

      # Sets the terminal in to `raw` mode.
      #
      # @return [Symbol]
      def raw_mode!
        @mode = :raw
      end

      # Changes the mode of the terminal to the mode given or toggles
      # the terminal mode between `cooked`, `fake` and `raw`,
      # depending on the current mode.
      #
      # @param mode [NilClass|Symbol]
      # @return [Symbol]
      def switch_mode!(mode = nil)
        if present?(mode) && valid_mode?(mode)
          @mode = mode

        else
          return fake_mode!   if raw_mode?
          return cooked_mode! if fake_mode?

          raw_mode!
        end
      end

      # Returns the mode of the terminal, either `:cooked`, `:fake` or
      # `:raw`. Can change throughout the lifespan of the client
      # application.
      #
      # @return [Symbol]
      def mode
        @mode ||= Vedeu::Configuration.terminal_mode
      end

      private

      # Returns a boolean indicating whether the given mode is valid.
      #
      # @param mode [Symbol] Should be one of the modes listed in
      #   {#valid_modes}.
      # @return [Boolean]
      def valid_mode?(mode)
        valid_modes.include?(mode)
      end

      # @return [Array<Symbol>]
      def valid_modes
        [
          :cooked,
          :fake,
          :raw,
        ]
      end

    end # Mode

  end # Terminal

end # Vedeu
