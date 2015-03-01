require 'vedeu/output/presentation'
require 'vedeu/models/view/streams'
require 'vedeu/models/view/stream'

module Vedeu

  # A Line represents a single row of the terminal. It is a container for
  # {Vedeu::Stream} objects. A line's width is determined by the
  # {Vedeu::Interface} it belongs to.
  #
  # @api private
  #
  class Line

    include Vedeu::Model
    include Vedeu::Presentation

    collection Vedeu::Streams
    member     Vedeu::Stream

    attr_accessor :parent,
      :streams

    alias_method :value, :streams

    # Returns a new instance of Line.
    #
    # @param attributes [Hash]
    # @option attributes streams [Vedeu::Streams]
    # @option attributes parent [Vedeu::Interface]
    # @option attributes colour [Vedeu::Colour]
    # @option attributes style [Vedeu::Style]
    # @return [Vedeu::Line]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)
      @colour     = @attributes[:colour]
      @parent     = @attributes[:parent]
      @streams    = @attributes[:streams]
      @style      = @attributes[:style]
    end

    # @param child []
    # @return [void]
    def add(child)
      @streams = streams.add(child)
    end

    # Returns an array of all the characters with formatting for this line.
    #
    # @return [Array]
    # @see Vedeu::Stream
    def chars
      return [] if empty?

      streams.map(&:chars).flatten
    end

    # Returns a boolean indicating whether the line has content.
    #
    # @return [Boolean]
    def empty?
      streams.empty?
    end

    # Returns the size of the content in characters without formatting.
    #
    # @return [Fixnum]
    def size
      streams.map(&:size).inject(0, :+) { |sum, x| sum += x }
    end

    # @return [Vedeu::Streams]
    def streams
      collection.coerce(@streams, self)
    end

    # Delegate to Vedeu::Interface#width if available.
    #
    # @return [Fixnum]
    def width
      parent.width if parent
    end

    private

    # The default values for a new instance of this class.
    #
    # @return [Hash]
    def defaults
      {
        client:  nil,
        colour:  nil,
        parent:  nil,
        streams: [],
        style:   nil,
      }
    end

  end # Line

end # Vedeu
