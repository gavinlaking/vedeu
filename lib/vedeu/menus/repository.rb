module Vedeu

  module Menus

    # Allows the storing of menus by name.
    #
    class Repository < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :menus, :repository)

      real Vedeu::Menus::Menu
      null Vedeu::Menus::Menu

    end # Repository

  end # Menus

  # Manipulate the repository of menus.
  #
  # @example
  #   Vedeu.menus
  #
  # @!method menus
  # @return [Vedeu::Menus::Repository]
  def_delegators Vedeu::Menus::Repository,
                 :menus

  # :nocov:

  # See {file:docs/events/menu.md#\_menu_bottom_}
  Vedeu.bind(:_menu_bottom_) do |name|
    Vedeu.menus.by_name(name).bottom_item
  end

  # See {file:docs/events/menu.md#\_menu_current_}
  Vedeu.bind(:_menu_current_) do |name|
    Vedeu.menus.by_name(name).current_item
  end

  # See {file:docs/events/menu.md#\_menu_deselect_}
  Vedeu.bind(:_menu_deselect_) do |name|
    Vedeu.menus.by_name(name).deselect_item
  end

  # See {file:docs/events/menu.md#\_menu_items_}
  Vedeu.bind(:_menu_items_) { |name| Vedeu.menus.by_name(name).items }

  # See {file:docs/events/menu.md#\_menu_next_}
  Vedeu.bind(:_menu_next_) { |name| Vedeu.menus.by_name(name).next_item }

  # See {file:docs/events/menu.md#\_menu_prev_}
  Vedeu.bind(:_menu_prev_) { |name| Vedeu.menus.by_name(name).prev_item }

  # See {file:docs/events/menu.md#\_menu_selected_}
  Vedeu.bind(:_menu_selected_) do |name|
    Vedeu.menus.by_name(name).selected_item
  end

  # See {file:docs/events/menu.md#\_menu_select_}
  Vedeu.bind(:_menu_select_) do |name|
    Vedeu.menus.by_name(name).select_item
  end

  # See {file:docs/events/menu.md#\_menu_top_}
  Vedeu.bind(:_menu_top_) { |name| Vedeu.menus.by_name(name).top_item }

  # See {file:docs/events/menu.md#\_menu_view_}
  Vedeu.bind(:_menu_view_) { |name| Vedeu.menus.by_name(name).view }

  # :nocov:

end # Vedeu
