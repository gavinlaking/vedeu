module Vedeu

  module DSL

    # Provides the mechanism to add lines to a view via the DSL.
    #
    module Lines

      include Vedeu::DSL::Text

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
