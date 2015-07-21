require 'vedeu/output/refresh_group'

module Vedeu

  # Refreshes the terminal.
  #
  # @note
  #   In the cases of {#all} and {#by_group}, the interfaces will be refreshed
  #   in z-index order, meaning that interfaces with a lower z-index will be
  #   drawn first. This means overlapping interfaces will be drawn as specified.
  #
  # @api public
  module Refresh

    module_function

    # Refresh all registered interfaces.
    #
    # @example
    #   Vedeu.trigger(:_refresh_)
    #
    #   Vedeu::Refresh.all
    #
    # @return [Array]
    def all
      Vedeu.timer('Refresh All') do
        Vedeu.interfaces.zindexed.each { |model| by_name(model.name) }
      end
    end

    # Refresh the interface which is currently focussed.
    #
    # @return [Array|Vedeu::ModelNotFound|NilClass]
    def by_focus
      by_name(Vedeu.focus) if Vedeu.focus
    end

    # Refresh an interface, or collection of interfaces belonging to a group.
    #
    # @example
    #   Vedeu.trigger(:_refresh_group_, group_name)
    #
    #   Vedeu::Refresh.by_group(group_name)
    #
    # @param group_name [String] The name of the group to be refreshed.
    # @return [Array|Vedeu::ModelNotFound] A collection of the names of
    #   interfaces refreshed, or an exception if the group was not found.
    def by_group(group_name)
      Vedeu.timer("Refresh Group: '#{group_name}'") do
        Vedeu::RefreshGroup.by_name(group_name)
      end
    end

    # Refresh an interface by name.
    #
    # @example
    #   Vedeu.trigger(:_refresh_, name)
    #
    #   Vedeu::Refresh.by_name(name)
    #
    # @param name [String] The name of the interface to be refreshed using the
    #   named buffer.
    # @return [Array|Vedeu::ModelNotFound]
    def by_name(name)
      Vedeu.timer("Refresh Interface: '#{name}'") do
        Vedeu.buffers.by_name(name).render
      end
    end

  end # Refresh

end # Vedeu
