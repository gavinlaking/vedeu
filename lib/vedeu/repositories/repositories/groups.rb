module Vedeu

  # Allows the storing of view groups.
  class Groups < Repository

    class << self

      # @return [Vedeu::Groups]
      alias_method :groups, :repository

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::Groups]
      def reset!
        @groups = register(Vedeu::Group)
      end

    end

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
