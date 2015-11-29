module Vedeu

  module Views

    # Represents a single row of the terminal. It is a container for
    # {Vedeu::Views::Stream} objects. A line's width is determined by
    # the {Vedeu::Geometries::Geometry} it belongs to.
    #
    class Line

      include Vedeu::Repositories::Model
      include Vedeu::Presentation

      collection Vedeu::Views::Streams
      member     Vedeu::Views::Stream

      # @!attribute [r] attributes
      # @return [Hash]
      attr_reader :attributes

      # @!attribute [rw] parent
      # @return [Vedeu::Views::View]
      attr_accessor :parent

      # Returns a new instance of Vedeu::Views::Line.
      #
      # @param attributes [Hash]
      # @option attributes client [void]
      # @option attributes colour [Vedeu::Colours::Colour]
      # @option attributes parent [Vedeu::Views::View]
      # @option attributes style [Vedeu::Presentation::Style]
      # @option attributes value [Vedeu::Views::Streams]
      # @return [Vedeu::Views::Line]
      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @param child [Vedeu::Views::Stream]
      # @return [Vedeu::Views::Stream]
      def add(child)
        @value = value.add(child)
      end
      alias_method :<<, :add

      # Returns an array of all the characters with formatting for
      # this line.
      #
      # @return [Array]
      # @see Vedeu::Views::Stream
      def chars
        return [] if value.empty?

        @chars ||= value.flat_map(&:chars)
      end

      # Returns a DSL instance responsible for defining the DSL
      # methods of this model.
      #
      # @param client [Object|NilClass] The client binding represents
      #   the client application object that is currently invoking a
      #   DSL method. It is required so that we can send messages to
      #   the client application object should we need to.
      # @return [Vedeu::DSL::Line] The DSL instance for this model.
      def deputy(client = nil)
        Vedeu::DSL::Line.new(self, client)
      end

      # An object is equal when its values are the same./
      #
      # @param other [Vedeu::Repositories::Collection]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && value == other.value
      end
      alias_method :==, :eql?

      # @return [NilClass|String|Symbol]
      def name
        parent.name if parent
      end

      # Returns the size of the content in characters without
      # formatting.
      #
      # @return [Fixnum]
      def size
        value.map(&:size).inject(0, :+)
      end

      # @return [Vedeu::Views::Streams]
      def value
        collection.coerce(@value, self)
      end
      alias_method :streams, :value

      private

      # The default values for a new instance of this class.
      #
      # @return [Hash<Symbol => Array<void>|NilClass>]
      def defaults
        {
          client: nil,
          colour: nil,
          parent: nil,
          style:  nil,
          value:  [],
        }
      end

    end # Line

  end # Views

end # Vedeu
