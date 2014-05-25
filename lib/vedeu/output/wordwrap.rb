module Vedeu
  class Wordwrap
    class << self
      def this(value, options = {})
        new(value, options).reformat
      end
    end

    def initialize(value, options = {})
      @value, @options = value, options
    end

    def reformat
      return pruned if prune?
      wordwrapped
    end

    def wordwrapped
      processed = []
      value.split(/\n/).map do |unprocessed|
        line_length = 0
        reformatted = []

        unprocessed.split(/\s/).map do |word|
          word_length = word.length + 1

          if (line_length += word_length) >= maximum_width
            line_length = word_length
            processed   << reformatted
            reformatted = []
          end

          reformatted << word
        end

        processed << reformatted
      end

      output(processed)
    end

    private

    attr_reader :value, :options

    def output(paragraph)
      paragraph.reduce([]) do |output, line|
        output << line.join(' ')
      end.join("\n")
    end

    def pruned
      return value if value.size <= pruned_width
      [
        value.chomp.slice(0..pruned_width),
        '...',
        Esc.reset
      ].join
    end

    def pruned_width
      maximum_width - 3
    end

    def prune?
      options.fetch(:prune)
    end

    def maximum_width
      options.fetch(:width)
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        width: 70,
        prune: false
      }
    end
  end
end
