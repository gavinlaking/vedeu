require 'vedeu/presentation/presentation'
require 'vedeu/models/view/char'

module Vedeu

  # A Stream can represent a character or collection of characters as part of a
  # {Vedeu::Line} which you wish to colour and style independently of the other
  # characters in that line.
  #
  # @api private
  class Stream

    include Vedeu::Model
    include Vedeu::Presentation

    attr_accessor :parent, :value

    alias_method :content, :value
    alias_method :data,    :value
    alias_method :text,    :value

    class << self
      def build(attributes = {}, &block)
        attributes = defaults.merge(attributes)

        model = new(attributes[:value],
                    attributes[:parent],
                    attributes[:colour],
                    attributes[:style])
        model.deputy(attributes[:client]).instance_eval(&block) if block_given?
        model
      end

      private

      def defaults
        {
          client: nil,
          colour: nil,
          parent: nil,
          style:  nil,
          value:  '',
        }
      end
    end

    # Returns a new instance of Stream.
    #
    # @param value  [String]
    # @param parent [Line]
    # @param colour [Colour]
    # @param style  [Style]
    # @return [Stream]
    def initialize(value = '', parent = nil, colour = nil, style = nil)
      @value  = value
      @parent = parent
      @colour = colour
      @style  = style
    end

    # Returns an array of characters, each element is the escape sequences of
    # colours and styles for this stream, the character itself, and the escape
    # sequences of colours and styles for the parent of the stream
    # ({Vedeu::Line}).
    #
    # @return [Array]
    def chars
      return [] if value.empty?

      value.chars.map do |char|
        Vedeu::Char.new(char, parent, colour, style, nil).to_s
      end
    end

    # Returns a boolean indicating whether the stream has content.
    #
    # @return [Boolean]
    def empty?
      value.empty?
    end

    # Returns the size of the content in characters without formatting.
    #
    # @return [Fixnum]
    def size
      value.size
    end

    def value
      # Char.coerce(@value, parent, colour, style)
      @value
    end

    private

  end # Stream

end # Vedeu
