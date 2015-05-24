module Vedeu

  # Refreshes the terminal.
  #
  module Refresh

    module_function

    # Refresh all registered interfaces.
    #
    # @return [Array]
    def all
      message = "Refreshing all interfaces"

      Vedeu.log(type: :info, message: message)

      timer(message) do
        Vedeu.interfaces.registered.each { |name| by_name(name) }
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
    # @param group_name [String] The name of the group to be refreshed.
    # @return [Array|ModelNotFound] A collection of the names of interfaces
    #   refreshed, or an exception if the group was not found.
    def by_group(group_name)
      message = "Refreshing group: '#{group_name}'"

      Vedeu.log(type: :info, message: message)

      timer(message) do
        Vedeu.groups.find!(group_name).members.each { |name| by_name(name) }
      end
    end

    # Refresh an interface by name.
    #
    # @param name [String] The name of the interface to be refreshed using the
    #   named buffer.
    # @return [Array|ModelNotFound]
    def by_name(name)
      message = "Refreshing interface: '#{name}'"

      Vedeu.log(type: :info, message: message)

      timer(message) { Vedeu.buffers.by_name(name).render }
    end

    # @param message [String]
    # @param block [Proc]
    # @return [Array|ModelNotFound]
    def timer(message = '', &block)
      started  = Time.now.to_f

      work = yield

      finished = Time.now.to_f
      elapsed  = ((finished - started) * 1000).to_i

      Vedeu.log(type: :debug, message: "#{message} took #{elapsed}ms.")

      work
    end

  end # Refresh

end # Vedeu
