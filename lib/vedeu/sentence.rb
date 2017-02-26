# frozen_string_literal: true

module Vedeu

  # Converts the array of elements provided into a comma separated
  # sentence with the penultimate and ultimate elements separated with
  # the word 'and'.
  #
  # @api public
  #
  class Sentence

    # @param (see #initialize)
    # @return (see #construct)
    def self.construct(elements, label = 'elements')
      new(elements, label).construct
    end

    # @param elements [Array]
    # @param label [String]
    # @return [Vedeu::Sentence]
    def initialize(elements, label = 'elements')
      @elements = elements
      @label    = label
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

    protected

    # @!attribute [r] elements
    # @return [Array]
    attr_reader :elements

    # @!attribute [r] label
    # @return [String]
    attr_reader :label

    private

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

    # @return [Array]
    def but_last
      elements[0...-1].join(', ')
    end

    # @return [Object]
    def first
      elements.first
    end

    # @return [Object]
    def last
      elements[-1]
    end

    # @return [Integer]
    def count
      elements.size
    end

  end # Sentence

end # Vedeu
