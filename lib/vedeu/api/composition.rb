module Vedeu
  module API
    class Composition < Vedeu::Composition

      # @api public
      # @see Vedeu::API#view
      def view(name, &block)
        attributes[:interfaces] << Interface.build({ name: name }, &block)
      end

    end
  end
end
