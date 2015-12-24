require 'vedeu/dsl/all'

module Vedeu

  module Views

    # Represents a single row of the terminal. It is a container for
    # {Vedeu::Views::Stream} objects. A line's width is determined by
    # the {Vedeu::Geometries::Geometry} it belongs to.
    #
    class Line

      # Provides DSL methods for Vedeu::Views::Line objects.
      #
      # @api public
      #
      class DSL

        include Vedeu::DSL
        include Vedeu::DSL::Elements

      end # DSL

      extend Forwardable
      include Vedeu::Views::DefaultAttributes
      include Vedeu::Repositories::Model
      include Vedeu::Repositories::Parent
      include Vedeu::Presentation
      include Vedeu::Views::Value

      collection Vedeu::Views::Streams
      deputy     Vedeu::Views::Line::DSL
      entity     Vedeu::Views::Stream
      parent     Vedeu::Views::Lines

      def_delegators :value,
                     :streams

      alias_method :streams=, :value=
      alias_method :streams?, :value?

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

        @chars ||= streams.flat_map(&:chars)
      end

      # An object is equal when its values are the same.
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

    end # Line

  end # Views

end # Vedeu
