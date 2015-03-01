require 'vedeu/output/html_char'
require 'vedeu/output/presentation'

module Vedeu

  # A Char represents a single character of the terminal. It is a container for
  # the a single character in a {Vedeu::Stream}.
  #
  # Though a multi-character String can be passed as a value, only the first
  # character is returned in the escape sequence.
  #
  # @api private
  #
  class Char

    include Vedeu::Presentation

    attr_accessor :border,
      :parent,
      :position

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
      @colour   = Vedeu::Colour.coerce(@attributes[:colour])
      @parent   = @attributes[:parent]
      @position = Vedeu::Position.coerce(@attributes[:position])
      @style    = @attributes[:style]
      @value    = @attributes[:value]
    end

    # @param other []
    # @return [Boolean]
    def ==(other)
      eql?(other)
    end

    # @param other []
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && value == other.value
    end

    # @return [String] The character.
    def value
      return '' unless @value

      @value
    end

    # @return [Fixnum|NilClass]
    def x
      position.x if position
    end

    # @return [Fixnum|NilClass]
    def y
      position.y if position
    end

    # @return [String]
    def to_html
      @to_html ||= HTMLChar.render(self)
    end

    private

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
        value:    nil,
      }
    end

  end # Char

end # Vedeu
