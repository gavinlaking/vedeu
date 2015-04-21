module Vedeu

  # Allows the storing of interface/view borders independent of the interface
  # instance.
  class Borders < Repository

    class << self

      # @return [Vedeu::Borders]
      def borders
        @borders ||= reset!
      end
      alias_method :repository, :borders

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::Borders]
      def reset!
        @borders = Vedeu::Borders.register(Vedeu::Border)
      end

    end

    null Vedeu::Null::Border

  end # Borders

end # Vedeu
