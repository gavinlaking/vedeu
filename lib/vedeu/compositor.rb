module Vedeu
  class OutOfStyleError < StandardError; end
  class OutOfDataError < StandardError; end

  class Compositor
    # @param  data [Array] An array of characters.
    # @param  mask [Array] An array of styles.
    # @return      [Vedeu::Compositor]
    def initialize(data = [], mask = [])
      @data, @mask = data, mask
    end

    # @return [Array] An interpolated array of characters and styles.
    def interpolate
      validate!

      container = []
      data.each_with_index do |character, index|
        container << [
          style(index), character, reset
        ].join
      end
      container
    end

    private

    attr_reader :data, :mask

    def reset
      Vedeu::Colour.reset
    end

    def style(index)
      Vedeu::Colour.set(mask[index])
    end

    def validate!
      raise  OutOfStyleError if data.size > mask.size
      raise  OutOfDataError  if data.size < mask.size
      return []              if data.empty? && mask.empty?
    end
  end
end
