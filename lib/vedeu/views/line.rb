require 'vedeu/dsl/all'

# frozen_string_literal: true

module Vedeu

  module Views

    # Represents a single row of the terminal. It is a container for
    # {Vedeu::Views::Stream} objects. A line's width is determined by
    # the {Vedeu::Geometries::Geometry} it belongs to.
    #
    # @api private
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
      include Vedeu::Presentation
      include Vedeu::Presentation::Colour
      include Vedeu::Presentation::Position
      include Vedeu::Presentation::Styles
      include Vedeu::Views::Value

      collection Vedeu::Views::Streams
      deputy     Vedeu::Views::Line::DSL
      entity     Vedeu::Views::Stream
      parent     Vedeu::Views::Lines

      def_delegators :value,
                     :streams

      alias streams= value=
      alias streams? value?

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

      # Adds the child to the collection.
      #
      # @param child [Vedeu::Views::Stream]
      # @return [Vedeu::Views::Stream]
      def add(child)
        @value = value.add(child)
      end
      alias << add

      # Returns an array of all the characters with formatting for
      # this line.
      #
      # @return [Array]
      # @see Vedeu::Views::Stream
      def chars
        return [] unless streams?

        @chars ||= streams.flat_map(&:chars)
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Repositories::Collection]
      # @return [Boolean]
      def eql?(other)
        self.class.equal?(other.class) && value == other.value
      end
      alias == eql?

      # @return [NilClass|String|Symbol]
      def name
        if present?(@name)
          @name

        elsif parent && present?(parent.name)
          parent.name

        end
      end

      # @return [NilClass|void]
      def parent
        present?(@parent) ? @parent : nil
      end

      # Returns the size of the content in characters without
      # formatting.
      #
      # @return [Fixnum]
      def size
        streams.map(&:size).inject(0, :+)
      end

    end # Line

  end # Views

end # Vedeu
