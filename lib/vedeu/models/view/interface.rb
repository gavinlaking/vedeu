require 'vedeu/support/common'
require 'vedeu/support/content_geometry'
require 'vedeu/models/model'
require 'vedeu/presentation/presentation'
require 'vedeu/buffers/display_buffer'
require 'vedeu/buffers/buffer'

require 'vedeu/models/view/lines'

module Vedeu

  # An Interface represents a portion of the terminal defined by
  # {Vedeu::Geometry}. It is a container for {Vedeu::Line} and {Vedeu::Stream}
  # objects.
  #
  # @api private
  class Interface

    extend Forwardable

    include Vedeu::Common
    include Vedeu::Model
    include Vedeu::Presentation
    include Vedeu::DisplayBuffer

    attr_accessor :border,
      :colour,
      :delay,
      :geometry,
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

      # @return [Boolean]
      def not_registered?(name)
        return true if undefined?(name)
        return true unless Vedeu.interfaces.registered?(name)

        false
      end

      # @return [Boolean]
      def undefined?(value)
        value.nil? || value.empty?
      end
    end

    # Return a new instance of Interface.
    #
    # @param name [String]
    # @param lines []
    # @param parent []
    # @param colour []
    # @param style []
    # @return [Interface]
    def initialize(name = '', lines = [], parent = nil, colour = nil, style = nil)
      @name   = name
      @lines  = lines
      @parent = parent
      @colour = colour
      @style  = style

      @border   = nil
      @delay    = 0.0
      @geometry = nil
      @group    = ''

      @repository = Vedeu.interfaces
    end

    def add(child)
      @lines = lines.add(child)
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

    # Returns log friendly output.
    #
    # @return [String]
    def inspect
      "<#{self.class.name} (lines:#{lines.size})>"
    end

    # @return [Vedeu::Lines]
    def lines
      children.coerce(@lines, self)
    end
    alias_method :content, :lines
    alias_method :value, :lines

    # Returns a boolean indicating whether the interface has content.
    #
    # @return [Boolean]
    def lines?
      lines.any?
    end

    def render
      if border
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

    private

    # Return the class name for the children on this model.
    #
    # @return [Class]
    def child
      Vedeu::Line
    end

    # Return the class name for the children on this model.
    #
    # @return [Class]
    def children
      Vedeu::Lines
    end

  end # Interface

end # Vedeu
