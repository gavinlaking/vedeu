module Vedeu

  module DSL

    # Provides DSL methods for Vedeu::Geometries::Geometry objects.
    #
    # @api public
    #
    module Geometry

      # When {Vedeu::DSL::Geometry} is included in a class, the
      # methods within this module are included as class methods on
      # that class.
      #
      module ClassMethods

        # Specify the geometry of an interface or view with a simple
        # DSL.
        #
        #   # Standalone (preferred):
        #   Vedeu.geometry :my_interface do
        #     # ... see {Vedeu::Geometries::DSL}
        #   end
        #
        # @param name [String|Symbol] The name of the interface or
        #   view to which this geometry belongs.
        # @param block [Proc]
        # @raise [Vedeu::Error::MissingRequired|
        #   Vedeu::Error::RequiresBlock] When a name or block
        #   respectively are not given.
        # @return [Vedeu::Geometries::Geometry]
        # @see Vedeu::Geometries::DSL
        def geometry(name = nil, &block)
          # Alternative implementation which treats `Vedeu.geometry`
          # as `Vedeu.geometries` if no name or block is given.
          #
          # if name && block_given?
          #   Vedeu::Geometries::Geometry.build(name: name, &block).store
          #
          # else
          #   Vedeu.geometries
          #
          # end

          fail Vedeu::Error::MissingRequired unless name
          fail Vedeu::Error::RequiresBlock unless block_given?

          Vedeu::Geometries::Geometry.build(name: name, &block).store
        end

      end # ClassMethods

      # When {Vedeu::DSL::Geometry} is included in a class, the
      # methods within this module are included as instance methods on
      # that class.
      #
      module InstanceMethods

        # Specify the geometry of an interface or view with a simple
        # DSL.
        #
        #   # As part of an interface:
        #   Vedeu.interface :my_interface do
        #     geometry do
        #       # ... see {Vedeu::Geometries::DSL}
        #     end
        #   end
        #
        #   # As part of a view:
        #   Vedeu.render do
        #     view :my_interface do
        #       geometry do
        #         # ... see {Vedeu::Geometries::DSL}
        #       end
        #     end
        #   end
        #
        # @param name [String|Symbol] The name of the interface; this
        #   is already provided when we define the interface or view,
        #   setting it here is just mirroring functionality of
        #   {Vedeu::DSL::Geometry::ClassMethods.geometry}.
        # @param block [Proc]
        # @raise [Vedeu::Error::MissingRequired|
        #   Vedeu::Error::RequiresBlock] When a name or block
        #   respectively are not given.
        # @return [Vedeu::Geometries::Geometry]
        # @see Vedeu::Geometries::DSL
        def geometry(name = nil, &block)
          fail Vedeu::Error::RequiresBlock unless block_given?

          model_name = name ? name : model.name

          Vedeu::Geometries::Geometry.build(name: model_name, &block).store
        end

      end # InstanceMethods

      # When this module is included in a class, provide ClassMethods
      # as class methods and InstanceMethods as instance methods for
      # the given class.
      #
      # @param klass [Class]
      # @return [void]
      def self.included(klass)
        klass.extend(Vedeu::DSL::Geometry::ClassMethods)
        klass.include(Vedeu::DSL::Geometry::InstanceMethods)
      end

    end # Geometry

  end # DSL

end # Vedeu
