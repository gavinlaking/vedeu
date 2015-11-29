module Vedeu

  module DSL

    class Lines

      # @raise [Vedeu::Error::RequiresBlock]
      # @return [Vedeu::Views::Lines]
      # def lines(&block)
      #   fail Vedeu::Error::RequiresBlock unless block_given?

      #   client = eval('self', block.binding)

      #   # Vedeu::Models::Lines.new
      # end

    end # Lines

  end # DSL

end # Vedeu
