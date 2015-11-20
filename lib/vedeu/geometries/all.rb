module Vedeu

  # The Geometry group of classes all handle the size of interfaces in
  # relation to the current size of the terminal. This helps Vedeu to
  # draw content in a consistent way.
  #
  # You can define the geometry of your interfaces using the
  # {Vedeu::Geometries::DSL}.
  #
  module Geometries

  end # Geometries

end # Vedeu

require 'vedeu/geometries/alignment'
require 'vedeu/geometries/horizontal_alignment'
require 'vedeu/geometries/vertical_alignment'
require 'vedeu/geometries/area'
require 'vedeu/geometries/coordinate'
require 'vedeu/geometries/dimension'
require 'vedeu/geometries/x_dimension'
require 'vedeu/geometries/y_dimension'
require 'vedeu/geometries/validator'
require 'vedeu/geometries/dsl'
require 'vedeu/geometries/coordinate'
require 'vedeu/geometries/geometry'
require 'vedeu/geometries/grid'
require 'vedeu/geometries/move'
require 'vedeu/geometries/position'
require 'vedeu/geometries/repository'
