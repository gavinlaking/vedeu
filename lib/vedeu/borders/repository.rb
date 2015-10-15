module Vedeu

  module Borders

    # Allows the storing of interface/view borders independent of the
    # interface instance.
    #
    class Repository < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :borders, :repository)

      null Vedeu::Borders::Null
      real Vedeu::Borders::Border

    end # Repository

  end # Borders

  # Manipulate the repository of borders.
  #
  # @example
  #   Vedeu.borders
  #
  # @!method borders
  # @return [Vedeu::Borders::Repository]
  def_delegators Vedeu::Borders::Repository, :borders

  # :nocov:

  # See {file:docs/borders.md#label-3A_refresh_border_}
  Vedeu.bind(:_refresh_border_) do |name|
    Vedeu::Borders::Refresh.by_name(name)
  end

  # See {file:docs/borders.md#label-3A_set_border_caption_}
  Vedeu.bind(:_set_border_caption_) do |name, caption|
    border = Vedeu.borders.by_name(name)
    border.caption = caption
    border.store { Vedeu.trigger(:_refresh_border_, name) }
  end

  # See {file:docs/borders.md#label-3A_set_border_title_}
  Vedeu.bind(:_set_border_title_) do |name, title|
    border = Vedeu.borders.by_name(name)
    border.title = title
    border.store { Vedeu.trigger(:_refresh_border_, name) }
  end

  # :nocov:

end # Vedeu
