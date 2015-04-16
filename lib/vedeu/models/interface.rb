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

    # @!attribute [rw] visible
    # @return [String|Symbol]
    attr_accessor :visible
    alias_method :visible?, :visible

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
    # @option attributes repository [Vedeu::InterfacesRepository]
    # @option attributes style [Vedeu::Style]
    # @option attributes visible [Boolean]
    # @return [Vedeu::Interface]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @client     = @attributes[:client]
      @delay      = @attributes[:delay]
      @group      = @attributes[:group]
      @lines      = @attributes[:lines]
      @name       = @attributes[:name]
      @parent     = @attributes[:parent]
      @repository = @attributes[:repository]
      @visible    = @attributes[:visible]
    end

    # @param child [Vedeu::Line]
    # @return [void]
    def add(child)
      @lines = lines.add(child)
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
      return [] unless visible?

      [
        hide_cursor,
        Vedeu::Clear.new(self).render,
        Vedeu.borders.by_name(name).render,
        Vedeu::Viewport.new(self).render,
        show_cursor,
      ]
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

    def cursor
      @cursor ||= Vedeu.cursors.by_name(name)
    end

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
      }
    end

    # @return [String]
    def hide_cursor
      return cursor.hide_cursor if cursor.visible?

      ''
    end

    # @return [String]
    def show_cursor
      return cursor.show_cursor if cursor.visible?

      ''
    end

  end # Interface

end # Vedeu
