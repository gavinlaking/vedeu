require 'virtus'

require_relative 'colour'

module Vedeu
  module Presentation
    include Virtus.module

    attribute :colour, Colour,       default: Colour.new
    attribute :style,  Array[String]
  end
end
