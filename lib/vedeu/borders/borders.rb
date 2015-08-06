module Vedeu

  # Allows the storing of interface/view borders independent of the interface
  # instance.
  #
  class Borders < Vedeu::Repository

    singleton_class.send(:alias_method, :borders, :repository)

    null Vedeu::Null::Border
    real Vedeu::Border

  end # Borders

end # Vedeu
