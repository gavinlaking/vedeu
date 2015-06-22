module Vedeu

  module Renderers

    # A renderer which returns nothing.
    #
    # @api private
    class Null

      # @return [NilClass]
      def self.render(*)
        nil
      end

    end # Null

  end # Renderers

end # Vedeu
