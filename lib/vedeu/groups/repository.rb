module Vedeu

  module Groups

    # Allows the storing of view groups.
    #
    class Repository < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :groups, :repository)

      null Vedeu::Groups::Group
      real Vedeu::Groups::Group

    end # Groups

    class Group

      repo Vedeu::Groups::Repository.repository

    end # Group

  end # Groups

end # Vedeu
