module Vedeu

  module Borders

    # Allows the storing of interface/view borders independent of the
    # interface instance.
    #
    class Repository < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :borders, :repository)

      null Vedeu::Borders::Null
      real Vedeu::Borders::Border

    end # Repository

  end # Borders

  # Manipulate the repository of borders.
  #
  # @example
  #   Vedeu.borders
  #
  # @!method borders
  # @return [Vedeu::Borders::Repository]
  def_delegators Vedeu::Borders::Repository, :borders

end # Vedeu
