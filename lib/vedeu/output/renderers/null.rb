module Vedeu

  module Renderers

    # A renderer which returns nothing.
    class Null

      # @return [NilClass]
      def self.render(*)
        nil
      end

    end # Null

  end # Renderers

end # Vedeu
