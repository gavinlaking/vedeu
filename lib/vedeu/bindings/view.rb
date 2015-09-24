module Vedeu

  module Bindings

    # System events relating to the view.
    #
    module View

      extend self

      # Setup events relating to client applications. This method is
      # called by Vedeu.
      #
      # @return [TrueClass]
      def setup!
        maximise!
        resize!
        unmaximise!
      end

      private

      # :nocov:

      # See {file:docs/events/view.md#\_maximise_}
      def maximise!
        Vedeu.bind(:_maximise_) do |name|
          Vedeu.geometries.by_name(name).maximise
        end
      end

      # See {file:docs/events/view.md#\_resize_}
      def resize!
        Vedeu.bind(:_resize_, delay: 0.25) { Vedeu.resize }
      end

      # See {file:docs/events/view.md#\_unmaximise_}
      def unmaximise!
        Vedeu.bind(:_unmaximise_) do |name|
          Vedeu.geometries.by_name(name).unmaximise
        end
      end

      # :nocov:

    end # View

  end # Bindings

end # Vedeu
