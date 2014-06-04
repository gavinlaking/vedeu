module Vedeu
  class InterfaceRepository
    extend Repository

    def self.klass
      Interface
    end
  end

  class CommandRepository
    extend Repository

    def self.klass
      Command
    end
  end
end
