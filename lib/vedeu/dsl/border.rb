# frozen_string_literal: true

module Vedeu

  module DSL

    # Provides DSL methods for Vedeu::Borders::Border objects.
    #
    # @api public
    #
    module Border

      # @macro module_instance_methods
      module InstanceMethods

        # Specify the border of an interface or view with a simple
        # DSL.
        #
        #   # As part of an interface:
        #   Vedeu.interface :my_interface do
        #     border do
        #       # ... see {Vedeu::Borders::DSL}
        #     end
        #   end
        #
        #   # As part of a view:
        #   Vedeu.render do
        #     view :my_interface do
        #       border do
        #         # ... see {Vedeu::Borders::DSL}
        #       end
        #     end
        #   end
        #
        # @macro param_name
        # @macro param_block
        # @macro raise_requires_block
        # @macro raise_missing_required
        # @return [Vedeu::Borders::Border]
        # @see Vedeu::Borders::DSL
        def border(name = nil, &block)
          raise Vedeu::Error::RequiresBlock unless block_given?

          model_name = name ? name : model.name

          Vedeu::Borders::Border.build(enabled: true,
                                       name:    model_name, &block).store
        end

        # Applies the default border to the interface or view.
        #
        #   # As part of an interface:
        #   Vedeu.interface :my_interface do
        #     border!
        #
        #     # ... some code
        #   end
        #
        #   # As part of a view:
        #   Vedeu.render do
        #     view :my_interface do
        #       border!
        #
        #       # ... some code
        #     end
        #   end
        #
        # @return [Vedeu::Borders::Border]
        def border!
          border do
            # adds default border
          end
        end

      end # InstanceMethods

      # @macro module_included
      def self.included(klass)
        klass.include(Vedeu::DSL::Border::InstanceMethods)
      end

    end # Border

  end # DSL

end # Vedeu
