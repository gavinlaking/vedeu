require 'virtus'

require_relative 'colour'
require_relative '../support/esc'

module Vedeu
  module Presentation
    include Virtus.module

    attribute :colour, Colour,       default: Colour.new
    attribute :style,  Array[String]
  end
end
