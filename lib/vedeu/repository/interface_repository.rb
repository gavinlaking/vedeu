module Vedeu
  class InterfaceRepository
    extend Repository

    class << self
      def create(*args)
        activate(super)
      end

      def activate(interface)
        deactivate

        all.map do |stored|
          stored.active = true if stored == interface
        end
      end

      def deactivate
        all.map { |interface| interface.active = false }
      end

      def activated
        query(klass, :active, true)
      end

      def find_by_name(value)
        interface = query(klass, :name, value)

        fail UndefinedInterface if interface.nil?

        interface
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
