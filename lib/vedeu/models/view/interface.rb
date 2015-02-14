require 'vedeu/support/content_geometry'
require 'vedeu/models/model'
require 'vedeu/presentation/presentation'
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

    attr_accessor :border,
      :colour,
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

    class << self

      # Build interfaces using a simple DSL.
      # If a name is provided as part of the attributes, we check the repository
      # for an interface of the same name and update it from the new attributes
      # provided, or if a block is given, new parameters set via the DSL.
      #
      # @param attributes [Hash]
      # @option attributes client []
      # @option attributes colour []
      # @option attributes lines []
      # @option attributes name []
      # @option attributes parent []
      # @option attributes style []
      # @param block [Proc]
      # @return [Class]
      def build(attributes = {}, &block)
        attributes = defaults.merge(attributes)
        model = new(attributes[:name],
                    attributes[:lines],
                    attributes[:parent],
                    attributes[:colour],
                    attributes[:style])
        model.deputy(attributes[:client]).instance_eval(&block) if block_given?
        model
      end

      private

      # The default values for a new instance of this class.
      #
      # @return [Hash]
      def defaults
        {
          client: nil,
          colour: nil,
          lines:  [],
          name:   '',
          parent: nil,
          style:  nil,
        }
      end
    end

    # Return a new instance of Interface.
    #
    # @param name [String]
    # @param lines [Vedeu::Lines]
    # @param parent [Vedeu::Composition]
    # @param colour [Vedeu::Colour]
    # @param style [Vedeu::Style]
    # @return [Interface]
    def initialize(name = '', lines = [], parent = nil, colour = nil, style = nil)
      @name   = name
      @lines  = lines
      @parent = parent
      @colour = colour
      @style  = style

      @border   = nil
      @delay    = 0.0
      @group    = ''

      @repository = Vedeu.interfaces
    end

    # @param child []
    # @return []
    def add(child)
      @lines = lines.add(child)
    end

    # @return [Hash]
    def attributes
      {
        border:   border,
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
      !!(border)
    end

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

    # Renders the interface with a border if one is defined.
    #
    # @return [Array]
    def render
      if border?
        border.render

      else
        viewport

      end
    end

    # @return [Interface]
    def store
      super

      store_new_buffer
      store_refresh_events
      store_focusable
      store_cursor
      store_group
    end

    # return [Array]
    def viewport
      Vedeu::Viewport.show(self)
    end

  end # Interface

end # Vedeu
