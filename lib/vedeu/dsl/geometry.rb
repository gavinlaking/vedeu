# frozen_string_literal: true

module Vedeu

  module DSL

    # Provides DSL methods for Vedeu::Geometries::Geometry objects.
    #
    # @api public
    #
    module Geometry

      # @macro module_singleton_methods
      module SingletonMethods

        # {include:file:docs/dsl/by_method/geometry.md}
        # @param name [String|Symbol] The name of the interface or
        #   view to which this geometry belongs.
        # @param block [Proc]
        # @macro raise_requires_block
        # @macro raise_missing_required
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

      end # SingletonMethods

      # Provide additional behaviour as instance methods.
      #
      module InstanceMethods

        # {include:file:docs/dsl/by_method/geometry.md}
        # @param name [String|Symbol] The name of the interface; this
        #   is already provided when we define the interface or view,
        #   setting it here is just mirroring functionality of
        #   {Vedeu::DSL::Geometry::SingletonMethods#geometry}.
        # @param block [Proc]
        # @macro raise_requires_block
        # @macro raise_missing_required
        # @return [Vedeu::Geometries::Geometry]
        # @see Vedeu::Geometries::DSL
        def geometry(name = nil, &block)
          fail Vedeu::Error::RequiresBlock unless block_given?

          model_name = name ? name : model.name

          Vedeu::Geometries::Geometry.build(name: model_name, &block).store
        end

      end # InstanceMethods

      # @macro included_module
      def self.included(klass)
        klass.extend(Vedeu::DSL::Geometry::SingletonMethods)
        klass.include(Vedeu::DSL::Geometry::InstanceMethods)
      end

    end # Geometry

  end # DSL

end # Vedeu
