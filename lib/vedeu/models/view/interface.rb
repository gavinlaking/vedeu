require 'vedeu/dsl/dsl'

require 'vedeu/support/common'
require 'vedeu/buffers/display_buffer'
require 'vedeu/models/model'
require 'vedeu/presentation/presentation'

module Vedeu

  # An Interface represents a portion of the terminal defined by
  # {Vedeu::Geometry}. It is a container for {Vedeu::Line} and {Vedeu::Stream}
  # objects.
  #
  # @api private
  class Interface

    extend Vedeu::DSL
    extend Forwardable

    include Vedeu::Common
    include Vedeu::Model
    include Vedeu::Presentation
    include Vedeu::DisplayBuffer

    def_delegators :geometry, :north, :east,  :south,  :west,
                              :top,   :right, :bottom, :left,
                              :width, :height, :origin

    attr_reader :attributes

    attr_accessor :border, :delay, :geometry, :group, :lines, :name
    alias_method :content, :lines

    attr_accessor :parent

    class << self

      include Vedeu::Common

      def build(lines = [], parent = nil, colour = nil, style = nil, &block)
        model = new({ lines: lines, parent: parent, colour: colour, style: style })
        model.deputy.instance_eval(&block) if block_given?
        model
      end

    end

    # Return a new instance of Interface.
    #
    # @param  attributes [Hash]
    # @param  block [Proc]
    # @return [Interface]
    def initialize(attributes = {})
      @attributes = defaults.merge(attributes)

      @border   = nil
      @colour   = nil
      @delay    = 0.0
      @geometry = nil
      @group    = ''
      @name     = ''
      @lines    = Vedeu::Model::Lines.new(@attributes[:lines], self)
    end

    # Returns the class responsible for defining the DSL methods of this model.
    #
    # @return [DSL::Interface]
    def deputy
      Vedeu::DSL::Interface.new(self)
    end

    def lines
      @lines
    end
    alias_method :value, :lines

    # @return [Interface]
    def store
      options = { delay: delay }

      if name
        event = "_refresh_#{name}_".to_sym

        unless Vedeu.events_repository.registered?(event)
          Vedeu.event(event, options) { Vedeu::Refresh.by_name(name) }
        end
      end

      if group
        event = "_refresh_group_#{group}_".to_sym

        unless Vedeu.events_repository.registered?(event)
          Vedeu.event(event, options) { Vedeu::Refresh.by_group(group) }
        end
      end

      super
    end

    private

    # @return [Repository] The repository class for this model.
    def repository
      Vedeu.interfaces_repository
    end

    # The default values for a new instance of Interface.
    #
    # @return [Hash]
    def defaults
      {
        lines:    [],
        parent:   nil,
        style:    '',
      }
    end

  end # Interface

end # Vedeu
