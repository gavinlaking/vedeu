module Vedeu

  module Output

    # Present a string (or object responding to `to_s`).
    #
    class Text

      extend Forwardable
      include Vedeu::Common

      def_delegators :options,
                     :anchor,
                     :client,
                     :mode,
                     :model,
                     :name,
                     :pad

      # @see Vedeu::DSL::Text#text
      def self.add(value = '', options = {})
        new(value, options).add
      end

      # @see Vedeu::DSL::Text#text
      def self.with(value = '', options = {})
        new(value, options).aligned
      end

      # Returns a new instance of Vedeu::Output::Text.
      #
      # @param value [String]
      # @param options [Hash]
      # @option options anchor [Symbol] See {Text#anchor}
      # @option options background [String]
      # @option options colour [Hash|NilClass]
      # @option options foreground [String]
      # @option options model
      #   [Vedeu::Views::View|Vedeu::Views::Line|Vedeu::Views::Stream]
      # @option options mode (see Vedeu::DSL::Wordwrap#mode)
      # @option options name [String|Symbol]
      # @option options pad [String]
      # @option options width [Integer]
      # @return [Vedeu::Output::Text]
      def initialize(value = '', options = {})
        @value   = value
        @options = options
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
        # fail Vedeu::Error::MissingRequired,
        #      'Cannot determine model.' unless model

        if wrap?
          # model.add(wrapped)
          wrapped

        else
          # model.add(content)
          aligned

        end
      end

      protected

      # @!attribute [r] value
      # @return [String]
      attr_reader :value

      private

      # The string padded to width, centralized.
      #
      # @return [String]
      def centre
        value.center(width, pad)
      end

      # If a colour, background or foreground option is set, use them
      # as the colour settings for the new Vedeu::Views::Stream.
      #
      # @return [void]
      def colour
        if options.colour || options.background || options.foreground
          Vedeu::Colours::Colour.coerce(options.__data__)

        elsif model
          model.colour

        end
      end

      # Returns either a Vedeu::Views::Line or Vedeu::Views::Stream
      # containing the text value.
      #
      # @return [Vedeu::Views::Line|Vedeu::Views::Stream]
      def content
        return stream unless model.is_a?(Vedeu::Views::View)

        stream.parent = line
        line.add(stream)
        line
      end

      # @return [NilClass|Vedeu::Geometries::Geometry]
      def geometry
        Vedeu.geometries.by_name(name)
      end

      # The string padded to width, left justified.
      #
      # @return [String]
      def left
        string.ljust(width, pad)
      end

      # @return [Vedeu::Views::Line]
      def line
        @line ||= Vedeu::Views::Line.build(parent: parent, client: client)
      end

      def options
        @_options ||= @options
      end

      # Returns the parent for the new Vedeu::Views::Stream.
      #
      # @return [void]
      def parent
        model.is_a?(Vedeu::Views::Stream) ? model.parent : model
      end

      # The string padded to width, right justified.
      #
      # @return [String]
      def right
        string.rjust(width, pad)
      end

      # Builds and returns a new Vedeu::Views::Stream.
      #
      # @return [void]
      def stream
        @stream ||= Vedeu::Views::Stream.build(client: client,
                                               colour: colour,
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
        model.style if model
      end

      # Return a boolean indicating that the string is greater than
      # the width.
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

      # Return the width of the interface when a name is given,
      # otherwise use the given width.
      #
      # @return [Fixnum]
      def width
        if present?(options.width)
          options.width

        elsif present?(name)
          geometry.bordered_width

        end
      end

      # Return a boolean indicating whether the string should be
      # wrapped.
      #
      # @return [Boolean]
      def wrap?
        options.mode == :wrap
      end

      # Return the content as wrapped lines.
      #
      # @return [Vedeu::Views::Lines]
      def wrapped
        Vedeu::DSL::Wordwrap.for(string, options)
      end

    end # Text

  end # Output

end # Vedeu
