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
        query(klass, :name, value)
      end

      def initial_state
        all.map { |interface| interface.initial_state }
      end

      def input
        all.map { |interface| interface.input }
      end

      def output
        all.map { |interface| interface.output }
      end

      def klass
        Interface
      end
    end
  end
end
