module Vedeu
  module API
    class Composition < Vedeu::Composition
      def self.build(&block)
        new(&block).attributes
      end

      def initialize(&block)
        super

        if block_given?
          @self_before_instance_eval = eval('self', block.binding)

          instance_eval(&block)
        end
      end

      # @param name  [String]
      # @param block [Proc]
      def view(name, &block)
        attributes[:interfaces] << Interface.build({ name: name }, &block)
      end

      private

      def method_missing(method, *args, &block)
        @self_before_instance_eval.send(method, *args, &block)
      end
    end
  end
end
