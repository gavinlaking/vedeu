module Vedeu

  # Allows the storing of menus by name.
  #
  class Menus < Repository

    class << self

      # @return [Vedeu::Menus]
      def menus
        @menus ||= reset!
      end
      alias_method :repository, :menus

      # @return [Vedeu::Menus]
      def reset!
        @menus = Vedeu::Menus.register_repository(Vedeu::Menu)
      end

    end

  end # Menus

end # Vedeu
