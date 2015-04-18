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

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::InterfacesRepository]
      def reset!
        @interfaces = Vedeu::InterfacesRepository.
          register_repository(Vedeu::Interface)
      end

    end

    # @param name [String]
    # @return [Vedeu::Interface|Vedeu::Null::Interface]
    def by_name(name)
      if registered?(name)
        find(name)

      else
        Vedeu::Null::Interface.new(name: name)

      end
    end

  end # InterfacesRepository

end # Vedeu
