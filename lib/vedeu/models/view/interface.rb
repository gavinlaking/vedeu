require 'vedeu/support/content_geometry'
require 'vedeu/models/model'
require 'vedeu/output/presentation'
require 'vedeu/buffers/display_buffer'
require 'vedeu/buffers/buffer'

require 'vedeu/models/view/lines'
require 'vedeu/models/view/line'

module Vedeu

  # An Interface represents a portion of the terminal defined by
  # {Vedeu::Geometry}. It is a container for {Vedeu::Line} and {Vedeu::Stream}
  # objects.
  #
  # @api private
  class Interface

    extend Forwardable

    include Vedeu::Model
    include Vedeu::Presentation
    include Vedeu::DisplayBuffer

    collection Vedeu::Lines
    member     Vedeu::Line

    attr_accessor :colour,
      :delay,
      :group,
      :name,
      :parent,
      :style

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
      :width,
      :height,
      :origin

    # Return a new instance of Interface.
    #
    # @param attributes [Hash]
    # @option attributes colour [Vedeu::Colour]
    # @option attributes delay [Float]
    # @option attributes group [String]
    # @option attributes lines [Vedeu::Lines]
    # @option attributes name [String]
    # @option attributes parent [Vedeu::Composition]
    # @option attributes style [Vedeu::Style]
    # @return [Vedeu::Interface]
    def initialize(attributes = {})
      @attributes = defaults.merge(attributes)

      @colour     = Colour.coerce(@attributes[:colour])
      @delay      = @attributes[:delay]
      @group      = @attributes[:group]
      @lines      = @attributes[:lines]
      @name       = @attributes[:name]
      @parent     = @attributes[:parent]
      @repository = Vedeu.interfaces
      @style      = Style.coerce(@attributes[:style])
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
        colour:   colour,
        delay:    delay,
        group:    group,
        name:     name,
        parent:   parent,
        style:    style,
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
      if border?
        Vedeu.borders.find(name)
      end
    end

    # Fetch the cursor belonging to this interface (by name), if one does not
    # exist, it will be created, stored and returned.
    #
    # @return [Vedeu::Cursor]
    def cursor
      Vedeu.cursors.by_name(name)
    end

    # @return [Vedeu::Geometry]
    def geometry
      Vedeu.geometries.find(name)
    end

    # Returns log friendly output.
    #
    # @return [String]
    def inspect
      "<#{self.class.name} (lines:#{lines.size})>"
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

    # @return [Interface]
    def store
      super

      store_new_buffer
      store_focusable
      store_cursor
      store_group
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
      }
    end

  end # Interface

end # Vedeu
