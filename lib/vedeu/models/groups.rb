module Vedeu

  # Allows the storing of view groups.
  #
  class Groups < Vedeu::Repository

    singleton_class.send(:alias_method, :groups, :repository)

    null Vedeu::Group
    real Vedeu::Group

  end # Groups

  class Group

    repo Vedeu::Groups.repository

  end # Group

end # Vedeu
