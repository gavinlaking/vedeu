module Vedeu
  class InterfaceRepository
    extend Repository

    class << self
      def find_by_name(value)
        query(klass, :name, value).tap do |interface|
          fail UndefinedInterface unless interface
        end
      end

      def update
        all.map { |interface| interface.update }.compact
      end

      def klass
        Interface
      end
    end
  end
end
