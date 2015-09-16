module Vedeu

  module Output

    # Wrap or prune text.
    #
    class Wordwrap

      # @see Vedeu::Output::Wordwrap#initialize
      def self.for(text, options = {})
        new(text, options).content
      end

      # Returns a new instance of Vedeu::Output::Wordwrap.
      #
      # @param text [String]
      # @param options [Hash]
      # @option options ellipsis [String] See {#ellipsis}.
      # @option options mode [Symbol] See {#mode}.
      # @option options width [Fixnum] See {#width}.
      # @return [Vedeu::Output::Wordwrap]
      def initialize(text, options = {})
        @text    = text
        @options = defaults.merge!(options)
      end

      # @return [Vedeu::Views::Lines]
      def content
        case mode
        when :prune then to_line_objects(prune)
        when :wrap  then to_line_objects(wrap)
        else
          to_line_objects(split_lines)
        end
      end

      # @return [Array<String>|String]
      def prune
        return text if text.size <= pruned_width

        processed = []

        if split_lines.size > 1
          processed = split_lines.reduce([]) do |acc, line|
            acc << ellipsis_string(line)
          end

        else
          processed = ellipsis_string(text)

        end

        processed
      end

      # @return [String]
      def wrap
        processed = []
        split_lines.map do |unprocessed|
          line_length = 0
          reformatted = []

          unprocessed.split(/\s/).map do |word|
            word_length = word.length + 1

            if (line_length += word_length) >= width
              line_length = word_length
              processed << reformatted
              reformatted = []
            end

            reformatted << word
          end

          processed << reformatted
        end

        processed.reduce([]) do |output, line|
          output << line.join(' ')
        end
      end

      protected

      # @!attribute [r] text
      # @return [String]
      attr_reader :text

      # @!attribute [r] options
      # @return [Hash]
      attr_reader :options

      private

      # @param text_as_lines [Array<String>]
      # @return [Vedeu::Views::Lines]
      def to_line_objects(text_as_lines)
        line_objects = Array(text_as_lines).map do |text_line|
          stream        = Vedeu::Views::Stream.new(value: text_line)
          line          = Vedeu::Views::Line.new
          stream.parent = line
          line.add(stream)
          line
        end
        Vedeu::Views::Lines.new(line_objects)
      end

      # Returns the text as an array of lines, split on '\n'.
      #
      # @return [Array<String>]
      def split_lines
        text.split(/\n/)
      end

      # @param string [String]
      # @return [String]
      def ellipsis_string(string)
        if string.size < ellipsis.size
          prune_string(string)

        else
          "#{prune_string(string)}#{ellipsis}"

        end
      end

      # Returns the string pruned.
      #
      # @param string [String]
      # @return [String]
      def prune_string(string)
        string.chomp.slice(0..pruned_width)
      end

      # Returns the width of the string minus the ellipsis.
      #
      # @return [Fixnum]
      def pruned_width
        width - ellipsis.size
      end

      # For when using mode `:prune`, by default, provides '...'.
      #
      # @return [String]
      def ellipsis
        options.fetch(:ellipsis)
      end

      # Returns the word wrapping mode. One of :default, :prune or :wrap;
      #   :default = Renders the content as is.
      #   :prune   = Discards the remainder of the content line after width.
      #   :wrap    = Forces the content on to a new line after width.
      # @return [Symbol]
      def mode
        options.fetch(:mode)
      end

      # Returns the width to prune or wrap to.
      #
      # @return [Fixnum]
      def width
        options.fetch(:width)
      end

      # Returns the default options/attributes for this class.
      #
      # @return [Hash<Symbol => Fixnum, String, Symbol>]
      def defaults
        {
          ellipsis: '...',
          mode:     :default,
          width:    70,
        }
      end

    end # Wordwrap

  end # Output

end # Vedeu
