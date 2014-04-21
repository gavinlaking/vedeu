module Vedeu
  class OutOfStyleError < StandardError; end
  class OutOfDataError < StandardError; end

  class Compositor
    class << self
      # @param  data [Array] An array of characters.
      # @param  mask [Array] An array of styles.
      # @return      [Array] An interpolated array of characters and styles.
      def compose(data = [], mask = [])
        new(data, mask).compose
      end
    end

    # @param  data [Array] An array of characters.
    # @param  mask [Array] An array of styles.
    # @return      [Vedeu::Compositor]
    def initialize(data = [], mask = [])
      @data, @mask = data, mask
    end

    # @return [Array] An interpolated array of characters and styles.
    def compose
      validate!

      container = []
      columns = []
      rows.each_with_index do |row, y|
        row.each_with_index do |column, x|
          columns << [style(y, x), column, reset]
        end
        container << columns
        columns = []
      end
      container
    end

    private

    attr_reader :data, :mask

    alias_method :rows, :data

    def reset
      Vedeu::Colour.reset
    end

    def style(y, x)
      Vedeu::Colour.set(mask[y][x])
    end

    def validate!
      raise  OutOfStyleError if data.size > mask.size
      raise  OutOfDataError  if data.size < mask.size
      return []              if data.empty? && mask.empty?
    end
  end
end
