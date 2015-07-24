module Vedeu

  # Allows the storing of interface/view borders independent of the interface
  # instance.
  #
  class Borders < Vedeu::Repository

    class << self

      alias_method :borders, :repository

    end # Eigenclass

    null Vedeu::Null::Border
    real Vedeu::Border

  end # Borders

end # Vedeu
