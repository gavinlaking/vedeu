# frozen_string_literal: true

module Vedeu

  module Groups

    # Interfaces can be associated with one another by being members
    # of the same Group. A Group is a collection of interface names.
    #
    class Group

      include Vedeu::Repositories::Model
      include Vedeu::Toggleable

      # @!attribute [rw] name
      # @return [String]
      attr_accessor :name

      # Return a new instance of Vedeu::Groups::Group.
      #
      # @note
      #   A group being visible or not may not necessarily mean the
      #   members are of the same state.
      #
      # @param attributes [Hash<Symbol => Boolean|Set|String|
      #   Vedeu::Groups::Repository]
      # @option attributes members [Set] A collection of names of
      #   interfaces belonging to this group.
      # @option attributes name [String|Symbol] The name of the group.
      # @option attributes repository
      #   [Vedeu::Repositories::Repository]
      #   The storage for all Group models.
      # @option attributes visible [Boolean] Whether the group is
      #   visible or not.
      # @return [Vedeu::Groups::Group]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # Add a member to the group by name.
      #
      # @param member [String]
      # @return [Vedeu::Groups::Group]
      def add(member)
        attrs = attributes.merge!(members: members.add(member))

        Vedeu::Groups::Group.store(attrs)
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
        interfaces.sort_by(&:zindex).map(&:name)
      end

      # Returns a DSL instance responsible for defining the DSL
      # methods of this model.
      #
      # @param client [Object|NilClass] The client binding represents
      #   the client application object that is currently invoking a
      #   DSL method. It is required so that we can send messages to
      #   the client application object should we need to.
      # @return [Vedeu::Groups::DSL] The DSL instance for this model.
      def deputy(client = nil)
        Vedeu::Groups::DSL.new(self, client)
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Groups::Group]
      # @return [Boolean]
      def eql?(other)
        self.class.equal?(other.class) && name == other.name &&
          members == other.members
      end
      alias == eql?

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
      # @return [Vedeu::Groups::Group]
      def hide
        super

        @members.each { |member| Vedeu.trigger(:_hide_interface_, member) }

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
      # @return [Vedeu::Groups::Group]
      def remove(member)
        attrs = attributes.merge!(members: members.delete(member))

        Vedeu::Groups::Group.store(attrs)
      end

      # Remove all members from the group.
      #
      # @return [Vedeu::Groups::Group]
      def reset!
        attrs = defaults.merge!(name: name)

        Vedeu::Groups::Group.store(attrs)
      end
      alias reset reset!

      # Show the named group of interfaces, or without a name, the
      # group of the currently focussed interface.
      #
      # @example
      #   Vedeu.trigger(:_show_group_, name)
      #   Vedeu.show_group(name)
      #
      # @return [Vedeu::Groups::Group]
      def show
        super

        @members.each { |member| Vedeu.trigger(:_show_interface_, member) }

        self
      end

      private

      # @macro defaults_method
      def defaults
        {
          members:    Set.new,
          name:       nil,
          repository: Vedeu.groups,
          visible:    true,
        }
      end

      # Return the interfaces for all members of the group.
      #
      # @return [Array<Vedeu::Interfaces::Interface]
      def interfaces
        members.map { |name| Vedeu.interfaces.by_name(name) }
      end

    end # Group

  end # Groups

  # @api public
  # @!method hide_group
  #   @see Vedeu::Toggleable::SingletonMethods#hide
  # @api public
  # @!method show_group
  #   @see Vedeu::Toggleable::SingletonMethods#show
  # @api public
  # @!method toggle_group
  #   @see Vedeu::Toggleable::SingletonMethods#toggle
  def_delegators Vedeu::Groups::Group,
                 :hide_group,
                 :show_group,
                 :toggle_group

end # Vedeu
