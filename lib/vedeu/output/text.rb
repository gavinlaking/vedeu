module Vedeu

  # Present a string (or object responding to `to_s`).
  #
  # @api private
  class Text

    # @see Vedeu::DSL::Text#text
    def self.add(value = '', options = {})
      new(value, options).add
    end

    # @see Vedeu::DSL::Text#text
    def self.with(value = '', options = {})
      new(value, options).aligned
    end

    # Returns a new instance of Vedeu::Text.
    #
    # @param value [String]
    # @param options [Hash]
    # @option options anchor [Symbol] See {Text#anchor}
    # @option options background [String]
    # @option options colour [Hash|NilClass]
    # @option options foreground [String]
    # @option options model [Vedeu::Interface|Vedeu::Line|Vedeu::Stream]
    # @option options pad [String]
    # @option options width [Integer]
    # @return [Vedeu::Text]
    def initialize(value = '', options = {})
      @value   = value
      @options = defaults.merge!(options)
    end

    # Aligns the value.
    #
    # @return [String]
    def aligned
      return string unless width

      return truncated if truncate?

      case anchor
      when :align, :left, :text then left
      when :centre, :center     then centre
      when :right               then right
      else
        left
      end
    end

    # Adds the content to the model.
    #
    # @return [void]
    def add
      model.add(content)
    end

    protected

    # @!attribute [r] value
    # @return [String]
    attr_reader :value

    # @!attribute [r] options
    # @return [Hash]
    attr_reader :options

    private

    # @return [Symbol] One of :align, :centre, :center, :left, :right, :text
    def anchor
      options[:anchor]
    end

    # The string padded to width, centralized.
    #
    # @return [String]
    def centre
      string.center(width, pad)
    end

    # If a colour, background or foreground option is set, use them as the
    # colour settings for the new Vedeu::Stream.
    #
    # @return [void]
    def colour
      if options[:colour] || options[:background] || options[:foreground]
        Vedeu::Colour.coerce(options)

      else
        model.colour

      end
    end

    # Returns either a Vedeu::Line or Vedeu::Stream containing the text value.
    #
    # @return [Vedeu::Line|Vedeu::Stream]
    def content
      if model.is_a?(Vedeu::Interface)
        stream.parent = line
        line.add(stream)
        line

      else
        stream

      end
    end

    # The default values for a new instance of this class.
    #
    # @return [Hash<Symbol => NilClass, String, Symbol>]
    def defaults
      {
        anchor: :left,
        colour: nil,
        model:  nil,
        pad:    ' ',
        width:  nil,
      }
    end

    # The string padded to width, left justified.
    #
    # @return [String]
    def left
      string.ljust(width, pad)
    end

    # @return [Vedeu::Line]
    def line
      @line ||= Vedeu::Line.build(parent: parent)
    end

    # Returns the model option if set.
    #
    # @return [Vedeu::Interface|Vedeu::Line|Vedeu::Null::Generic|Vedeu::Stream]
    def model
      @model ||= options[:model] || Vedeu::Null::Generic.new
    end

    # The character to use for padding the string.
    #
    # @return [String]
    def pad
      options[:pad]
    end

    # Returns the parent for the new Vedeu::Stream.
    #
    # @return [void]
    def parent
      model.is_a?(Vedeu::Stream) ? model.parent : model
    end

    # The string padded to width, right justified.
    #
    # @return [String]
    def right
      string.rjust(width, pad)
    end

    # Builds and returns a new Vedeu::Stream.
    #
    # @return [void]
    def stream
      @stream ||= Vedeu::Stream.build(colour: colour,
                                      parent: parent,
                                      style:  style,
                                      value:  aligned)
    end

    # The string, coerced.
    #
    # @return [String]
    def string
      value.to_s
    end

    # Returns the model's styles.
    #
    # @return [void]
    def style
      model.style
    end

    # Return a boolean indicating that the string is greater than the width.
    #
    # @return [Boolean]
    def truncate?
      string.size > width
    end

    # Return the string truncated to the width.
    #
    # @return [String]
    def truncated
      string.slice(0, width)
    end

    # Return the width.
    #
    # @return [Fixnum]
    def width
      options[:width]
    end

  end # Align

end # Vedeu
