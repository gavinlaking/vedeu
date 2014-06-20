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
        by_layer.map { |interface| interface.refresh }.compact
      end

      def by_layer
        all.sort_by { |interface| interface.layer }
      end

      def entity
        Interface
      end
    end
  end
end
