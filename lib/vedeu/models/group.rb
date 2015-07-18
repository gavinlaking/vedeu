require 'vedeu/support/toggleable'

module Vedeu

  # Interfaces can be associated with one another by being members of the same
  # Group. A Group is a collection of interface names.
  #
  # @api private
  class Group

    include Vedeu::Model
    include Vedeu::Toggleable

    # @!attribute [rw] name
    # @return [String]
    attr_accessor :name

    # Return a new instance of Vedeu::Group.
    #
    # @param attributes [Hash]
    # @option attributes members [Array] A collection of names of interfaces
    #   belonging to this group.
    # @option attributes name [String] The name of the group.
    # @option attributes repository [Vedeu::Repository] The storage for all
    #   Group models.
    # @return [Vedeu::Group]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @members    = Array(@attributes[:members])
      @name       = @attributes[:name]
      @repository = @attributes[:repository]
      @visible    = @attributes[:visible]
    end

    # Add a member to the group by name.
    #
    # @param member [String]
    # @return [Vedeu::Group]
    def add(member)
      @members = members.add(member)

      Vedeu::Group.new(name: name, members: @members).store
    end

    # Hide the named group of interfaces, or without a name, the group of the
    # currently focussed interface.
    #
    # @example
    #   Vedeu.hide_group(name)
    #
    # @return [Vedeu::Group]
    def hide
      super

      @members.each { |member| Vedeu::Interface.hide_interface(member) }

      self
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
    # @return [Vedeu::Group]
    def remove(member)
      @members = members.delete(member)

      Vedeu::Group.new(name: name, members: @members).store
    end

    # Remove all members from the group.
    #
    # @return [Vedeu::Group]
    def reset
      Vedeu::Group.new(defaults.merge!(name: name)).store
    end

    # Show the named group of interfaces, or without a name, the group of the
    # currently focussed interface.
    #
    # @example
    #   Vedeu.show_group(name)
    #
    # @return [Vedeu::Group]
    def show
      super

      @members.each { |member| Vedeu::Interface.show_interface(member) }

      self
    end

    private

    # Returns the default options/attributes for this class.
    #
    # @return [Hash]
    def defaults
      {
        members:    [],
        name:       '',
        repository: Vedeu.groups,
        visible:    true,
      }
    end

  end # Group

end # Vedeu
