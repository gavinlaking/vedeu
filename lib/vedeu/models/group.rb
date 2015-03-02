module Vedeu

  # Interfaces can be associated with one another by being members of the same
  # Group. A Group is a collection of interface names.
  #
  class Group

    include Vedeu::Model

    attr_reader :name

    # Return a new instance of Group.
    #
    # @param name [String] The name of the group.
    # @param members [Array]
    # @return [Group]
    def initialize(name, members = [])
      @name       = name
      @members    = Array(members)
      @repository = Vedeu.groups
    end

    # Add a member to the group by name.
    #
    # @param member [String]
    # @return [Group]
    def add(member)
      Group.new(name, members.add(member)).store
    end

    # Return the members as a Set.
    #
    # @return [Set]
    def members
      @members.to_set
    end

    # Remove a member from the group by name.
    #
    # @param member [String]
    # @return [Group]
    def remove(member)
      Group.new(name, members.delete(member)).store
    end

    # Remove all members from the group.
    #
    # @return [Group]
    def reset
      Group.new(name).store
    end

    private

  end # Group

end # Vedeu
