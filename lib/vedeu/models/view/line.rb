require 'vedeu/dsl/dsl'
require 'vedeu/presentation/presentation'

module Vedeu

  # A Line represents a single row of the terminal. It is a container for
  # {Vedeu::Stream} objects. A line's width is determined by the
  # {Vedeu::Interface} it belongs to.
  #
  # @api private
  class Line

    extend  Vedeu::DSL
    include Vedeu::Presentation

    attr_accessor :colour, :parent, :style

    # Returns a new instance of Line.
    #
    # @return [Line]
    def initialize(streams = [], parent = nil, colour = nil, style = nil)
      @streams = streams
      @parent  = parent
      @colour  = colour
      @style   = style
    end

    def self.build(streams = [], parent = nil, colour = nil, style = nil, &block)
      model = new(streams, parent, colour, style)
      model.deputy.instance_eval(&block) if block_given?
      model
    end

    # Returns an array of all the characters with formatting for this line.
    #
    # @return [Array]
    # @see Vedeu::Stream
    def chars
      return [] if empty?

      streams.all.map(&:chars).flatten
    end

    # Returns the class responsible for defining the DSL methods of this model.
    #
    # @return [DSL::Line]
    def deputy
      Vedeu::DSL::Line.new(self)
    end

    # Returns a boolean indicating whether the line has content.
    #
    # @return [Boolean]
    def empty?
      size == 0
    end

    # Returns the size of the content in characters without formatting.
    #
    # @return [Fixnum]
    def size
      streams.all.map(&:size).inject(0, :+) { |sum, x| sum += x }
    end

    def streams
      Vedeu::Model::Streams.coerce(@streams, nil, self)
    end
    alias_method :data, :streams

    private

  end # Line

end # Vedeu
