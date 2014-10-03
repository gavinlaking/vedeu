module Vedeu

  # An Interface represents a portion of the terminal defined by
  # {Vedeu::Geometry}. It is a container for {Vedeu::Line} and {Vedeu::Stream}
  # objects.
  #
  # @api private
  class Interface

    include Coercions
    include Common
    include Presentation

    extend Forwardable

    def_delegators :geometry, :north, :east, :south, :west, :top, :right,
                              :bottom, :left, :width, :height, :origin,
                              :viewport_width, :viewport_height

    attr_reader :attributes, :delay, :group, :name, :parent

    # Builds up a new Interface object and returns the attributes.
    #
    # @param  attributes [Hash]
    # @param  block [Proc]
    # @return [Hash]
    def self.build(attributes = {}, &block)
      new(attributes, &block).attributes
    end

    # @see Vedeu::API#interface
    # @param attributes [Hash]
    # @param block [Proc]
    # @return []
    def self.define(attributes = {}, &block)
      new(attributes).define(&block)
    end

    # Return a new instance of Interface.
    #
    # @param  attributes [Hash]
    # @param  block [Proc]
    # @return [Interface]
    def initialize(attributes = {}, &block)
      @attributes = defaults.merge!(attributes)

      @name  = @attributes[:name]
      @group = @attributes[:group]
      @delay = @attributes[:delay]
      @parent = @attributes[:parent]

      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end
    end

    # @see Vedeu::API#interface
    # @param block [Proc]
    # @return [Interface]
    def define(&block)
      instance_eval(&block) if block_given?

      Registrar.record(attributes)

      self
    end

    # Returns a boolean indicating whether this interface is currently in focus.
    #
    # @return [Boolean]
    def in_focus?
      Focus.current?(name)
    end

    # Returns a collection of lines associated with this interface.
    #
    # @return [Array]
    def lines
      @lines ||= Line.coercer(attributes[:lines])
    end

    # Returns the position and size of the interface.
    #
    # @return [Geometry]
    def geometry
      @geometry ||= Geometry.new(attributes[:geometry])
    end

    private

    # The default values for a new instance of Interface.
    #
    # @api private
    # @return [Hash]
    def defaults
      {
        name:     '',
        group:    '',
        lines:    [],
        colour:   {},
        style:    '',
        geometry: {},
        delay:    0.0,
        parent:   nil,
      }
    end

    # @api private
    # @return []
    def method_missing(method, *args, &block)
      Vedeu.log("Interface#method_missing #{method.to_s} #{args.inspect}")

      @self_before_instance_eval.send(method, *args, &block)
    end

  end # Interface

end # Vedeu
