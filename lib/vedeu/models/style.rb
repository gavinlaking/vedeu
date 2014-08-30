module Vedeu
  class Style

    attr_reader :values

    # @param values [String|Array]
    # @return [Style]
    def initialize(values)
      @values = values
    end

    # @return [String]
    def to_s
      escape_sequences
    end

    private

    # @api private
    # @return [String]
    def escape_sequences
      @_sequences ||= if values.nil? || values.empty?
        ''

      else
        Array(values).flatten.map { |value| Esc.string(value) }.join

      end
    end
  end
end
