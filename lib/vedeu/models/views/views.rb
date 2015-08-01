module Vedeu

  module Views

    # A collection of {Vedeu::View} instances.
    #
    class Views < Vedeu::Repository

      class << self

        alias_method :views, :repository

      end # Eigenclass

      null Vedeu::Null::View
      real Vedeu::Views::View

    end # Views

    class View

      repo Vedeu::Views::Views.repository

    end # View

  end # Views

end # Vedeu
