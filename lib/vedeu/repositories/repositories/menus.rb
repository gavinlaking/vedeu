module Vedeu

  # Allows the storing of menus by name.
  #
  class Menus < Repository

    # @return [Vedeu::Menus]
    def self.menus
      @menus ||= reset!
    end

    # @return [Vedeu::Menus]
    def self.repository
      Vedeu.menus
    end

    # @return [Vedeu::Menus]
    def self.reset!
      @menus = Vedeu::Menus.new(Vedeu::Menu)
    end

  end # Menus

end # Vedeu
