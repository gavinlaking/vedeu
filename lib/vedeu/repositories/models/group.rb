module Vedeu

  # Interfaces can be associated with one another by being members of the same
  # Group. A Group is a collection of interface names.
  #
  class Group

    attr_reader :name

    # Return a new instance of Group.
    #
    # @param name [String] The name of the group.
    # @param members [String]
    # @return [Group]
    def initialize(name, *members)
      @name    = name
      @members = members.to_set
    end

    # Add a member to the group by name.
    #
    # @param member [String]
    # @return [Group]
    def add(member)
      new_members = @members.add(member)

      Group.new(name, *new_members)
    end

    # Returns the members as a collection.
    #
    # @return [Array]
    def members
      @members.to_a
    end

    # Remove a member from the group by name.
    #
    # @param member [String]
    # @return [Group]
    def remove(member)
      new_members = @members.delete(member)

      Group.new(name, *new_members)
    end

    # Remove all members from the group.
    #
    # @return [Group]
    def reset
      Group.new(name)
    end

  end # Group

end # Vedeu
