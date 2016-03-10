# frozen_string_literal: true

require 'vedeu/dsl/all'
require 'vedeu/cells/all'

module Vedeu

  module Views

    # Represents a character or collection of characters as part of a
    # {Vedeu::Views::Line} which you wish to colour and style
    # independently of the other characters in that line.
    #
    class Stream

      # Provides DSL methods for Vedeu::Views::Stream objects.
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
      collection Vedeu::Views::Chars
      deputy     Vedeu::Views::Stream::DSL
      entity     Vedeu::Cells::Char
      parent     Vedeu::Views::Streams

      def_delegators :value,
                     :chars,
                     :size

      alias content value
      alias text value
      alias chars= value=
      alias chars? value?

      # @!attribute [w] value
      # @return [String]
      attr_writer :value

      # Returns a new instance of Vedeu::Views::Stream.
      #
      # @param attributes [Hash]
      # @option attributes client [void]
      # @option attributes colour [Vedeu::Colours::Colour]
      # @option attributes name [String|Symbol]
      # @option attributes parent [Vedeu::Views::Line]
      # @option attributes style [Vedeu::Presentation::Style]
      # @option attributes value [String]
      # @return [Vedeu::Views::Stream]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # Adds the child to the collection.
      #
      # @param child [Vedeu::Views::Stream]
      # @return [Vedeu::Views::Streams]
      def add(child)
        if defined?(parent) && present?(parent)
          parent.add(child)

        else
          @value = child

          self
        end
      end
      alias << add

      # An object is equal when its values are the same.
      #
      # @param other [void]
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

    end # Stream

  end # Views

end # Vedeu
