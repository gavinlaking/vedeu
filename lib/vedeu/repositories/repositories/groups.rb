module Vedeu

  # Allows the storing of view groups.
  #
  class Groups < Repository

    class << self

      # @return [Vedeu::Groups]
      def groups
        @groups ||= reset!
      end
      alias_method :repository, :groups

      # @return [Vedeu::Groups]
      def reset!
        @groups = Vedeu::Groups.register_repository(Vedeu::Group)
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
