module Vedeu

  module Bindings

    # System events relating to movement of interfaces.
    #
    module Movement

      extend self

      # Setup events relating to movement. This method is called by
      # Vedeu.
      #
      # @return [TrueClass]
      def setup!
        directional!
      end

      # @return [TrueClass]
      def setup_aliases!
        %w(down left right up).each do |direction|
          Vedeu.bind_alias(:"_geometry_#{direction}_",
                           :"_view_#{direction}_")
        end
      end

      private

      # :nocov:

      # See {file:docs/events/movement.md#\_view_up_down_left_right_}
      def directional!
        %w(down left right up).each do |direction|
          Vedeu.bind(:"_view_#{direction}_") do |name|
            Vedeu.geometries.by_name(name).send("move_#{direction}")

            Vedeu.trigger(:_clear_)
            Vedeu.trigger(:_refresh_)
            Vedeu.trigger(:_clear_view_, name)
            Vedeu.trigger(:_refresh_view_, name)
          end
        end
      end

      # :nocov:

    end # Movement

  end # Bindings

end # Vedeu
