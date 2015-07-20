require 'vedeu/models/group'

module Vedeu

  # Allows the storing of view groups.
  #
  # @api public
  class Groups < Vedeu::Repository

    class << self

      alias_method :groups, :repository

    end # Eigenclass

    null Vedeu::Group
    real Vedeu::Group

  end # Groups

  class Group

    repo Vedeu::Groups.repository

  end # Group

end # Vedeu
