module Vedeu
  class InterfaceRepository
    extend Repository

    class << self
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
