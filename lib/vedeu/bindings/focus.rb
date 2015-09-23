module Vedeu

  module Bindings

    module Focus

      extend self

      # Setup events relating to running Vedeu. This method is called
      # by Vedeu.
      #
      # @return [TrueClass]
      def setup!
        focus_by_name!
        focus_next!
        focus_prev!
      end

      private

      # :nocov:

      # See {file:docs/events/focus.md#\_focus_by_name_}
      def focus_by_name!
        Vedeu.bind(:_focus_by_name_) { |name| Vedeu.focus_by_name(name) }
      end

      # See {file:docs/events/focus.md#\_focus_next_}
      def focus_next!
        Vedeu.bind(:_focus_next_) { Vedeu.focus_next }
      end

      # See {file:docs/events/focus.md#\_focus_prev_}
      def focus_prev!
        Vedeu.bind(:_focus_prev_) { Vedeu.focus_previous }
      end

      # :nocov:

    end # Focus

  end # Bindings

end # Vedeu
