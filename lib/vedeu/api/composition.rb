module Vedeu
  module API

    # @see Vedeu::Composition
    class Composition < Vedeu::Composition

      # @api public
      # @see Vedeu::API#view
      def view(name, &block)
        attributes[:interfaces] << API::Interface
          .build({ name: name, parent: self.view_attributes }, &block)
      end

    end
  end
end
