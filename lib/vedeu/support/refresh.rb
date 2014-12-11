module Vedeu

  # Refreshes the terminal.
  #
  # @api private
  module Refresh

    include Common
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
      by_name(Focus.current)
    end

    # Refresh an interface, or collection of interfaces belonging to a group.
    #
    # @param group_name [String] The name of the group to be refreshed.
    # @return [Array|ModelNotFound] A collection of the names of interfaces
    #   refreshed, or an exception if the group was not found.
    def by_group(group_name)
      Groups.find(group_name).each { |name| by_name(name) }
    end

    # Refresh an interface by name.
    #
    # @param name [String] The name of the interface to be refreshed using the
    #   named buffer.
    # @return [Array|ModelNotFound]
    def by_name(name)
      interface = Interfaces.find(name)
      buffer    = Buffers.find(name)

      Compositor.compose(interface, buffer)
    end

    # Register a refresh event for an interface or group of interfaces by name.
    # When the event is called, the interface, or all interfaces belonging to
    # the group with this name will be refreshed.
    #
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

      Events.add(event, { delay: delay }) { Refresh.send(type, name) }

      true
    end

  end # Refresh

end # Vedeu
