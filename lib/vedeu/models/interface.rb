module Vedeu

  # An Interface represents a portion of the terminal defined by
  # {Vedeu::Geometry}. It is a container for {Vedeu::Line} and {Vedeu::Stream}
  # objects.
  #
  class Interface

    include Vedeu::Model
    include Vedeu::Presentation
    include Vedeu::DisplayBuffer
    include Vedeu::Toggleable

    collection Vedeu::Lines
    member     Vedeu::Line

    # @!attribute [rw] client
    # @return [Fixnum|Float]
    attr_accessor :client

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

    # @!attribute [rw] zindex
    # @return [Fixnum]
    attr_accessor :zindex

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    # @!attribute [w] lines
    # @return [Array<Vedeu::Line>]
    attr_writer :lines

    # Return a new instance of Vedeu::Interface.
    #
    # @param attributes [Hash]
    # @option attributes client [Vedeu::Client]
    # @option attributes colour [Vedeu::Colour]
    # @option attributes delay [Float]
    # @option attributes group [String]
    # @option attributes lines [Vedeu::Lines]
    # @option attributes name [String]
    # @option attributes parent [Vedeu::Composition]
    # @option attributes repository [Vedeu::Interfaces]
    # @option attributes style [Vedeu::Style]
    # @option attributes visible [Boolean]
    # @option attributes zindex [Fixnum]
    # @return [Vedeu::Interface]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @attributes.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    # @param child [Vedeu::Line]
    # @return [void]
    def add(child)
      @lines = lines.add(child)
    end

    # Hide a named interface buffer, or without a name, the buffer of the
    # currently focussed interface.
    #
    # @example
    #   Vedeu.hide_interface(name)
    #
    # @return [void]
    def hide
      super

      Vedeu.buffers.by_name(name).hide
    end

    # Override Ruby's Object#inspect method to provide a more helpful output.
    #
    # @return [String]
    def inspect
      '<Vedeu::Interface '      \
      "name: '#{name}', "       \
      "group: '#{group}', "     \
      "visible: '#{visible}', " \
      "zindex: '#{zindex}'"     \
      '>'
    end

    # @return [Vedeu::Lines]
    def lines
      collection.coerce(@lines, self)
    end
    alias_method :value, :lines

    # Returns a boolean indicating whether the interface has content.
    #
    # @return [Boolean]
    def lines?
      lines.any?
    end

    # Returns a boolean indicating whether the interface belongs to a
    # group.
    #
    # @return [Boolean]
    def group?
      !group.nil? && !group.empty?
    end

    # @return [Array<Array<Vedeu::Char>>]
    def render
      return [] unless visible?

      Vedeu.trigger(:_hide_cursor_, name)

      output = [
        Vedeu::Clear::NamedInterface.render(name),
        Vedeu::Viewport.render(self),
        Vedeu.borders.by_name(name).render,
      ]

      Vedeu.trigger(:_show_cursor_, name)

      output
    end

    # Show the named interface buffer, or without a name, the buffer of the
    # currently focussed interface.
    #
    # @example
    #   Vedeu.show_interface(name)
    #
    # @return [void]
    def show
      super

      Vedeu.buffers.by_name(name).show
    end

    # @return [Vedeu::Interface]
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
        client:     nil,
        colour:     nil,
        delay:      0.0,
        group:      '',
        lines:      [],
        name:       '',
        parent:     nil,
        repository: Vedeu.interfaces,
        style:      nil,
        visible:    true,
        zindex:     0,
      }
    end

  end # Interface

end # Vedeu
