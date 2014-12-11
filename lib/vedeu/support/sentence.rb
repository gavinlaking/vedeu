module Vedeu

  class Sentence

    class << self

      def construct(elements, label = 'elements')
        new(elements, label).construct
      end

    end # Sentence eigenclass

    def initialize(elements, label)
      @elements, @label = elements, label
    end

    def construct
      if one?
        first

      elsif two?
        elements.join(' and ')

      elsif many?
        [but_last, last].join(' and ')

      else
        "No #{label} have been assigned."

      end
    end

    private

    attr_reader :elements, :label

    def one?
      count == 1
    end

    def two?
      count == 2
    end

    def many?
      count > 2
    end

    def but_last
      elements[0...-1].join(', ')
    end

    def first
      elements.first
    end

    def last
      elements[-1]
    end

    def count
      elements.size
    end

  end # Sentence

end # Vedeu
