require 'virtus'

require_relative 'colour'
require_relative 'style'

module Vedeu
  module Presentation
    include Virtus.module

    attribute :colour, Colour
    attribute :style,  Style
  end
end
