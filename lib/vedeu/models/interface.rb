require 'vedeu/models/all'
require 'vedeu/output/null_border'
require 'vedeu/output/presentation'
require 'vedeu/buffers/display_buffer'
require 'vedeu/buffers/buffer'

module Vedeu

  # An Interface represents a portion of the terminal defined by
  # {Vedeu::Geometry}. It is a container for {Vedeu::Line} and {Vedeu::Stream}
  # objects.
  #
  class Interface

    extend Forwardable

    include Vedeu::Model
    include Vedeu::Presentation
    include Vedeu::DisplayBuffer

    collection Vedeu::Lines
    member     Vedeu::Line

    # @!attribute [rw] delay
    # @return [Fixnum|Float]
    attr_accessor :delay

    # @!attribute [rw] group
    # @return [void]
    attr_accessor :group

    # @!attribute [rw] name
    # @return [String]
    attr_accessor :name

    # @!attribute [rw] parent
    # @return [Vedeu::Composition]
    attr_accessor :parent

    # @!attribute [rw] visible
    # @return [String|Symbol]
    attr_accessor :visible
    alias_method :visible?, :visible

    # @!attribute [w] lines
    # @return [Array<Vedeu::Line>]
    attr_writer :lines

    def_delegators :geometry,
                   :north,
                   :east,
                   :south,
                   :west,
                   :top,
                   :right,
                   :bottom,
                   :left,
                   :y,
                   :yn,
                   :x,
                   :xn,
                   :width,
                   :height,
                   :top_left,
                   :top_right,
                   :bottom_left,
                   :bottom_right

    # Return a new instance of Vedeu::Interface.
    #
    # @param attributes [Hash]
    # @option attributes colour [Vedeu::Colour]
    # @option attributes delay [Float]
    # @option attributes group [String]
    # @option attributes lines [Vedeu::Lines]
    # @option attributes name [String]
    # @option attributes parent [Vedeu::Composition]
    # @option attributes style [Vedeu::Style]
    # @option attributes visible [Boolean]
    # @return [Vedeu::Interface]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @colour     = @attributes[:colour]
      @delay      = @attributes[:delay]
      @group      = @attributes[:group]
      @lines      = @attributes[:lines]
      @name       = @attributes[:name]
      @parent     = @attributes[:parent]
      @repository = Vedeu.interfaces
      @style      = @attributes[:style]
      @visible    = @attributes[:visible]
    end

    # @param child []
    # @return [void]
    def add(child)
      @lines = lines.add(child)
    end

    # @note
    #   This may be unused. (GL 2015-02-20)
    #
    # @return [Hash]
    def attributes
      {
        colour:  colour,
        delay:   delay,
        group:   group,
        name:    name,
        parent:  parent,
        style:   style,
        visible: true,
      }
    end

    # Returns a boolean indicating whether the interface has a border.
    #
    # @return [Boolean]
    def border?
      Vedeu.borders.registered?(name)
    end

    # Returns the border object belonging to the interface.
    #
    # @return [Vedeu::Border|NilClass]
    def border
      @border ||= Vedeu.borders.by_name(name)
    end

    # @return [Array<Array<Vedeu::Char>>]
    def clear
      Vedeu::Clear.new(self)
    end

    # Fetch the cursor belonging to this interface (by name), if one does not
    # exist, it will be created, stored and returned.
    #
    # @return [Vedeu::Cursor]
    def cursor
      Vedeu.cursors.by_name(name)
    end

    # Returns a boolean indicating whether the interface has geometry.
    #
    # @return [Boolean]
    def geometry?
      Vedeu.geometries.registered?(name)
    end

    # @return [Vedeu::Geometry]
    def geometry
      @geometry ||= Vedeu.geometries.by_name(name)
    end

    # @return [Vedeu::Lines]
    def lines
      collection.coerce(@lines, self)
    end
    alias_method :content, :lines
    alias_method :value, :lines

    # Returns a boolean indicating whether the interface has content.
    #
    # @return [Boolean]
    def lines?
      lines.any?
    end
    alias_method :content?, :lines?
    alias_method :value?, :lines?

    # @return [Array<Array<Vedeu::Char>>]
    def render
      if visible?
        [
          hide_cursor,
          clear.render,
          border.render,
          viewport.render,
          show_cursor,
        ]

      else
        []

      end
    end

    # @return [Interface]
    def store
      super

      store_new_buffer
      store_focusable
      store_cursor
      store_group
    end

    # @return [Array<Array<Vedeu::Char>>]
    def viewport
      Vedeu::Viewport.new(self)
    end

    private

    # The default values for a new instance of this class.
    #
    # @return [Hash]
    def defaults
      {
        client: nil,
        colour: nil,
        delay:  0.0,
        group:  '',
        lines:  [],
        name:   '',
        parent: nil,
        style:  nil,
        visible: true,
      }
    end

    # @return [String]
    def hide_cursor
      return Vedeu::Esc.string(:hide_cursor) if cursor.visible?

      ''
    end

    # @return [String]
    def show_cursor
      return Vedeu::Esc.string(:show_cursor) if cursor.visible?

      ''
    end

  end # Interface

end # Vedeu
