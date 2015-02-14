require 'vedeu/repositories/repository'

module Vedeu

  # Allows the storing of menus by name.
  #
  class Menus < Repository

    # @return [Vedeu::Menus]
    def self.menus
      @_menus ||= Vedeu::Menus.new(Vedeu::Menu)
    end

  end # Menus

end # Vedeu
