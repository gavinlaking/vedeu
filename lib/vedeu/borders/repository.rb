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

  # Manipulate the repository of borders.
  #
  # @example
  #   Vedeu.borders
  #
  # @!method borders
  # @return [Vedeu::Borders::Repository]
  def_delegators Vedeu::Borders::Repository,
                 :borders

  # :nocov:

  # See {file:docs/borders.md#label-3A_refresh_border_}
  Vedeu.bind(:_refresh_border_) do |name|
    Vedeu::Borders::Refresh.by_name(name)
  end

  # See {file:docs/borders.md#label-3A_set_border_caption_}
  Vedeu.bind(:_set_border_caption_) do |name, caption|
    Vedeu::Borders::SetCaption.update(name, caption)
  end

  # See {file:docs/borders.md#label-3A_set_border_title_}
  Vedeu.bind(:_set_border_title_) do |name, title|
    Vedeu::Borders::SetTitle.update(name, title)
  end

  # :nocov:

end # Vedeu
