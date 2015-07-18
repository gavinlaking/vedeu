require 'vedeu/models/group'

module Vedeu

  # Allows the storing of view groups.
  #
  # @api public
  class Groups < Repository

    class << self

      alias_method :groups, :repository

    end # Eigenclass

    real Vedeu::Group

    # @example
    #   Vedeu.groups.by_name('name')
    #
    # @param name [String] The name of the stored group.
    # @return [Vedeu::Group]
    def by_name(name)
      if registered?(name)
        find(name)

      else
        Vedeu::Group.new(name: name).store

      end
    end

  end # Groups

  class Group

    repo Vedeu::Groups.repository

  end

end # Vedeu
