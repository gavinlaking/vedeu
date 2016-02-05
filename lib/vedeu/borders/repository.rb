# frozen_string_literal: true

module Vedeu

  module Borders

    # Allows the storing of interface/view borders independent of the
    # interface instance.
    #
    class Repository < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :borders, :repository)

      null Vedeu::Borders::Border, enabled: false
      real Vedeu::Borders::Border

    end # Repository

  end # Borders

  # {include:file:docs/dsl/by_method/borders.md}
  # @api public
  # @!method borders
  # @return [Vedeu::Borders::Repository]
  def_delegators Vedeu::Borders::Repository,
                 :borders

  # :nocov:

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
