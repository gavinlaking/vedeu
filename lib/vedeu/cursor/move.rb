module Vedeu

  # Adjusts the position of the cursor or view. To use this class, call the
  # appropriate event:
  #
  # @example
  #   Vedeu.trigger(:_cursor_down_)
  #
  #   Vedeu.trigger(:_cursor_left_) # When a name is not given, the cursor in
  #                                 # the interface which is currently in focus
  #                                 # should move to the left.
  #
  #   Vedeu.trigger(:_cursor_left_, 'my_interface')
  #                                 # When a name is given, the cursor instance
  #                                 # belonging to this interface moves to the
  #                                 # left.
  #
  #   Vedeu.trigger(:_cursor_right_)
  #   Vedeu.trigger(:_cursor_up_)
  #
  #   Vedeu.trigger(:_cursor_origin_)                 # /or/
  #   Vedeu.trigger(:_cursor_origin_, 'my_interface')
  #                                 # Moves the cursor to the top left of the
  #                                 # named or current interface in focus.
  #
  #   Vedeu.trigger(:_view_down_,  'my_interface')
  #   Vedeu.trigger(:_view_left_,  'my_interface')
  #   Vedeu.trigger(:_view_right_, 'my_interface')
  #   Vedeu.trigger(:_view_up_,    'my_interface')
  #
  # @note
  #   The cursor or view may not be visible, but it will still move if
  #     requested.
  #   The cursor will not exceed the border or boundary of the interface, or
  #     boundary of the visible terminal.
  #   The cursor will move freely within the bounds of the interface,
  #     irrespective of content.
  #   The view will not exceed the boundary of the visible terminal.
  #   The view will move freely within the bounds of the interface,
  #     irrespective of content.
  #
  class Move

    extend Forwardable

    def_delegators :geometry, :x, :xn, :y, :yn

    # Move the named cursor or view, or that which is currently in focus in the
    # specified direction.
    #
    # @param direction [Symbol] The direction of travel. Directions include:
    #   (:down, :left, :right, :up, :origin). When ':origin' the cursor is moved
    #   to the top left of the interface.
    # @param name [String|NilClass] The name of the interface/cursor to be
    #   moved; when not given, the interface currently in focus determines which
    #   cursor instance to move.
    # @return [Vedeu::Cursor]
    def self.by_name(entity, direction, name = nil)
      name = name ? name : Vedeu.focus

      Vedeu::Move.send(direction, entity, name)
    end

    # Moves the cursor or view down by one row.
    #
    # @param entity [Class]
    # @param name [String]
    # @return [Vedeu::Cursor]
    def self.down(entity, name)
      new(entity, name, 1, 0).move
    end

    # Moves the cursor or view left by one column.
    #
    # @param entity [Class]
    # @param name [String]
    # @return [Vedeu::Cursor]
    def self.left(entity, name)
      new(entity, name, 0, -1).move
    end

    # Moves the cursor or view right by one column.
    #
    # @param entity [Class]
    # @param name [String]
    # @return [Vedeu::Cursor]
    def self.right(entity, name)
      new(entity, name, 0, 1).move
    end

    # Moves the cursor or view up by one row.
    #
    # @param entity [Class]
    # @param name [String]
    # @return [Vedeu::Cursor]
    def self.up(entity, name)
      new(entity, name, -1, 0).move
    end

    # Moves the cursor or view to the top left coordinate of the interface or
    # terminal screen.
    #
    # @param entity [Class]
    # @param name [String]
    # @return [Vedeu::Cursor]
    def self.origin(entity, name)
      new(entity, name, -2000, -2000).move
    end

    # Returns an instance of Vedeu::Move.
    #
    # @param entity [Class]
    # @param name [String] The name of the cursor or view.
    # @param dy [Fixnum] Move up (-1), or down (1), or no action (0).
    # @param dx [Fixnum] Move left (-1), or right (1), or no action (0).
    # @return [Vedeu::Move]
    def initialize(entity, name = nil, dy = 0, dx = 0)
      @entity = entity
      @name   = name ? name : Vedeu.focus
      @dy     = dy
      @dx     = dx
    end

    # Returns a newly positioned and stored cursor or view.
    #
    # @return [Vedeu::Cursor|Vedeu::Geometry]
    def move
      model = entity.new(merged_attributes).store

      refresh

      model
    end

    # @return [void]
    def refresh
      if entity.to_s == 'Vedeu::Geometry'
        Vedeu.trigger(:_clear_)
        Vedeu.trigger(:_refresh_)
        Vedeu.trigger(:_clear_, name)
        Vedeu.trigger(:_refresh_, name)

      else
        Vedeu.trigger(:_refresh_cursor_, name)

      end
    end

    # @return [Hash<Symbol => Boolean,Fixnum, String>]
    def merged_attributes
      if entity.to_s == 'Vedeu::Geometry'
        geometry_attributes

      else
        cursor_attributes

      end
    end

    protected

    # @!attribute [r] dx
    # @return [Fixnum]
    attr_reader :dx

    # @!attribute [r] dy
    # @return [Fixnum]
    attr_reader :dy

    # @!attribute [r] entity
    # @return [Fixnum]
    attr_reader :entity

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    private

    # @return [Vedeu::Coordinate]
    def coordinate
      @coordinate ||= Vedeu::Coordinate.new(name, oy, ox)
    end

    # @see Vedeu::Cursors#by_name
    def cursor
      @cursor ||= Vedeu.cursors.by_name(name)
    end

    # @return [Hash<Symbol => void>]
    def cursor_attributes
      cursor.attributes.merge!(x:  coordinate.x_position,
                               y:  coordinate.y_position,
                               ox: ox,
                               oy: oy)
    end

    # @see Vedeu::Geometries#by_name
    def geometry
      @geometry ||= Vedeu.geometries.by_name(name)
    end

    # @return [Hash<Symbol => FalseClass,String,Fixnum>]
    def geometry_attributes
      {
        centred:    false,
        maximised:  false,
        name:       name,
        x:          (x + dx),
        y:          (y + dy),
        xn:         (xn + dx),
        yn:         (yn + dy),
      }
    end

    # Apply the direction amount to the cursor offset. If the offset is less
    # than 0, correct to 0.
    #
    # @return [Fixnum]
    def ox
      ox = cursor.ox + dx
      ox = 0 if ox < 0
      ox
    end

    # Apply the direction amount to the cursor offset. If the offset is less
    # than 0, correct to 0.
    #
    # @return [Fixnum]
    def oy
      oy = cursor.oy + dy
      oy = 0 if oy < 0
      oy
    end

  end # Move

end # Vedeu
