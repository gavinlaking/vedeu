# frozen_string_literal: true

module Vedeu

  # Views can be combined together into a group for easier
  # manipulation.
  #
  module Groups

  end # Groups

  # :nocov:

  # See {file:docs/events/visibility.md#\_clear_group_}
  Vedeu.bind(:_clear_group_) do |name|
    Vedeu.clear_by_group(name) if Vedeu.ready?
  end

  # See {file:docs/events/visibility.md#\_hide_group_}
  Vedeu.bind(:_hide_group_) { |name| Vedeu.hide_group(name) }

  # See {file:docs/events/refresh.md}
  Vedeu.bind(:_refresh_group_) do |name|
    Vedeu::Groups::Refresh.by_name(name) if Vedeu.ready?
  end

  # See {file:docs/events/visibility.md#\_show_group_}
  Vedeu.bind(:_show_group_) { |name| Vedeu.show_group(name) }

  # See {file:docs/events/visibility.md#\_toggle_group_}
  Vedeu.bind(:_toggle_group_) { |name| Vedeu.toggle_group(name) }

  # :nocov:

end # Vedeu

require 'vedeu/groups/clear'
require 'vedeu/groups/dsl'
require 'vedeu/groups/group'
require 'vedeu/groups/refresh'
require 'vedeu/groups/repository'
