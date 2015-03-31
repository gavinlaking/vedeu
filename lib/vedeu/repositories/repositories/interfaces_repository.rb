module Vedeu

  # Allows the storing of interfaces and views.
  #
  class InterfacesRepository < Repository

    # @return [Vedeu::InterfacesRepository]
    def self.interfaces
      @interfaces ||= reset!
    end

    def self.repository
      Vedeu.interfaces
    end

    def self.reset!
      @interfaces = Vedeu::InterfacesRepository.new(Vedeu::Interface)
    end

  end # InterfacesRepository

end # Vedeu
