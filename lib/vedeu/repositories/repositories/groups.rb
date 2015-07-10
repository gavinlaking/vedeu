module Vedeu

  # Allows the storing of view groups.
  #
  # @api public
  class Groups < Repository

    class << self

      alias_method :groups, :repository

      # Remove all stored models from the repository.
      #
      # @example
      #   Vedeu.groups.reset!
      #
      # @return [Vedeu::Groups]
      def reset!
        @groups = register(Vedeu::Group)
      end

    end # Eigenclass

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

end # Vedeu
