module Vedeu

  module DSL

    # Provides behaviour to be shared between both
    # {Vedeu::Interfaces::DSL} and {Vedeu::DSL::View} objects.
    #
    module Shared

      # Allows the setting of a border for the interface.
      #
      # @example
      #   Vedeu.interface :my_interface do
      #     border do
      #       # ... see Vedeu::Borders::DSL for DSL methods for
      #       #     borders.
      #     end
      #   end
      #
      # @param name [String|Symbol] The name of the interface; this is
      #   already provided when we define the interface or view,
      #   setting it here is just mirroring functionality of
      #   {Vedeu::Borders::DSL.border}.
      # @param block [Proc]
      # @raise [Vedeu::Error::RequiresBlock]
      # @return [Vedeu::Borders::Border]
      # @see Vedeu::Borders::DSL
      def border(name = nil, &block)
        fail Vedeu::Error::RequiresBlock unless block_given?

        model_name = name ? name : model.name

        border_attrs = attributes.merge!(enabled: true,
                                         name:    model_name)

        Vedeu::Borders::Border.build(border_attrs, &block).store
      end

      # Applies the default border to the interface.
      #
      # @example
      #   Vedeu.interface :my_interface do
      #     border!
      #
      #     # ... some code
      #   end
      #
      # @return [Vedeu::Borders::Border]
      def border!
        border do
          # adds default border
        end
      end

      # Define the geometry for an interface.
      #
      # @example
      #   Vedeu.interface :my_interface do
      #     geometry do
      #       # ... see Vedeu::Geometries::DSL for DSL methods for
      #       #     geometries.
      #     end
      #   end
      #
      # @param name [String|Symbol] The name of the interface; this is
      #   already provided when we define the interface or view,
      #   setting it here is just mirroring functionality of
      #   {Vedeu::Geometries::DSL.geometry}.
      # @param block [Proc]
      # @raise [Vedeu::Error::RequiresBlock]
      # @return [Vedeu::Geometries::Geometry]
      # @see Vedeu::Geometries::DSL
      def geometry(name = nil, &block)
        fail Vedeu::Error::RequiresBlock unless block_given?

        model_name = name ? name : model.name

        Vedeu::Geometries::Geometry.build(name: model_name, &block).store
      end

    end # Shared

  end # DSL

end # Vedeu
