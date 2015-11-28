module Vedeu

  module Cursors

    # @api private
    #
    class Move

      extend Forwardable

      def_delegators :cursor,
                     :visible?

      # @param name [String|Symbol]
      # @param direction [Symbol]
      # @return [Vedeu::Cursors::Cursor]
      def self.move(name, direction)
        new(name, direction).move
      end

      # @param name [String|Symbol]
      # @param direction [Symbol]
      # @return [Vedeu::Cursors::Move]
      def initialize(name, direction)
        @name      = name
        @direction = direction
      end

      # @return [NilClass|Vedeu::Cursors::Cursor]
      def move
        return nil unless visible? && valid_direction?

        cursor.public_send(direction)
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
