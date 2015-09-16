module Vedeu

  module Borders

    # Allows the storing of interface/view borders independent of the
    # interface instance.
    #
    class Repository < Vedeu::Repository

      singleton_class.send(:alias_method, :borders, :repository)

      null Vedeu::Borders::Null
      real Vedeu::Borders::Border

    end # Repository

  end # Borders

end # Vedeu
