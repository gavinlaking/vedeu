require 'vedeu/support/common'
require 'vedeu/models/model'
require 'vedeu/presentation/presentation'
require 'vedeu/buffers/display_buffer'
require 'vedeu/buffers/buffer'

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

    attr_accessor :border, :colour, :delay, :geometry, :group, :lines, :name,
                  :parent, :style
    alias_method :content, :lines
    alias_method :value, :lines

    def_delegators :geometry, :north, :east,  :south,  :west,
                              :top,   :right, :bottom, :left,
                              :width, :height, :origin

    class << self

      # Build models using a simple DSL when a block is given, otherwise returns a
      # new instance of the class including this module.
      #
      # @param attributes [Hash]
      # @param block [Proc]
      # @return [Class]
      def build(attributes = {}, &block)
        attrs = defaults.merge!(attributes)

        model = new(attrs[:name],
                    attrs[:lines],
                    attrs[:parent],
                    attrs[:colour],
                    attrs[:style])
        model.deputy.instance_eval(&block) if block_given?
        model
      end

      private

      def defaults
        {
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
    # @param lines []
    # @param parent []
    # @param colour []
    # @param style []
    # @return [Interface]
    def initialize(name = '', lines = [], parent = nil, colour = nil, style = nil)
      @name   = name
      @lines  = Vedeu::Model::Lines.new(lines, self)
      @parent = parent
      @colour = colour
      @style  = style

      @border   = nil
      @delay    = 0.0
      @geometry = false
      @group    = ''

      @repository = Vedeu.interfaces
    end

    def store
      super

      store_refresh_events

      store_focusable

      store_cursor
    end

    private

  end # Interface

end # Vedeu
