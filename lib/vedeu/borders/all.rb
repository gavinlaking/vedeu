# frozen_string_literal: true

module Vedeu

  # Borders are defined by name for each of the client application's
  # interfaces or views. They can be enabled or disabled (which
  # controls whether they are rendered or not), they have their own
  # colours and styles, and each aspect of the border can be
  # controlled.
  #
  # @example
  #   # Borders can be defined when defining your interface...
  #   Vedeu.interface :my_interface do
  #     border do
  #     # ...
  #   end
  #
  #   # ...or as part of a view definition...
  #   Vedeu.renders do
  #     view :border_demo do
  #       border do
  #       # ...
  #     end
  #
  #   # ...or standalone; referencing the target interface or view.
  #   Vedeu.border :some_interface do
  #     # ...
  #   end
  #
  # See {Vedeu::Borders::DSL} for DSL methods for defining borders.
  #
  module Borders

  end # Borders

  # :nocov:

  # {include:file:docs/events/by_name/refresh_border.md}
  Vedeu.bind(:_refresh_border_) do |name|
    Vedeu::Borders::Refresh.by_name(name) if Vedeu.ready?
  end

  # See {file:docs/events/by_name/set_border_caption.md}
  Vedeu.bind(:_set_border_caption_) do |name, caption|
    Vedeu.borders.by_name(name).caption = caption
  end

  # See {file:docs/events/by_name/set_border_title.md}
  Vedeu.bind(:_set_border_title_) do |name, title|
    Vedeu.borders.by_name(name).title = title
  end

  # :nocov:

end # Vedeu

require 'vedeu/borders/title'
require 'vedeu/borders/caption'
require 'vedeu/borders/border'
require 'vedeu/borders/dsl'
require 'vedeu/borders/refresh'
require 'vedeu/borders/repository'
