# frozen_string_literal: true

module Vedeu

  module Interfaces

    # An Interface represents a portion of the terminal defined by
    # {Vedeu::Geometries::Geometry}.
    #
    class Interface

      include Vedeu::Repositories::Model
      include Vedeu::Presentation
      include Vedeu::Toggleable

      # @!attribute [rw] client
      # @return [Fixnum|Float]
      attr_accessor :client

      # @!attribute [rw] cursor_visible
      # @return [Boolean]
      attr_accessor :cursor_visible
      alias cursor_visible? cursor_visible

      # @!attribute [rw] delay
      # @return [Fixnum|Float]
      attr_accessor :delay

      # @!attribute [rw] editable
      # @return [Boolean]
      attr_accessor :editable
      alias editable? editable

      # @!attribute [rw] group
      # @return [Symbol|String]
      attr_accessor :group

      # @!attribute [rw] name
      # @return [String]
      attr_accessor :name

      # @!attribute [rw] parent
      # @return [Vedeu::Views::Composition]
      attr_accessor :parent

      # @!attribute [rw] wordwrap
      # @return [Boolean]
      attr_accessor :wordwrap

      # @!attribute [rw] zindex
      # @return [Fixnum]
      attr_accessor :zindex

      # Return a new instance of Vedeu::Interfaces::Interface.
      #
      # @param attributes [Hash]
      # @option attributes client [Vedeu::Client]
      # @option attributes colour [Vedeu::Colours::Colour]
      # @option attributes cursor_visible [Boolean]
      # @option attributes delay [Float]
      # @option attributes group [String]
      # @option attributes name [String|Symbol]
      # @option attributes parent [Vedeu::Views::Composition]
      # @option attributes repository [Vedeu::Interfaces::Repository]
      # @option attributes style [Vedeu::Presentation::Style]
      # @option attributes visible [Boolean]
      # @option attributes wordwrap [Boolean]
      # @option attributes zindex [Fixnum]
      # @return [Vedeu::Interfaces::Interface]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @return [Hash<Symbol => void>]
      def attributes
        {
          client:         client,
          colour:         colour,
          cursor_visible: cursor_visible,
          delay:          delay,
          editable:       editable,
          group:          group,
          name:           name,
          parent:         parent,
          repository:     repository,
          style:          style,
          visible:        visible,
          wordwrap:       wordwrap,
          zindex:         zindex,
        }
      end

      # Returns a DSL instance responsible for defining the DSL
      # methods of this model.
      #
      # @param client [Object|NilClass] The client binding represents
      #   the client application object that is currently invoking a
      #   DSL method. It is required so that we can send messages to
      #   the client application object should we need to.
      # @return [Vedeu::Interfaces::DSL] The DSL instance for this
      #   model.
      def deputy(client = nil)
        Vedeu::Interfaces::DSL.new(self, client)
      end

      # Hide the named interface.
      #
      # Will hide the named interface. If the interface is currently
      # visible, it will be cleared- rendered blank. To show the
      # interface, the ':_show_interface_' event should be triggered.
      # Triggering the ':_hide_group_' event to which this named
      # interface belongs will also hide the interface.
      #
      # @example
      #   Vedeu.trigger(:_hide_interface_, name)
      #   Vedeu.hide_interface(name)
      #
      # @return [void]
      def hide
        super

        Vedeu.trigger(:_clear_view_, name)
      end

      # Show the named interface.
      #
      # Will show the named interface. If the interface is currently
      # visible, it will be refreshed- showing any new content
      # available. To hide the interface, the ':_hide_interface_'
      # event should be triggered.
      # Triggering the ':_show_group_' event to which this named
      # interface belongs will also show the interface.
      #
      # @example
      #   Vedeu.trigger(:_show_interface_, name)
      #   Vedeu.show_interface(name)
      #
      # @return [void]
      def show
        super

        Vedeu.trigger(:_refresh_view_, name)
      end

      private

      # @macro defaults_method
      def defaults
        {
          client:         nil,
          colour:         Vedeu.config.colour,
          cursor_visible: true,
          delay:          0.0,
          editable:       false,
          group:          '',
          name:           nil,
          parent:         nil,
          repository:     Vedeu.interfaces,
          style:          :normal,
          visible:        true,
          wordwrap:       true,
          zindex:         0,
        }
      end

    end # Interface

  end # Interfaces

  # @api public
  # @!method hide_interface
  #   @see Vedeu::Toggleable::SingletonMethods#hide
  # @api public
  # @!method show_interface
  #   @see Vedeu::Toggleable::SingletonMethods#show
  # @api public
  # @!method toggle_interface
  #   @see Vedeu::Toggleable::SingletonMethods#toggle
  def_delegators Vedeu::Interfaces::Interface,
                 :hide_interface,
                 :show_interface,
                 :toggle_interface

end # Vedeu
