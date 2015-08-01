module Vedeu

  module DSL

    module Shared

      # Allows the setting of a border for the interface.
      #
      # @example
      #   Vedeu.interface 'my_interface' do
      #     border do
      #       # ... see Vedeu::DSL::Border for DSL methods for borders.
      #     end
      #   end
      #
      # @param name [String] The name of the interface; this is already provided
      #   when we define the interface or view, setting it here is just
      #   mirroring functionality of {Vedeu::DSL::Border.border}.
      # @param block [Proc]
      # @raise [Vedeu::InvalidSyntax] The required block was not given.
      # @return [Vedeu::Border]
      # @see Vedeu::DSL::Border
      def border(name = nil, &block)
        fail Vedeu::InvalidSyntax, 'block not given' unless block_given?

        model_name = name ? name : model.name

        border_attrs = attributes.merge!(enabled: true,
                                         name:    model_name)

        Vedeu::Border.build(border_attrs, &block).store
      end

      # Applies the default border to the interface.
      #
      # @example
      #   Vedeu.interface 'my_interface' do
      #     border!
      #
      #     # ... some code
      #   end
      #
      # @return [Vedeu::Border]
      def border!
        border do
          # adds default border
        end
      end

      # Define the geometry for an interface.
      #
      # @example
      #   Vedeu.interface 'my_interface' do
      #     geometry do
      #       # ... see Vedeu::DSL::Geometry for DSL methods for geometries.
      #     end
      #   end
      #
      # @param name [String] The name of the interface; this is already provided
      #   when we define the interface or view, setting it here is just
      #   mirroring functionality of {Vedeu::DSL::Geometry.geometry}.
      # @param block [Proc]
      # @raise [Vedeu::InvalidSyntax] The required block was not given.
      # @return [Vedeu::Geometry]
      # @see Vedeu::DSL::Geometry
      def geometry(name = nil, &block)
        fail Vedeu::InvalidSyntax, 'block not given' unless block_given?

        model_name = name ? name : model.name

        Vedeu::Geometry.build(name: model_name, &block).store
      end

    end # Shared

  end # DSL

end # Vedeu
