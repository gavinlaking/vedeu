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
        @groups = Vedeu::Groups.new(Vedeu::Group)
      end

    end

  end # Groups

end # Vedeu
