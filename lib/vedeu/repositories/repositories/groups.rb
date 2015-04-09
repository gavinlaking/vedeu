module Vedeu

  # Allows the storing of view groups.
  #
  class Groups < Repository

    # @return [Vedeu::Groups]
    def self.groups
      @groups ||= reset!
    end

    # @return [Vedeu::Groups]
    def self.repository
      Vedeu.groups
    end

    # @return [Vedeu::Groups]
    def self.reset!
      @groups = Vedeu::Groups.new(Vedeu::Group)
    end

  end # Groups

end # Vedeu
