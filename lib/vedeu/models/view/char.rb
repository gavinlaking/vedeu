require 'vedeu/output/html_char'
require 'vedeu/output/presentation'

module Vedeu

  # A Char represents a single character of the terminal. It is a container for
  # the a single character in a {Vedeu::Stream}.
  #
  # Though a multi-character String can be passed as a value, only the first
  # character is returned in the escape sequence.
  #
  class Char

    include Vedeu::Presentation

    # @!attribute [rw] border
    # @return [Border]
    attr_accessor :border

    # @!attribute [rw] parent
    # @return [Line]
    attr_accessor :parent

    # @!attribute [r] value
    # @return [String]
    attr_reader :value

    # Returns a new instance of Char.
    #
    # @param attributes [Hash]
    # @option attributes value    [String]
    # @option attributes parent   [Line]
    # @option attributes colour   [Colour]
    # @option attributes style    [Style]
    # @option attributes position [Position]
    # @option attributes border   [Boolean]
    # @return [Char]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @border   = @attributes[:border]
      @colour   = @attributes[:colour]
      @parent   = @attributes[:parent]
      @style    = @attributes[:style]
      @value    = @attributes[:value]
    end

    # @param other [Vedeu::Char]
    # @return [Boolean]
    def ==(other)
      eql?(other)
    end

    # @param other [Vedeu::Char]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && value == other.value
    end

    # @return [Vedeu::Position]
    def position
      @position ||= Vedeu::Position.coerce(attributes[:position])
    end

    # Sets the position of the Char.
    #
    # @param value [Vedeu::Position]
    # @return [Vedeu::Position]
    def position=(value)
      @position = Vedeu::Position.coerce(value)
    end

    # Returns the x position for the Char if set.
    #
    # @return [Fixnum|NilClass]
    def x
      position.x if position
    end

    # Returns the y position for the Char if set.
    #
    # @return [Fixnum|NilClass]
    def y
      position.y if position
    end

    # @return [String]
    def to_html
      @to_html ||= HTMLChar.render(self)
    end

    private

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    # The default values for a new instance of this class.
    #
    # @return [Hash]
    def defaults
      {
        border:   nil,
        colour:   nil,
        parent:   nil,
        position: nil,
        style:    nil,
        value:    '',
      }
    end

  end # Char

end # Vedeu
