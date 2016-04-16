# frozen_string_literal: true

module Vedeu

  # {include:file:docs/interfaces.md}
  module Interfaces

  end # Interfaces

  # :nocov:

  # See {file:docs/events/visibility.md#\_clear_view_}
  Vedeu.bind(:_clear_view_) { |name| Vedeu.clear_by_name(name) if Vedeu.ready? }

  # See {file:docs/events/visibility.md#\_clear_view_content_}
  Vedeu.bind(:_clear_view_content_) do |name|
    Vedeu.clear_content_by_name(name) if Vedeu.ready?
  end

  # See {file:docs/events/visibility.md#\_hide_interface_}
  Vedeu.bind(:_hide_interface_) { |name| Vedeu.hide_interface(name) }
  Vedeu.bind_alias(:_hide_view_, :_hide_interface_)

  # See {file:docs/events/visibility.md#\_show_interface_}
  Vedeu.bind(:_show_interface_) { |name| Vedeu.show_interface(name) }
  Vedeu.bind_alias(:_show_view_, :_show_interface_)

  # See {file:docs/events/visibility.md#\_toggle_interface_}
  Vedeu.bind(:_toggle_interface_) { |name| Vedeu.toggle_interface(name) }
  Vedeu.bind_alias(:_toggle_view_, :_toggle_interface_)

  # :nocov:

end # Vedeu

require 'vedeu/interfaces/interface'
require 'vedeu/interfaces/clear'
require 'vedeu/interfaces/clear_content'
require 'vedeu/interfaces/dsl'
require 'vedeu/interfaces/null'
require 'vedeu/interfaces/repository'
