module Vedeu
  class CommandRepository
    extend Repository

    def define(&block)
      if block_given?
        yield self
      else
        self
      end
    end

    def self.klass
      Command
    end
  end
end
