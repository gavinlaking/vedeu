require 'vedeu/repositories/repository'

module Vedeu

  class Menus < Repository

    # @return [Vedeu::Menus]
    def self.menus
      @_menus ||= Vedeu::Menus.new(Vedeu::Menu)
    end

  end # Menus

end # Vedeu
