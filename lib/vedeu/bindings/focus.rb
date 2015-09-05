module Vedeu

  module Bindings

    # Creates system events which when called provide a variety of core
    # functions and behaviours. They are soft-namespaced using underscores.
    #
    # :nocov:
    module Focus

      extend self

      # Setup events relating to running Vedeu. This method is called by Vedeu.
      #
      # @return [TrueClass]
      def setup!
        focus_by_name!
        focus_next!
        focus_prev!
      end

      private

      # When triggered with an interface name will focus that interface and
      # restore the cursor position and visibility.
      #
      # @example
      #   Vedeu.trigger(:_focus_by_name_, name)
      #
      # @return [TrueClass]
      def focus_by_name!
        Vedeu.bind(:_focus_by_name_) { |name| Vedeu.focus_by_name(name) }
      end

      # When triggered will focus the next interface and restore the cursor
      # position and visibility.
      #
      # @example
      #   Vedeu.trigger(:_focus_next_)
      #
      # @return [TrueClass]
      def focus_next!
        Vedeu.bind(:_focus_next_) { Vedeu.focus_next }
      end

      # When triggered will focus the previous interface and restore the cursor
      # position and visibility.
      #
      # @example
      #   Vedeu.trigger(:_focus_prev_)
      #
      # @return [TrueClass]
      def focus_prev!
        Vedeu.bind(:_focus_prev_) { Vedeu.focus_previous }
      end

    end # Focus
    # :nocov:

  end # Bindings

end # Vedeu
