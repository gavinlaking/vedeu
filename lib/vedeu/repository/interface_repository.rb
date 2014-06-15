module Vedeu
  class InterfaceRepository
    extend Repository

    class << self
      def activate(name)
        deactivate

        all.map do |interface|
          interface.active = true if interface.name == name
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

        raise UndefinedInterface if interface.nil? || interface.is_a?(Hash)

        interface
      end

      def initial_state
        all.map { |interface| interface.initial_state }
      end

      def klass
        Interface
      end
    end
  end
end
