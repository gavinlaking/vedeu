module Vedeu

  # Allows the storing of menus by name.
  #
  class Menus < Repository

    # @return [Vedeu::Menus]
    def self.menus
      @menus ||= reset!
    end

    def self.repository
      Vedeu.menus
    end

    def self.reset!
      @menus = Vedeu::Menus.new(Vedeu::Menu)
    end

  end # Menus

end # Vedeu
