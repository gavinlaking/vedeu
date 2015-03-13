module Vedeu

  class RefreshCursor

    # @param (see #initialize)
    def self.render(name)
      new(name).render
    end

    # @param name [String] The name of the cursor.
    # @return [Vedeu::RefreshCursor]
    def initialize(name)
      @name = name
    end

    # @return [Array]
    def render
      Vedeu::Refresh.by_name(name) if refresh_view?

      Vedeu::Terminal.output(new_cursor.to_s)
    end

    private

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    # @return [Boolean]
    def refresh_view?
      new_cursor.ox >= interface_width || new_cursor.oy >= interface_height
    end

    # @return [Vedeu::Cursor]
    def new_cursor
      @new_cursor ||= Vedeu::Cursor.new(cursor.attributes.merge(position))
    end

    # @return [Hash<Symbol => Fixnum>]
    def position
      {
        x: validated_position.x,
        y: validated_position.y,
      }
    end

    # @return [Vedeu::PositionValidator]
    def validated_position
      @position ||= Vedeu::PositionValidator.validate(interface,
                                                      cursor.x,
                                                      cursor.y)
    end

    # @return [Vedeu::Cursor]
    def cursor
      @cursor ||= Vedeu.cursors.find(name)
    end

    # @return [Fixnum]
    def interface_height
      if interface.border?
        interface.border.height

      else
        interface.height

      end
    end

    # @return [Fixnum]
    def interface_width
      if interface.border?
        interface.border.width

      else
        interface.width

      end
    end

    # @return [Vedeu::Interface]
    def interface
      @interface ||= Vedeu.interfaces.find(name)
    end

  end # RefreshCursor

end # Vedeu
