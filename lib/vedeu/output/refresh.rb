module Vedeu

  # Refreshes the terminal.
  #
  # @api private
  module Refresh

    module_function

    # Refresh all registered interfaces.
    #
    # @return [Array]
    def all
      message = 'Refreshing all interfaces'

      Vedeu.timer(message) do
        Vedeu.interfaces.zindexed.each { |model| by_name(model.name) }
      end
    end

    # Refresh the interface which is currently focussed.
    #
    # @return [Array|ModelNotFound|NilClass]
    def by_focus
      by_name(Vedeu.focus) if Vedeu.focus
    end

    # Refresh an interface, or collection of interfaces belonging to a group.
    #
    # @note
    #   The group of interfaces will be refreshed in z-index order, meaning that
    #   interfaces with a lower z-index will be draw first. This means
    #   overlapping interfaces will be drawn as specified.
    #
    # @param group_name [String] The name of the group to be refreshed.
    # @return [Array|ModelNotFound] A collection of the names of interfaces
    #   refreshed, or an exception if the group was not found.
    def by_group(group_name)
      message = "Refreshing group: '#{group_name}'"

      Vedeu.timer(message) do
        members    = Vedeu.groups.find!(group_name).members
        interfaces = members.each { |name| Vedeu.interfaces.by_name(name) }
        by_zindex  = interfaces.sort { |a, b| a.zindex <=> b.zindex }
        by_zindex.each { |name| by_name(name) }
      end
    end

    # Refresh an interface by name.
    #
    # @param name [String] The name of the interface to be refreshed using the
    #   named buffer.
    # @return [Array|ModelNotFound]
    def by_name(name)
      message = "Refreshing interface: '#{name}'"

      Vedeu.timer(message) { Vedeu.buffers.by_name(name).render }
    end

  end # Refresh

end # Vedeu
