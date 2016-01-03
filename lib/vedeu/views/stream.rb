require 'vedeu/dsl/all'

# frozen_string_literal: true

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
      include Vedeu::Repositories::Parent
      include Vedeu::Presentation

      include Vedeu::Views::Value
      collection Vedeu::Views::Chars
      deputy     Vedeu::Views::Stream::DSL
      entity     Vedeu::Views::Char
      parent     Vedeu::Views::Streams

      def_delegators :value,
                     :chars,
                     :size

      alias_method :content, :value
      alias_method :text,    :value
      alias_method :chars=, :value=
      alias_method :chars?, :value?

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

      # @param child [Vedeu::Views::Stream]
      # @return [Vedeu::Views::Streams]
      def add(child)
        parent.add(child)
      end
      alias_method :<<, :add

      # An object is equal when its values are the same.
      #
      # @param other [void]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && value == other.value
      end
      alias_method :==, :eql?

    end # Stream

  end # Views

end # Vedeu
