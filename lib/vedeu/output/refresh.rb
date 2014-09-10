module Vedeu

  # Refreshes the terminal.
  #
  # @api private
  module Refresh

    include Vedeu::Common
    extend self

    # Refresh all registered interfaces.
    #
    # @return [Array]
    def all
      Vedeu::Interfaces.registered.each { |name| by_name(name) }
    end

    # Refresh the interface which is currently focussed.
    #
    # @return [|NoInterfacesDefined]
    def by_focus
      by_name(Vedeu::Focus.current)
    end

    # Refresh an interface, or collection of interfaces belonging to a group.
    #
    # @param group_name [String] The name of the group to be refreshed.
    # @return [Array|GroupNotFound] A collection of the names of interfaces
    #   refreshed, or an exception if the group was not found.
    def by_group(group_name)
      Vedeu::Groups.find(group_name).each { |name| by_name(name) }
    end

    # Refresh an interface by name.
    #
    # @param name [String] The name of the interface to be refreshed.
    # @return [|BufferNotFound]
    def by_name(name)
      Vedeu::Compositor.render(name)
    end

  end

end
