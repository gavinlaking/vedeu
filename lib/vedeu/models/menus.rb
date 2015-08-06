module Vedeu

  # Allows the storing of menus by name.
  #
  class Menus < Vedeu::Repository

    singleton_class.send(:alias_method, :menus, :repository)

    real Vedeu::Menu
    null Vedeu::Null::Menu

  end # Menus

end # Vedeu
