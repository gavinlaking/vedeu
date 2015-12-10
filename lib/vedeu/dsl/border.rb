module Vedeu

  module DSL

    module Border

      # When {Vedeu::DSL::Border} is included in a class, the
      # methods within this module are included as class methods on
      # that class.
      #
      module ClassMethods

        # Specify the border of an interface or view with a simple
        # DSL.
        #
        #   # Standalone (preferred):
        #   Vedeu.border :my_interface do
        #     # ... see {Vedeu::Borders::DSL}
        #   end
        #
        # @param name [String|Symbol] The name of the interface or
        #   view to which this border belongs.
        # @param block [Proc]
        # @raise [Vedeu::Error::MissingRequired|
        #   Vedeu::Error::RequiresBlock] When a name or block
        #   respectively are not given.
        # @return [Vedeu::Borders::Border]
        # @see Vedeu::Borders::DSL
        def border(name, &block)
          fail Vedeu::Error::MissingRequired unless name
          fail Vedeu::Error::RequiresBlock unless block_given?

          Vedeu::Borders::Border.build(enabled: true, name: name, &block).store
        end

      end # ClassMethods

      # When {Vedeu::DSL::Border} is included in a class, the
      # methods within this module are included as instance methods on
      # that class.
      #
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
        # @param name [String|Symbol] The name of the interface; this
        #   is already provided when we define the interface or view,
        #   setting it here is just mirroring functionality of
        #   {Vedeu::DSL::Border::ClassMethods.border}.
        # @param block [Proc]
        # @raise [Vedeu::Error::MissingRequired|
        #   Vedeu::Error::RequiresBlock] When a name or block
        #   respectively are not given.
        # @return [Vedeu::Borders::Border]
        # @see Vedeu::Borders::DSL
        def border(name = nil, &block)
          fail Vedeu::Error::RequiresBlock unless block_given?

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

      # When this module is included in a class, provide ClassMethods
      # as class methods for the class.
      #
      # @param klass [Class]
      # @return [void]
      def self.included(klass)
        klass.extend(Vedeu::DSL::Border::ClassMethods)
        klass.include(Vedeu::DSL::Border::InstanceMethods)
      end

    end # Border

  end # DSL

end # Vedeu
