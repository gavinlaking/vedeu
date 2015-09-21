module Vedeu

  module Models

    # Allows the storing of view groups.
    #
    class Groups < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :groups, :repository)

      null Vedeu::Models::Group
      real Vedeu::Models::Group

    end # Groups

    class Group

      repo Vedeu::Models::Groups.repository

    end # Group

  end # Models

end # Vedeu
