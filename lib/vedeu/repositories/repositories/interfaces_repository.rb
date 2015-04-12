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

  end # InterfacesRepository

end # Vedeu
