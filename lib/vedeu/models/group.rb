module Vedeu

  module Models

    # Interfaces can be associated with one another by being members
    # of the same Group. A Group is a collection of interface names.
    #
    class Group

      include Vedeu::Repositories::Model
      include Vedeu::Toggleable

      # @!attribute [rw] name
      # @return [String]
      attr_accessor :name

      # Return a new instance of Vedeu::Models::Group.
      #
      # @note
      #   A group being visible or not may not necessarily mean the
      #   members are of the same state.
      #
      # @param attributes [Hash]
      # @option attributes members [Set] A collection of names of
      #   interfaces belonging to this group.
      # @option attributes name [String] The name of the group.
      # @option attributes repository
      #   [Vedeu::Repositories::Repository]
      #   The storage for all Group models.
      # @option attributes visible [Boolean] Whether the group is
      #   visible or not.
      # @return [Vedeu::Models::Group]
      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # Add a member to the group by name.
      #
      # @param member [String]
      # @return [Vedeu::Models::Group]
      def add(member)
        attrs = attributes.merge!(members: members.add(member))

        Vedeu::Models::Group.new(attrs).store
      end

      # Returns the attributes of the group.
      #
      # @return [Hash<Symbol => void>]
      def attributes
        {
          name:       name,
          members:    members,
          repository: repository,
          visible:    visible,
        }
      end

      # Return the members of the group sorted by the zindex of the
      # members.
      #
      # @return [Array<String>]
      def by_zindex
        interfaces.sort { |a, b| a.zindex <=> b.zindex }.map(&:name)
      end

      # Hide the named group of interfaces, or without a name, the
      # group of the currently focussed interface. Useful for hiding
      # part of that which is currently displaying in the terminal.
      #
      # @note
      #   The action of showing a group will effectively clear the
      #   terminal and show the new group, therefore hiding the group
      #   may not be necessary.
      #
      # @example
      #   Vedeu.trigger(:_hide_group_, name)
      #   Vedeu.hide_group(name)
      #
      # @return [Vedeu::Models::Group]
      def hide
        super

        @members.each do |member|
          Vedeu::Models::Interface.hide_interface(member)
        end

        self
      end

      # Return the members of the group.
      #
      # @return [Set]
      def members
        @_members ||= Set.new(@members)
      end

      # Remove a member from the group by name.
      #
      # @param member [String]
      # @return [Vedeu::Models::Group]
      def remove(member)
        attrs = attributes.merge!(members: members.delete(member))

        Vedeu::Models::Group.new(attrs).store
      end

      # Remove all members from the group.
      #
      # @return [Vedeu::Models::Group]
      def reset
        attrs = defaults.merge!(name: name)

        Vedeu::Models::Group.new(attrs).store
      end

      # Show the named group of interfaces, or without a name, the
      # group of the currently focussed interface.
      #
      # @example
      #   Vedeu.trigger(:_show_group_, name)
      #   Vedeu.show_group(name)
      #
      # @return [Vedeu::Models::Group]
      def show
        super

        @members.each do |member|
          Vedeu::Models::Interface.show_interface(member)
        end

        self
      end

      # Toggle the visibility of the group with the given name.
      #
      # @example
      #   Vedeu.trigger(:_toggle_group, name)
      #   Vedeu.toggle_group(name)
      #
      # @return [Vedeu::Models::Group]
      def toggle
        super

        self
      end

      private

      # Returns the default options/attributes for this class.
      #
      # @return [Hash]
      def defaults
        {
          members:    Set.new,
          name:       '',
          repository: Vedeu.groups,
          visible:    true,
        }
      end

      # Return the interfaces for all members of the group.
      #
      # @return [Array<Vedeu::Models::Interface]
      def interfaces
        members.map { |name| Vedeu.interfaces.by_name(name) }
      end

    end # Group

  end # Models

end # Vedeu
