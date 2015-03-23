module Vedeu

  # Take a collection of words (elements) and form a sentence from them.
  #
  # @example
  #   elements = ['Hydrogen', 'Helium', 'Lithium']
  #   Vedeu::Sentence.construct(elements) # => 'Hydrogen, Helium and Lithium'
  #
  class Sentence

    # @param elements [Array]
    # @param label [String]
    # @return [String]
    def self.construct(elements, label = 'elements')
      new(elements, label).construct
    end

    # Returns a new instance of Vedeu::Sentence.
    #
    # @param elements [Array]
    # @param label [String]
    # @return [Vedeu::Sentence]
    def initialize(elements, label)
      @elements, @label = elements, label
    end

    # @return [String]
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

    # @!attribute [r] elements
    # @return [Array]
    attr_reader :elements

    # @!attribute [r] label
    # @return [String]
    attr_reader :label

    # @return [Boolean]
    def one?
      count == 1
    end

    # @return [Boolean]
    def two?
      count == 2
    end

    # @return [Boolean]
    def many?
      count > 2
    end

    # @return [String]
    def but_last
      elements[0...-1].join(', ')
    end

    # @return [String]
    def first
      elements.first
    end

    # @return [String]
    def last
      elements[-1]
    end

    # @return [Fixnum]
    def count
      elements.size
    end

  end # Sentence

end # Vedeu
