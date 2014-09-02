module Vedeu

  # Refreshes the terminal.
  module Refresh

    include Vedeu::Common
    extend self

    # Add a refresh event for the interface and a refresh event for the group.
    #
    # @param attributes [Hash]
    # @return []
    def add(attributes)
      register_by_name(attributes[:name], attributes[:delay])

      register_by_group(attributes[:group], attributes[:delay])
    end

    # Refresh all registered interfaces.
    #
    # @return []
    def all
      Vedeu::Interfaces.registered.each { |name| by_name(name) }
    end

    # Refresh the interface which is currently focussed.
    #
    # @return []
    def by_focus
      by_name(Vedeu::Focus.current)
    end

    # Refresh an interface, or collection of interfaces belonging to a group.
    #
    # @param group_name [String] The name of the group to be refreshed.
    # @return [Array] A collection of the names of interfaces refreshed.
    def by_group(group_name)
      Vedeu::Groups.find(group_name).each { |name| by_name(name) }
    end

    # Refresh an interface by name.
    #
    # @param name [String] The name of the interface to be refreshed.
    # @return []
    def by_name(name)
      Vedeu::Compositor.render(name)
    end

    private

    # Register a refresh event for an interface by name. When the event is
    # called, the interface with this name will be refreshed.
    #
    # @api private
    # @param name  [String] The name of the interface to be refreshed.
    # @param delay [Float]  The throttle for how often this interface can be
    #   refreshed.
    # @return []
    def register_by_name(name, delay)
      return false unless defined_value?(name)
      return false if event_registered?(event_name(name))

      Vedeu.event(event_name(name), { delay: delay }) do
        Vedeu::Refresh.by_name(name)
      end

      true
    end

    # Register a refresh event for a group of interfaces by name. When the event
    # is called, all interfaces belonging to the group with this name will be
    # refreshed.
    #
    # @api private
    # @param name  [String] The name of the group to be refreshed.
    # @param delay [Float]  The throttle for how often this group can be
    #   refreshed.
    # @return []
    def register_by_group(name, delay)
      return false unless defined_value?(name)
      return false if event_registered?(group_event_name(name))

      Vedeu.event(group_event_name(name), { delay: delay }) do
        Vedeu::Refresh.by_group(name)
      end

      true
    end

    # Returns the event name for refreshing the named interface.
    #
    # @api private
    # @param name [String] The name of the interface.
    # @return [Symbol]
    def event_name(name)
      "_refresh_#{name}_".to_sym
    end

    # Returns the event name for refreshing the named group of interfaces.
    #
    # @api private
    # @param name [String] The name of the group.
    # @return [Symbol]
    def group_event_name(name)
      "_refresh_group_#{name}_".to_sym
    end

    # Returns a boolean indicating that an event by name has already been
    # registered.
    #
    # @api private
    # @param name [Symbol] The event name to check.
    # @return [TrueClass|FalseClass]
    def event_registered?(name)
      Vedeu.events.registered?(name)
    end

  end

end
