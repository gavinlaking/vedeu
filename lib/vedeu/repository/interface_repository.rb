module Vedeu
  class InterfaceRepository
    extend Repository

    def define(&block)
      if block_given?
        yield self
      else
        self
      end
    end

    def self.klass
      Interface
    end
  end
end
