module Vedeu

  # Allows the storing of menus by name.
  class Menus < Repository

    class << self

      # @return [Vedeu::Menus]
      def menus
        @menus ||= reset!
      end
      alias_method :repository, :menus

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::Menus]
      def reset!
        @menus = Vedeu::Menus.register(Vedeu::Menu)
      end

    end

  end # Menus

end # Vedeu
