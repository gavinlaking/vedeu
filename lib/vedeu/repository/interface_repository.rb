module Vedeu
  class UndefinedInterface < StandardError; end

  class InterfaceRepository
    extend Repository

    class << self
      def find(name)
        result = super
        raise UndefinedInterface unless result
        result
      end

      def refresh
        all.map { |interface| interface.refresh }.compact
      end

      def entity
        Interface
      end
    end
  end
end
