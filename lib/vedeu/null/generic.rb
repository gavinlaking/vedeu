# frozen_string_literal: true

module Vedeu

  module Null

    # Provides a non-existent model to swallow messages.
    #
    # @api private
    #
    class Generic

      # @!attribute [r] attributes
      # @return [String]
      attr_reader :attributes

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      # Returns a new instance of the Vedeu::Null::Generic class.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes name [String|Symbol|NilClass]
      # @return [Vedeu::Null::Generic]
      def initialize(attributes = {})
        @attributes = attributes
        @name       = @attributes.fetch(:name, '')
      end

      # @return [Boolean]
      def falsy
        false
      end
      alias cursor_visible? falsy
      alias enabled? falsy
      alias maximise falsy
      alias maximised? falsy
      alias unmaximise falsy
      alias visible falsy
      alias visible? falsy
      alias editable? falsy

      # @return [NilClass]
      def null(*)
        nil
      end
      alias add null
      alias bottom_item null
      alias clear null
      alias colour null
      alias current_item null
      alias deselect_item null
      alias hide null
      alias item null
      alias items null
      alias next_item null
      alias parent null
      alias prev_item null
      alias render null
      alias select_item null
      alias selected_item null
      alias show null
      alias style null
      alias toggle null
      alias top_item null
      alias view null
      alias zindex null

      # @return [Boolean]
      def null?
        true
      end

      # @return [Vedeu::Null::Generic]
      def store
        self
      end

      # @return [Boolean]
      def visible=(*)
        false
      end

    end # Generic

  end # Null

end # Vedeu
