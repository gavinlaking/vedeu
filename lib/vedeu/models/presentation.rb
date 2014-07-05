require 'virtus'

require_relative 'colour'
require_relative 'style_collection'

module Vedeu
  module Presentation
    include Virtus.module

    attribute :colour, Colour
    attribute :style,  StyleCollection
  end
end
