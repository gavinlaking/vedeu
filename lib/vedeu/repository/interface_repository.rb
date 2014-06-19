module Vedeu
  class InterfaceRepository
    extend Repository

    class << self
      def find_by_name(value)
        query(klass, :name, value).tap do |interface|
          fail UndefinedInterface unless interface
        end
      end

      def refresh
        all.map { |interface| interface.refresh }.compact
      end

      def klass
        Interface
      end
    end
  end
end
