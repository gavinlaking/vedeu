module Vedeu
  class InterfaceRepository
    extend Repository

    class << self
      def define(&block)
        return self unless block_given?
        yield  self
      end

      def add(name, options = {})
        attributes = options.merge!({ name: name })
        interface  = klass.new(attributes)

        create(interface)

        all
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
