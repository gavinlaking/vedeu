module Vedeu

  module DSL

    # Provides the mechanism to add streams to a line via the DSL.
    #
    module Streams

      include Vedeu::DSL::Text

      # @raise [Vedeu::Error::RequiresBlock]
      # @return [Vedeu::Views::Streams]
      # def streams(&block)
      #   fail Vedeu::Error::RequiresBlock unless block_given?

      #   client = eval('self', block.binding)

      #   # Vedeu::Models::Stream.new
      # end

    end # Streams

  end # DSL

end # Vedeu
