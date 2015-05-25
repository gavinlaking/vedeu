module Vedeu

  # Allows the storing of interfaces and views.
  class InterfacesRepository < Repository

    class << self

      # @return [Vedeu::InterfacesRepository]
      def interfaces
        @interfaces ||= reset!
      end
      alias_method :repository, :interfaces

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::InterfacesRepository]
      def reset!
        @interfaces = self.register(Vedeu::Interface)
      end

    end

    null Vedeu::Null::Interface
    # real Vedeu::Interface

  end # InterfacesRepository

end # Vedeu
