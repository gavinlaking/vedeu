# frozen_string_literal: true

module Vedeu

  # Vedeu creates an individual cursor for each interface defined,
  # these take their name from the interface, which means that your
  # position within the view for each interface is maintained.
  #
  # The cursor also manages the content offset for a particular view.
  # For example, if the user has moved around within the content and
  # then moved to another interface, when they return their position
  # will be restored.
  #
  module Cursors

  end # Cursors

  # :nocov:

  # See {file:docs/cursors.md}
  Vedeu.bind(:_cursor_bottom_) do |name|
    name ||= Vedeu.focus
    count = Vedeu.buffers.by_name(name).size

    Vedeu::Cursors::Reposition.new(name: name,
                                   y:    count,
                                   x:    0,
                                   mode: :relative).reposition

    Vedeu.trigger(:_clear_view_, name)
    Vedeu.trigger(:_refresh_view_, name)
  end

  # See {file:docs/events/by_name/cursor_down.md}
  Vedeu.bind(:_cursor_down_) do |name, offset|
    Vedeu::Cursors::Move.move(name, :move_down, offset)
  end

  # See {file:docs/events/by_name/cursor_left.md}
  Vedeu.bind(:_cursor_left_) do |name, offset|
    Vedeu::Cursors::Move.move(name, :move_left, offset)
  end

  # See {file:docs/cursors.md}
  Vedeu.bind(:_cursor_origin_) do |name|
    Vedeu.cursors.by_name(name).move_origin

    Vedeu.trigger(:_refresh_cursor_, name)
  end
  Vedeu.bind_alias(:_cursor_reset_, :_cursor_origin_)

  # See {file:docs/cursors.md}
  Vedeu.bind(:_cursor_position_) do |name|
    Vedeu.cursors.by_name(name).inspect
  end

  # See {file:docs/cursors.md}
  Vedeu.bind(:_cursor_reposition_) do |name, y, x|
    Vedeu::Cursors::Reposition.new(name: name,
                                   y:    y,
                                   x:    x,
                                   mode: :absolute).reposition
  end

  # See {file:docs/events/by_name/cursor_right.md}
  Vedeu.bind(:_cursor_right_) do |name, offset|
    Vedeu::Cursors::Move.move(name, :move_right, offset)
  end

  # See {file:docs/events/by_name/cursor_up.md}
  Vedeu.bind(:_cursor_up_) do |name, offset|
    Vedeu::Cursors::Move.move(name, :move_up, offset)
  end

  # See {file:docs/cursors.md}
  Vedeu.bind(:_cursor_top_) do |name|
    name ||= Vedeu.focus

    Vedeu::Cursors::Reposition.new(name: name,
                                   y:    0,
                                   x:    0,
                                   mode: :relative).reposition

    Vedeu.trigger(:_clear_view_, name)
    Vedeu.trigger(:_refresh_view_, name)
  end

  # See {file:docs/cursors.md#vedeuhide_cursor__}
  Vedeu.bind(:_hide_cursor_) { |name| Vedeu.hide_cursor(name) }
  Vedeu.bind_alias(:_cursor_hide_, :_hide_cursor_)

  # See {file:docs/events/refresh.md#\_refresh_cursor_}
  Vedeu.bind(:_refresh_cursor_) do |name|
    Vedeu::Cursors::Refresh.by_name(name) if Vedeu.ready?
  end

  # See {file:docs/cursors.md#vedeushow_cursor__}
  Vedeu.bind(:_show_cursor_) { |name| Vedeu.show_cursor(name) }
  Vedeu.bind_alias(:_cursor_show_, :_show_cursor_)

  # See {file:docs/cursors.md#vedeutoggle_cursor__}
  Vedeu.bind(:_toggle_cursor_) { |name| Vedeu.toggle_cursor(name) }

  # :nocov:

end # Vedeu

require 'vedeu/cursors/move'
require 'vedeu/cursors/coordinate'
require 'vedeu/cursors/cursor'
require 'vedeu/cursors/dsl'
require 'vedeu/cursors/refresh'
require 'vedeu/cursors/reposition'
require 'vedeu/cursors/repository'
