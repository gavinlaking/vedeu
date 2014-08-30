module Vedeu
  module API
    class Composition < Vedeu::Composition

      # @api public
      # @see Vedeu::API#view
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
