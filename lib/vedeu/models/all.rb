# frozen_string_literal: true

module Vedeu

  # Provides various models which Vedeu uses.
  #
  module Models

  end # Models

  # :nocov:

  # See {file:docs/events/focus.md#\_focus_by_name_}
  Vedeu.bind(:_focus_by_name_) { |name| Vedeu.focus_by_name(name) }

  # See {file:docs/events/focus.md#\_focus_next_}
  Vedeu.bind(:_focus_next_) { Vedeu.focus_next }

  # See {file:docs/events/focus.md#\_focus_prev_}
  Vedeu.bind(:_focus_prev_) { Vedeu.focus_previous }

  # :nocov:

end # Vedeu

require 'vedeu/models/toggleable'
require 'vedeu/models/focus'
require 'vedeu/models/row'
require 'vedeu/models/page'
