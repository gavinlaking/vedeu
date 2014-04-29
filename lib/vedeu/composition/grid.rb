module Vedeu
  class OutOfStyleError < StandardError; end
  class OutOfDataError < StandardError; end

  module Composition
    class Grid
      class << self
        def compose(data = [], mask = [])
          new(data, mask).compose
        end
      end

      def initialize(data = [], mask = [])
        @data, @mask = data, mask
      end

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
        Colours::Colour.reset
      end

      def style(y, x)
        Colours::Colour.set(mask[y][x])
      end

      def validate!
        raise  OutOfStyleError if data.size > mask.size
        raise  OutOfDataError  if data.size < mask.size
        return []              if data.empty? && mask.empty?
      end
    end
  end
end
