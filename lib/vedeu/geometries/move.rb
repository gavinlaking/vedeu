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
      # @return [String|Symbol] The name of the interface/view.
      attr_reader :name

      # @!attribute [r] offset
      # @return [Symbol] The number of columns or rows to move by.
      attr_reader :offset

      private

      # @macro defaults_method
      def defaults
        {
          direction: :none,
          name:      '',
          offset:    1,
        }
      end

      # @return [Boolean]
      def direction?
        direction != :none
      end

      # Moves the geometry down by the offset.
      #
      # @return [Hash<Symbol => Fixnum]
      def down
        {
          y: y + offset,
          yn: yn + offset,
        }
      end

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

      # @return [Vedeu::Geometries::Geometry]
      def geometry
        @geometry ||= Vedeu.geometries.by_name(name)
      end

      # Moves the geometry left by the offset.
      #
      # @return [Hash<Symbol => Fixnum]
      def left
        {
          x: x - offset,
          xn: xn - offset,
        }
      end

      # @return [Hash<Symbol => Boolean|String|Symbol>]
      def new_attributes
        geometry.attributes.merge!(unalign_unmaximise).merge!(send(direction))
      end

      # Moves the geometry to the top left of the terminal.
      #
      # @return [Hash<Symbol => Fixnum]
      def origin
        {
          x:  1,
          xn: (xn - x + 1),
          y:  1,
          yn: (yn - y + 1),
        }
      end

      # Moves the geometry right by the offset.
      #
      # @return [Hash<Symbol => Fixnum]
      def right
        {
          x: x + offset,
          xn: xn + offset,
        }
      end

      # @return [Hash<Symbol => Boolean|Symbol]
      def unalign_unmaximise
        {
          horizontal_alignment: :none,
          maximised:            false,
          vertical_alignment:   :none,
        }
      end

      # Moves the geometry up by the offset.
      #
      # @return [Hash<Symbol => Fixnum]
      def up
        {
          y: y - offset,
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
          right:  valid_right?,
          up:     valid_up?,
        }.fetch(direction, false)
      end

      # @return [Boolean]
      def valid_down?
        yn + offset <= Vedeu.height
      end

      # @return [Boolean]
      def valid_left?
        x - offset >= 1
      end

      # @return [Boolean]
      def valid_right?
        xn + offset <= Vedeu.width
      end

      # @return [Boolean]
      def valid_up?
        y - offset >= 1
      end

    end # Move

  end # Geometries

  # :nocov:

  # {include:file:docs/events/by_name/movement_refresh.md}
  Vedeu.bind(:_movement_refresh_) do |name|
    Vedeu.trigger(:_clear_)
    Vedeu.trigger(:_refresh_)
    Vedeu.trigger(:_clear_view_, name)
    Vedeu.trigger(:_refresh_view_, name)
  end

  # {include:file:docs/events/by_name/view_down.md}
  Vedeu.bind(:_view_down_) do |name, offset|
    Vedeu::Geometries::Move.move(name: name, offset: offset, direction: :down)
  end

  # {include:file:docs/events/by_name/view_left.md}
  Vedeu.bind(:_view_left_) do |name, offset|
    Vedeu::Geometries::Move.move(name: name, offset: offset, direction: :left)
  end

  # {include:file:docs/events/by_name/view_right.md}
  Vedeu.bind(:_view_right_) do |name, offset|
    Vedeu::Geometries::Move.move(name: name, offset: offset, direction: :right)
  end

  # {include:file:docs/events/by_name/view_up.md}
  Vedeu.bind(:_view_up_) do |name, offset|
    Vedeu::Geometries::Move.move(name: name, offset: offset, direction: :up)
  end

  [:down, :left, :right, :up].each do |direction|
    Vedeu.bind_alias(:"_geometry_#{direction}_", :"_view_#{direction}_")
  end

  # :nocov:

end # Vedeu
