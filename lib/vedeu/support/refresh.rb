module Vedeu

  # Refreshes the terminal.
  #
  # @api private
  #
  module Refresh

    extend self

    # Refresh all registered interfaces.
    #
    # @return [Array]
    def all
      Vedeu.interfaces.registered.each { |name| by_name(name) }
    end

    # Refresh the interface which is currently focussed.
    #
    # @return [|NilClass]
    def by_focus
      by_name(Vedeu.focus) if Vedeu.focus
    end

    # Refresh an interface, or collection of interfaces belonging to a group.
    #
    # @param group_name [String] The name of the group to be refreshed.
    # @return [Array|ModelNotFound] A collection of the names of interfaces
    #   refreshed, or an exception if the group was not found.
    def by_group(group_name)
      Vedeu.log(type: :info, message: "Refreshing group: '#{group_name}'")

      Vedeu.groups.find(group_name).members.each { |name| by_name(name) }
    end

    # Refresh an interface by name.
    #
    # @param name [String] The name of the interface to be refreshed using the
    #   named buffer.
    # @return [Array|ModelNotFound]
    def by_name(name)
      Vedeu.log(type: :info, message: "Refreshing interface: '#{name}'")

      Vedeu::Compositor.compose(name)
    end

  end # Refresh

end # Vedeu
