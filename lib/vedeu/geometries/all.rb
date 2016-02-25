# frozen_string_literal: true

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

  # :nocov:

  # See {file:docs/events/view.md#\_maximise_}
  Vedeu.bind(:_maximise_) do |name|
    Vedeu.geometries.by_name(name).maximise
  end

  # {include:file:docs/events/by_name/movement_refresh.md}
  Vedeu.bind(:_movement_refresh_) do |name|
    Vedeu.trigger(:_clear_)
    Vedeu.trigger(:_refresh_)
    Vedeu.trigger(:_clear_view_, name)
    Vedeu.trigger(:_refresh_view_, name)
  end

  # See {file:docs/events/view.md#\_unmaximise_}
  Vedeu.bind(:_unmaximise_) do |name|
    Vedeu.geometries.by_name(name).unmaximise
  end

  # {include:file:docs/events/by_name/view_down.md}
  Vedeu.bind(:_view_down_) do |name, offset|
    Vedeu::Geometries::Move.move(name: name, offset: offset, direction: :down)
  end

  # {include:file:docs/events/by_name/view_left.md}
  Vedeu.bind(:_view_left_) do |name, offset|
    Vedeu::Geometries::Move.move(name: name, offset: offset, direction: :left)
  end

  # {include:file:docs/events/by_name/view_right.md}
  Vedeu.bind(:_view_right_) do |name, offset|
    Vedeu::Geometries::Move.move(name: name, offset: offset, direction: :right)
  end

  # {include:file:docs/events/by_name/view_up.md}
  Vedeu.bind(:_view_up_) do |name, offset|
    Vedeu::Geometries::Move.move(name: name, offset: offset, direction: :up)
  end

  [:down, :left, :right, :up].each do |direction|
    Vedeu.bind_alias(:"_geometry_#{direction}_", :"_view_#{direction}_")
  end

  # :nocov:

end # Vedeu

require 'vedeu/geometries/area/all'
require 'vedeu/geometries/dsl/all'
require 'vedeu/geometries/geometry'
require 'vedeu/geometries/move'
require 'vedeu/geometries/position'
require 'vedeu/geometries/repository'
