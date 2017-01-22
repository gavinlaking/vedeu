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

      # @macro param_name
      # @param direction [Symbol]
      # @param offset [Integer]
      # @return [Vedeu::Cursors::Move]
      def initialize(name, direction, offset)
        @name      = name
        @direction = direction
        @offset    = offset || 1
      end

      # @return [NilClass|Vedeu::Cursors::Cursor]
      def move
        if visible? && valid?
          cursor.public_send(direction, offset)
          cursor.store { Vedeu.trigger(:_refresh_cursor_, name) }
          cursor
        end
      end

      protected

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      # @!attribute [r] direction
      # @return [Symbol] The direction to move the cursor.
      attr_reader :direction

      # @!attribute [r] offset
      # @return [Symbol] The number of characters to move the cursor
      #   in the given direction.
      attr_reader :offset

      private

      # @macro cursor_by_name
      def cursor
        @_cursor ||= Vedeu.cursors.by_name(name)
      end

      # @return [Hash<Symbol => Proc>]
      def directions
        {
          move_down:  proc { valid_down? },
          move_left:  proc { valid_left? },
          move_right: proc { valid_right? },
          move_up:    proc { valid_up? },
        }
      end

      # @return [Boolean]
      def valid?
        valid_direction? && directions.fetch(direction).call
      end

      # @return [Boolean]
      def valid_direction?
        directions.keys.include?(direction)
      end

      # @return [Boolean]
      def valid_down?
        true
      end

      # @return [Boolean]
      def valid_left?
        (cursor.ox - offset).positive?
      end

      # @return [Boolean]
      def valid_right?
        true
      end

      # @return [Boolean]
      def valid_up?
        (cursor.oy - offset).positive?
      end

    end # Move

  end # Cursors

end # Vedeu
