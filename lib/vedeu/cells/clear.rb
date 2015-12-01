module Vedeu

  module Cells

    class Clear < Empty

      # @return [Boolean]
      def cell?
        false
      end

      # @return [String]
      def value
        ' '.freeze
      end

    end # Clear

  end # Cells

end # Vedeu
