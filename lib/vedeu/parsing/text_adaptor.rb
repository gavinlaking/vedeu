module Vedeu
  class TextAdaptor
    # Convert a block of text into a collection of lines.
    #
    # @param text [String|Array] a block of text containing new line (\n)
    #   characters, or a collection of strings.
    #
    # @return [Array]
    def self.adapt(text)
      new(text).adapt
    end

    def initialize(text)
      @text = text
    end

    def adapt
      return [] if no_content?

      lines.map { |line| { streams: { text: line } } }
    end

    private

    attr_reader :text

    def lines
      if text.is_a?(::Array)
        text
      else
        text.split(/\n/)
      end
    end

    def no_content?
      text.nil? || text.empty?
    end
  end
end
