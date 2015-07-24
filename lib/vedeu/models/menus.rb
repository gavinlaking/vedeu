module Vedeu

  # Allows the storing of menus by name.
  #
  class Menus < Vedeu::Repository

    class << self

      alias_method :menus, :repository

    end # Eigenclass

    real Vedeu::Menu

  end # Menus

end # Vedeu
