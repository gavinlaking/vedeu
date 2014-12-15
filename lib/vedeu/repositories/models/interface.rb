module Vedeu

  # An Interface represents a portion of the terminal defined by
  # {Vedeu::Geometry}. It is a container for {Vedeu::Line} and {Vedeu::Stream}
  # objects.
  #
  # @api private
  class Interface

    include Coercions
    include Common
    include Model
    include Presentation

    extend Forwardable

    def_delegators :geometry, :north, :east, :south, :west, :top, :right,
                              :bottom, :left, :width, :height, :origin

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
      @attributes = defaults.merge(attributes)

      @cursor     = @attributes[:cursor]
      @delay      = @attributes[:delay]
      @group      = @attributes[:group]
      @name       = @attributes[:name]
      @parent     = @attributes[:parent]

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

    # Returns an instance of Border.
    #
    # @param attrs [Hash] See {Border#initialize} for details.
    # @param opts [Hash] See {Border#initialize} for details.
    # @return [Border]
    def border(attrs = {}, opts = {})
      @_border ||= Border.new(self, attrs, opts)
    end

    # Returns an instance of Cursor.
    #
    # @return [Cursor]
    def cursor
      @_cursor ||= Cursor.new({
        name:  name,
        state: attributes[:cursor],
        x:     geometry.x_position(offset.x),
        y:     geometry.y_position(offset.y),
      })
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
    alias_method :content, :lines

    # Returns the position and size of the interface.
    #
    # @return [Geometry]
    def geometry
      @geometry ||= Geometry.new(attributes[:geometry])
    end

    # Returns the current offset for the content within the interface.
    #
    # @return [Offset]
    def offset
      @offset ||= Offsets.find_or_create(name)
    end

    # Returns the currently visible area of the interface.
    #
    # @return [Viewport]
    def viewport
      @_viewport ||= Viewport.show(self)
    end

    private

    # @return [Class] The repository class for this model.
    def repository
      Vedeu::Interfaces
    end

    # The default values for a new instance of Interface.
    #
    # @return [Hash]
    def defaults
      {
        colour:   {},
        cursor:   :hide,
        delay:    0.0,
        geometry: {},
        group:    '',
        lines:    [],
        name:     '',
        parent:   nil,
        style:    '',
      }
    end

    # @param method [Symbol] The name of the method sought.
    # @param args [Array] The arguments which the method was to be invoked with.
    # @param block [Proc] The optional block provided to the method.
    # @return []
    def method_missing(method, *args, &block)
      Vedeu.log("Interface#method_missing '#{method}' (args: #{args.inspect})")

      @self_before_instance_eval.send(method, *args, &block) if @self_before_instance_eval
    end

  end # Interface

end # Vedeu
