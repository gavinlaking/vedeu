module Vedeu

  # The Geometry group of classes all handle the size of interfaces in
  # relation to the current size of the terminal. This helps Vedeu to
  # draw content in a consistent way.
  #
  # You can define the geometry of your interfaces using the
  # {Vedeu::Geometry::DSL}.
  #
  module Geometry

  end # Geometry

end # Vedeu

require 'vedeu/geometry/alignment'
require 'vedeu/geometry/horizontal_alignment'
require 'vedeu/geometry/vertical_alignment'
require 'vedeu/geometry/area'
require 'vedeu/geometry/coordinate'
require 'vedeu/geometry/dimension'
require 'vedeu/geometry/x_dimension'
require 'vedeu/geometry/y_dimension'
require 'vedeu/geometry/validator'
require 'vedeu/geometry/dsl'
require 'vedeu/geometry/coordinate'
require 'vedeu/geometry/geometry'
require 'vedeu/geometry/grid'
require 'vedeu/geometry/move'
require 'vedeu/geometry/null'
require 'vedeu/geometry/position'
require 'vedeu/geometry/repository'
