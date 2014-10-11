module Vedeu

  # Refreshes the terminal.
  #
  # @api private
  module Refresh

    include Vedeu::Common
    extend self

    # System event to refresh all registered interfaces.
    Vedeu.event(:_refresh_) { Vedeu::Refresh.all }

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

    # Register a refresh event for an interface or group of interfaces by name.
    # When the event is called, the interface, or all interfaces belonging to
    # the group with this name will be refreshed.
    #
    # @api private
    # @param type [Symbol]
    # @param name [String]
    # @param delay [Float]
    # @return [Boolean]
    def register_event(type, name, delay = 0.0)
      event = if type == :by_group
        "_refresh_group_#{name}_".to_sym

      else
        "_refresh_#{name}_".to_sym

      end

      return false if Events.registered?(event)

      Events.add(event, { delay: delay }) { Vedeu::Refresh.send(type, name) }

      true
    end

  end # Refresh

end # Vedeu
