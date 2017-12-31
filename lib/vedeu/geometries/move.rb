# frozen_string_literal: true

module Vedeu

  module Geometries

    # Move an interface/view via changing its geometry.
    #
    # When moving an interface/view;
    #
    # 1) Reset the alignment and maximised states to false;
    #    it wont be aligned to a side if moved, and cannot be moved
    #    if maximised.
    # 2) Get the current coordinates of the interface, then:
    # 3) Override the attributes with the new coordinates for
    #    desired movement; these are usually +/- 1 of the current
    #    state, depending on direction.
    #
    # @api private
    #
    class Move

      include Vedeu::Repositories::Defaults
      extend Forwardable

      def_delegators :geometry,
                     :x,
                     :xn,
                     :y,
                     :yn

      # @param (see #initialize)
      # @return (see #move)
      def self.move(attributes = {})
        new(attributes).move
      end

      # @return [Boolean|Vedeu::Geometries::Geometry]
      def move
        return false unless valid?

        Vedeu::Geometries::Geometry.store(new_attributes) do
          update_cursor!
          Vedeu.trigger(:_movement_refresh_, name)
        end
      end

      protected

      # @!attribute [r] direction
      # @return [Symbol] The direction to move; one of: :down, :left,
      #   :origin, :right, :up.
      attr_reader :direction

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      # @!attribute [r] offset
      # @return [Symbol] The number of columns or rows to move by.
      attr_reader :offset

      private

      # @return [Hash<Symbol => Symbol>]
      def cursor_event
        {
          down:   :_cursor_down_,
          left:   :_cursor_left_,
          origin: :_cursor_origin_,
          right:  :_cursor_right_,
          up:     :_cursor_up_,
        }[direction]
      end

      # @macro defaults_method
      def defaults
        {
          direction: :none,
          name:      nil,
          offset:    1,
        }
      end

      # @return [Boolean]
      def direction?
        direction != :none
      end

      # @return [Hash<Symbol => Hash<Symbol => Integer>>]
      def directional_move
        movement.fetch(direction, {})
      end

      # @return [Hash<Symbol => Integer>]
      def down
        {
          y:  y + offset,
          yn: yn + offset,
        }
      end

      # @macro geometry_by_name
      def geometry
        @geometry ||= Vedeu.geometries.by_name(name)
      end

      # @return [Hash<Symbol => Integer>]
      def left
        {
          x:  x - offset,
          xn: xn - offset,
        }
      end

      # Moves the geometry in the direction given by the offset also
      # given.
      #
      # @return [Hash<Symbol => Hash<Symbol => Integer>>]
      def movement
        {
          down:   down,
          left:   left,
          none:   {},
          origin: origin,
          right:  right,
          up:     up,
        }
      end

      # @return [Hash<Symbol => Boolean|String|Symbol>]
      def new_attributes
        geometry.attributes.merge!(unalign_unmaximise)
      end

      # @return [Hash<Symbol => Integer>]
      def origin
        {
          x:  1,
          xn: (xn - x + 1),
          y:  1,
          yn: (yn - y + 1),
        }
      end

      # @return [Hash<Symbol => Integer>]
      def right
        {
          x:  x + offset,
          xn: xn + offset,
        }
      end

      # @return [Hash<Symbol => Boolean|Symbol]
      def unalign_unmaximise
        {
          horizontal_alignment: :none,
          maximised:            false,
          vertical_alignment:   :none,
        }.merge(directional_move)
      end

      # @return [Hash<Symbol => Integer>]
      def up
        {
          y:  y - offset,
          yn: yn - offset,
        }
      end

      # Refresh the cursor after moving.
      #
      # @return [void]
      def update_cursor!
        if direction == :origin
          Vedeu.trigger(cursor_event, name)

        else
          Vedeu.trigger(cursor_event, name, 0)

        end
      end

      # @return [Boolean]
      def valid?
        {
          down:   valid_down?,
          left:   valid_left?,
          origin: true,
          none:   false,
          right:  valid_right?,
          up:     valid_up?,
        }.fetch(direction, false)
      end

      # @return [Boolean]
      def valid_down?
        Vedeu::Point.valid?(value: yn + offset, max: Vedeu.height)
      end

      # @return [Boolean]
      def valid_left?
        Vedeu::Point.valid?(value: x - offset, min: 1)
      end

      # @return [Boolean]
      def valid_right?
        Vedeu::Point.valid?(value: xn + offset, max: Vedeu.width)
      end

      # @return [Boolean]
      def valid_up?
        Vedeu::Point.valid?(value: y - offset, min: 1)
      end

    end # Move

  end # Geometries

end # Vedeu
