require 'vedeu/dsl/all'

module Vedeu

  module Views

    # Represents a single row of the terminal. It is a container for
    # {Vedeu::Views::Stream} objects. A line's width is determined by
    # the {Vedeu::Geometries::Geometry} it belongs to.
    #
    class Line

      class DSL

        include Vedeu::DSL
        include Vedeu::DSL::Elements

      end # DSL

      include Vedeu::Views::DefaultAttributes
      include Vedeu::Repositories::Model
      include Vedeu::Repositories::Parent
      include Vedeu::Presentation

      include Vedeu::Views::Value
      collection Vedeu::Views::Streams
      deputy     Vedeu::Views::Line::DSL
      entity     Vedeu::Views::Stream
      parent     Vedeu::Views::Lines

      alias_method :streams=, :value=
      alias_method :streams?, :value?

      # @!attribute [rw] client
      # @return [void]
      attr_accessor :client

      # @!attribute [rw] parent
      # @return [Vedeu::Views::View]
      attr_accessor :parent

      # Returns a new instance of Vedeu::Views::Line.
      #
      # @param attributes [Hash]
      # @option attributes client [void]
      # @option attributes colour [Vedeu::Colours::Colour]
      # @option attributes name [String|Symbol]
      # @option attributes parent [Vedeu::Views::View]
      # @option attributes style [Vedeu::Presentation::Style]
      # @option attributes value [Vedeu::Views::Streams]
      # @return [Vedeu::Views::Line]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
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
        return [] unless value?

        @chars ||= value.value.flat_map(&:chars)
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
        Vedeu::Views::Line::DSL.new(self, client)
      end

      # An object is equal when its values are the same./
      #
      # @param other [Vedeu::Repositories::Collection]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && value == other.value
      end
      alias_method :==, :eql?

      # Returns the size of the content in characters without
      # formatting.
      #
      # @return [Fixnum]
      def size
        value.map(&:size).inject(0, :+)
      end

      # @return [Array<Vedeu::Views::Stream>]
      def streams
        value.value
      end

    end # Line

  end # Views

end # Vedeu
