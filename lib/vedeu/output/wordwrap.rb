module Vedeu

  class Wordwrap

    # @param text [String]
    # @param options [Hash]
    # @option options ellipsis [String]
    # @option options width [Fixnum]
    # @return [Vedeu::Wordwrap]
    def initialize(text, options = {})
      @text    = text
      @options = defaults.merge(options)
    end

    # @return [Array<String>|String]
    def prune
      return text if text.size <= pruned_width

      processed = []

      if text_as_lines.size > 1
        processed = text_as_lines.reduce([]) do |acc, line|
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
      text.split(/\n/).map do |unprocessed|
        line_length = 0
        reformatted = []

        unprocessed.split(/\s/).map do |word|
          word_length = word.length + 1

          if (line_length += word_length) >= width
            line_length = word_length
            processed   << reformatted
            reformatted = []
          end

          reformatted << word
        end

        processed << reformatted
      end

      processed.reduce([]) do |output, line|
        output << line.join(' ')
      end.join("\n")
    end

    # @todo
    def prune_as_lines

    end

    # @todo
    def wrap_as_lines
    end

    private

    attr_reader :text, :options

    # @return [Array<String>]
    def text_as_lines
      text.split(/\n/)
    end

    # @return [String]
    def output
      processed.reduce([]) do |output, line|
        output << line.join(' ')
      end.join("\n")
    end

    # @return [String]
    def ellipsis_string(string)
      if string.size < ellipsis.size
        prune_string(string)

      else
        [prune_string(string), ellipsis].join

      end
    end

    # @return [String]
    def prune_string(string)
      string.chomp.slice(0..pruned_width)
    end

    # @return [Fixnum]
    def pruned_width
      width - ellipsis.size
    end

    # @return [String]
    def ellipsis
      options.fetch(:ellipsis)
    end

    # @return [Fixnum]
    def width
      options.fetch(:width)
    end

    # @return [Hash]
    def defaults
      {
        ellipsis: '...',
        width:    70,
      }
    end

  end # Wordwrap

end # Vedeu
