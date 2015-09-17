module Vedeu

  module Menus

    # Allows the storing of menus by name.
    #
    class Repository < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :menus, :repository)

      real Vedeu::Menus::Menu
      null Vedeu::Menus::Null

    end # Repository

  end # Menus

end # Vedeu
