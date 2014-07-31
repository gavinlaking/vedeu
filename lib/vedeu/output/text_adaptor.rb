module Vedeu
  class TextAdaptor
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
