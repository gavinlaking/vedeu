module Vedeu

  class Wordwrap

    def initialize(text, options = {})
      @text    = text
      @options = defaults.merge(options)
    end

    def prune
      return text if text.size <= pruned_width

      [text.chomp.slice(0..pruned_width), ellipsis].join
    end

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

    def prune_as_lines
    end

    def wrap_as_lines
    end

    private

    attr_reader :text, :options

    def output
      processed.reduce([]) do |output, line|
        output << line.join(' ')
      end.join("\n")
    end

    def pruned_width
      width - ellipsis.size
    end

    def ellipsis
      options.fetch(:ellipsis)
    end

    def width
      options.fetch(:width)
    end

    def defaults
      {
        ellipsis: '...',
        width:    70,
      }
    end

  end # Wordwrap

end # Vedeu
