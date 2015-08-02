module Vedeu

  module Views

    # Represents a container for {Vedeu::Views::Line} and {Vedeu::Views::Stream}
    # objects.
    #
    class View

      include Vedeu::Model
      include Vedeu::Presentation

      collection Vedeu::Views::Lines
      member     Vedeu::Views::Line

      # @!attribute [rw] client
      # @return [Fixnum|Float]
      attr_accessor :client

      # @!attribute [rw] name
      # @return [String]
      attr_accessor :name

      # @!attribute [rw] parent
      # @return [Vedeu::Views::Composition]
      attr_accessor :parent

      # @!attribute [rw] zindex
      # @return [Fixnum]
      attr_accessor :zindex

      # @!attribute [r] attributes
      # @return [Hash]
      attr_reader :attributes

      # @!attribute [w] lines
      # @return [Array<Vedeu::Views::Line>]
      attr_writer :lines

      # Return a new instance of Vedeu::Views::View.
      #
      # @param attributes [Hash]
      # @option attributes client [Vedeu::Client]
      # @option attributes colour [Vedeu::Colour]
      # @option attributes lines [Vedeu::Views::Lines]
      # @option attributes name [String]
      # @option attributes parent [Vedeu::Views::Composition]
      # @option attributes style [Vedeu::Style]
      # @option attributes zindex [Fixnum]
      # @return [Vedeu::Views::View]
      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @param child [Vedeu::Views::Line]
      # @return [void]
      def add(child)
        @lines = lines.add(child)
      end
      alias_method :<<, :add

      # Override Ruby's Object#inspect method to provide a more helpful output.
      #
      # @return [String]
      def inspect
        "<Vedeu::Views::View name: '#{name}', zindex: '#{zindex}'>"
      end

      # @return [Vedeu::Views::Lines]
      def lines
        collection.coerce(@lines, self)
      end
      alias_method :value, :lines

      # @return [Array<Array<Vedeu::Views::Char>>]
      def render
        return [] unless visible?

        output = [
          Vedeu::Cursor.hide_cursor(name),
          Vedeu::Clear::NamedInterface.render(name),
          Vedeu::Viewport.render(self),
          Vedeu.borders.by_name(name).render,
          Vedeu::Cursor.show_cursor(name),
        ]

        output
      end

      # Store the view and immediately refresh it; causing to be pushed to the
      # Terminal. Called by {Vedeu::DSL::View.renders}.
      #
      # @return [Vedeu::Views::View]
      def store_immediate
        store_deferred

        Vedeu::Refresh.by_name(name)

        self
      end

      # When a name is given, the view is stored with this name. This view will
      # be shown next time a refresh event is triggered with this name.
      # Called by {Vedeu::DSL::View.views}.
      #
      # @raise [Vedeu::InvalidSyntax] The name is not defined.
      # @return [Vedeu::Views::View]
      def store_deferred
        unless present?(name)
          fail Vedeu::InvalidSyntax, 'Cannot store an interface without a name.'
        end

        Vedeu.buffers.by_name(name).add(self)

        self
      end

      # Returns a boolean indicating whether the view is visible.
      #
      # @return [Boolean]
      def visible?
        Vedeu.interfaces.by_name(name).visible?
      end

      private

      # The default values for a new instance of this class.
      #
      # @return [Hash]
      def defaults
        {
          client:     nil,
          colour:     Vedeu::Colour.coerce(background: :default,
                                           foreground: :default),
          name:       '',
          parent:     nil,
          style:      :normal,
          zindex:     0,
        }
      end

    end # View

  end # Views

end # Vedeu
