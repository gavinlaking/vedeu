# frozen_string_literal: true

module Vedeu

  module Cursors

    # Provides the mechanism to move a named cursor in a given
    # direction.
    #
    # @api private
    #
    class Move

      extend Forwardable

      def_delegators :cursor,
                     :visible?

      # @param (see #initialize)
      # @return (see #move)
      def self.move(name, direction, offset)
        new(name, direction, offset).move
      end

      # @param name [String|Symbol]
      # @param direction [Symbol]
      # @param offset [Fixnum]
      # @return [Vedeu::Cursors::Move]
      def initialize(name, direction, offset)
        @name      = name
        @direction = direction
        @offset    = offset
      end

      # @return [NilClass|Vedeu::Cursors::Cursor]
      def move
        return nil unless visible? && valid_direction?

        cursor.public_send(direction, offset)
        cursor.store { Vedeu.trigger(:_refresh_cursor_, name) }
        cursor
      end

      protected

      # @!attribute [r] name
      # @return [String|Symbol] The name of the cursor.
      attr_reader :name

      # @!attribute [r] direction
      # @return [Symbol] The direction to move the cursor.
      attr_reader :direction

      # @!attribute [r] offset
      # @return [Symbol] The number of characters to move the cursor
      #   in the given direction.
      attr_reader :offset

      private

      # @return [Vedeu::Cursors::Cursor]
      def cursor
        @_cursor ||= Vedeu.cursors.by_name(name)
      end

      # @return [Boolean]
      def valid_direction?
        [
          :move_down,
          :move_left,
          :move_right,
          :move_up,
        ].include?(direction)
      end

    end # Move

  end # Cursors

end # Vedeu
