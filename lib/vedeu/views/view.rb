module Vedeu

  module Views

    # Represents a container for {Vedeu::Views::Line} and
    # {Vedeu::Views::Stream} objects.
    #
    class View

      include Vedeu::Repositories::Model
      include Vedeu::Repositories::Parent
      include Vedeu::Presentation

      # @!attribute [rw] client
      # @return [Fixnum|Float]
      attr_accessor :client

      # @!attribute [rw] cursor_visible
      # @return [Boolean]
      attr_accessor :cursor_visible
      alias_method :cursor_visible?, :cursor_visible

      # @!attribute [rw] name
      # @return [String|Symbol]
      attr_accessor :name

      # @!attribute [rw] parent
      # @return [Vedeu::Views::Composition]
      attr_accessor :parent

      # @!attribute [rw] zindex
      # @return [Fixnum]
      attr_accessor :zindex

      # Return a new instance of Vedeu::Views::View.
      #
      # @param attributes [Hash]
      # @option attributes client [Vedeu::Client]
      # @option attributes colour [Vedeu::Colours::Colour]
      # @option attributes cursor_visible [Boolean]
      # @option attributes value [Vedeu::Views::Lines]
      # @option attributes name [String|Symbol]
      # @option attributes parent [Vedeu::Views::Composition]
      # @option attributes style [Vedeu::Presentation::Style]
      # @option attributes zindex [Fixnum]
      # @return [Vedeu::Views::View]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @param child [Vedeu::Views::Line]
      # @return [Vedeu::Views::Lines]
      def add(child)
        @_value = value.add(child)
      end
      alias_method :<<, :add

      # @return [Hash]
      def attributes
        {
          client:         client,
          colour:         colour,
          cursor_visible: cursor_visible,
          name:           name,
          parent:         parent,
          style:          style,
          value:          value,
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
      # @return [Vedeu::DSL::View] The DSL instance for this model.
      def deputy(client = nil)
        Vedeu::DSL::View.new(self, client)
      end

      # Store the view and immediately refresh it; causing to be
      # pushed to the Terminal. Called by {Vedeu::DSL::View.renders}.
      #
      # @return [Vedeu::Views::View]
      def store_immediate
        store_deferred

        Vedeu.trigger(:_refresh_view_, name)

        self
      end

      # When a name is given, the view is stored with this name. This
      # view will be shown next time a refresh event is triggered with
      # this name. Called by {Vedeu::DSL::View.views}.
      #
      # @raise [Vedeu::Error::InvalidSyntax] The name is not defined.
      # @return [Vedeu::Views::View]
      def store_deferred
        fail Vedeu::Error::InvalidSyntax,
             'Cannot store an interface ' \
             'without a name.'.freeze unless present?(name)

        buffer.add(self)

        self
      end

      # @return [Vedeu::Views::Lines]
      def value
        @_value ||= if present?(@value)
                      Vedeu::Views::Lines.coerce(@value, self)

                    else
                      Vedeu::Views::Lines.coerce([], self)

                    end
      end
      alias_method :lines, :value

      # @param value [Vedeu::Views::Line]
      # @return [Vedeu::Views::Line]
      def value=(value)
        @_value = @value = Vedeu::Views::Lines.coerce(value, self)
      end
      alias_method :lines=, :value=

      # Returns a boolean indicating whether this view has any lines.
      #
      # @return [Boolean]
      def value?
        value.any?
      end
      alias_method :lines?, :value?

      # Returns a boolean indicating whether the view is visible.
      #
      # @return [Boolean]
      def visible?
        interface.visible?
      end

      private

      # @return [Vedeu::Buffers::Buffer]
      def buffer
        Vedeu.buffers.by_name(name)
      end

      # The default values for a new instance of this class.
      #
      # @return [Hash]
      def defaults
        {
          client:         nil,
          colour:         Vedeu::Configuration.colour,
          cursor_visible: true,
          name:           '',
          parent:         nil,
          style:          :normal,
          value:          [],
          zindex:         0,
        }
      end

      # @return [Vedeu::Interfaces::Interface]
      def interface
        Vedeu.interfaces.by_name(name)
      end

    end # View

  end # Views

end # Vedeu
