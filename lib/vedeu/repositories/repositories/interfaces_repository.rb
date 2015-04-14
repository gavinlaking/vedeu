module Vedeu

  # Allows the storing of interfaces and views.
  #
  class InterfacesRepository < Repository

    class << self

      # @return [Vedeu::InterfacesRepository]
      def interfaces
        @interfaces ||= reset!
      end
      alias_method :repository, :interfaces

      # @return [Vedeu::InterfacesRepository]
      def reset!
        @interfaces = Vedeu::InterfacesRepository.
          register_repository(Vedeu::Interface)
      end

    end

    # @param name [String]
    # @return [Vedeu::Interface|Vedeu::NullInterface]
    def by_name(name)
      if registered?(name)
        find(name)

      else
        Vedeu::NullInterface.new(name: name)

      end
    end

  end # InterfacesRepository

end # Vedeu
