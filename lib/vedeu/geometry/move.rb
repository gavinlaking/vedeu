module Vedeu

  module Geometry

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

      extend Forwardable

      def_delegators :geometry,
                     :x,
                     :xn,
                     :y,
                     :yn

      # @param attributes See #initialize
      # @return See #move
      def self.move(attributes = {})
        new(attributes).move
      end

      # Returns a new instance of Vedeu::Geometry::Move.
      #
      # @param attributes [Hash<Symbol => Boolean|Fixnum|String|
      #   Symbol|Vedeu::Geometry::Repository]
      # @option attributes name [String|Symbol] The name of the
      #   interface/view.
      # @option attributes direction [Symbol] The direction to move;
      #   one of: :down, :left, :origin, :right, :up.
      # @option attributes offset [Fixnum] The number of columns or
      #   rows to move by.
      # @return [Vedeu::Geometry::Move]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value || defaults.fetch(key))
        end
      end

      # @return [FalseClass|Vedeu::Geometry::Geometry]
      def move
        return false unless valid_direction? && valid_offset?

        Vedeu::Geometry::Geometry.store(new_attributes) do
          update_cursor!
          refresh!
        end
      end

      protected

      # @!attribute [r] direction
      # @return [Symbol]
      attr_reader :direction

      # @!attribute [r] name
      # @return [String|Symbol]
      attr_reader :name

      # @!attribute [r] offset
      # @return [Symbol]
      attr_reader :offset

      private

      # @return [Hash<Symbol => Fixnum|String|Symbol>]
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
      def event
        {
          down:   :_cursor_down_,
          left:   :_cursor_left_,
          origin: :_cursor_origin_,
          right:  :_cursor_right_,
          up:     :_cursor_up_,
        }[direction]
      end

      # @return [Vedeu::Geometry::Geometry]
      def geometry
        Vedeu.geometries.by_name(name)
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

      # Refresh the screen after moving.
      #
      # @return [void]
      def refresh!
        Vedeu.trigger(:_movement_refresh_, name)
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
        Vedeu.trigger(event, name)
      end

      # @return [Boolean]
      def valid_direction?
        [:down, :left, :origin, :right, :up].include?(direction)
      end

      # @return [Boolean]
      def valid_offset?
        {
          down:   proc { yn + offset <= Vedeu.height },
          left:   proc { x  - offset >= 1 },
          origin: proc { true },
          right:  proc { xn + offset <= Vedeu.width },
          up:     proc { y  - offset >= 1 },
        }.fetch(direction, proc { false }).call
      end

    end # Move

  end # Geometry

end # Vedeu
