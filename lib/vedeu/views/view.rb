module Vedeu

  module Views

    # Represents a container for {Vedeu::Views::Line} and
    # {Vedeu::Views::Stream} objects.
    #
    class View

      include Vedeu::Repositories::Model
      include Vedeu::Presentation

      collection Vedeu::Views::Lines
      member     Vedeu::Views::Line

      # @!attribute [r] attributes
      # @return [Hash]
      attr_reader :attributes

      # @!attribute [rw] client
      # @return [Fixnum|Float]
      attr_accessor :client

      # @!attribute [rw] cursor_visible
      # @return [Boolean]
      attr_accessor :cursor_visible
      alias_method :cursor_visible?, :cursor_visible

      # @!attribute [rw] name
      # @return [String]
      attr_accessor :name

      # @!attribute [rw] parent
      # @return [Vedeu::Views::Composition]
      attr_accessor :parent

      # @!attribute [w] lines
      # @return [Array<Vedeu::Views::Line>]
      attr_writer :lines

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
        @attributes = defaults.merge!(attributes)

        @attributes.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @param child [Vedeu::Views::Line]
      # @return [Vedeu::Views::Lines]
      def add(child)
        @value = value.add(child)
      end
      alias_method :<<, :add

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

      # @return [Vedeu::Views::Lines]
      def value
        collection.coerce(@value, self)
      end
      alias_method :lines, :value

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