module Vedeu

  # A Line represents a single row of the terminal. It is a container for
  # {Vedeu::Stream} objects. A line's width is determined by the
  # {Vedeu::Interface} it belongs to.
  #
  class Line

    include Vedeu::Model
    include Vedeu::Presentation

    collection Vedeu::Streams
    member     Vedeu::Stream

    # @!attribute [rw] parent
    # @return [Vedeu::Interface]
    attr_accessor :parent

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    # Returns a new instance of Vedeu::Line.
    #
    # @param attributes [Hash]
    # @option attributes streams [Vedeu::Streams]
    # @option attributes parent [Vedeu::Interface]
    # @option attributes colour [Vedeu::Colour]
    # @option attributes style [Vedeu::Style]
    # @return [Vedeu::Line]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @attributes.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    # @param child [void]
    # @return [void]
    def add(child)
      @_streams = @streams = collection.coerce(streams, self).add(child)
    end
    alias_method :<<, :add

    # Returns an array of all the characters with formatting for this line.
    #
    # @return [Array]
    # @see Vedeu::Stream
    def chars
      return [] if empty?

      @chars ||= streams.flat_map(&:chars)
    end

    # Returns a boolean indicating whether the line has content.
    #
    # @return [Boolean]
    def empty?
      streams.empty?
    end

    # An object is equal when its values are the same.
    #
    # @param other [Vedeu::Collection]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && streams == other.streams
    end
    alias_method :==, :eql?

    # @return [NilClass|String]
    def name
      parent.name if parent
    end

    # Returns the size of the content in characters without formatting.
    #
    # @return [Fixnum]
    def size
      streams.map(&:size).inject(0, :+)
    end

    # @return [Vedeu::Streams]
    def streams
      @_streams ||= collection.coerce(@streams, self)
    end
    alias_method :value, :streams

    # Delegate to Vedeu::Interface#width when available.
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
