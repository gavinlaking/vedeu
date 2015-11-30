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

require 'vedeu/geometries/alignment/all'
require 'vedeu/geometries/area/all'
require 'vedeu/geometries/dsl/all'

require 'vedeu/geometries/geometry'
require 'vedeu/geometries/move'
require 'vedeu/geometries/position'
require 'vedeu/geometries/positionable'
require 'vedeu/geometries/repository'
