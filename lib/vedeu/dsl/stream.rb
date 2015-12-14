module Vedeu

  module DSL

    # Provides methods to be used to define views.
    #
    class Stream

      include Vedeu::DSL
      include Vedeu::DSL::Presentation
      include Vedeu::DSL::Elements

    end # Stream

  end # DSL

end # Vedeu
