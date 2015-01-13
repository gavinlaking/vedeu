require 'vedeu/support/repository'

module Vedeu

  # This module is included in Vedeu::Interface to provide means to store client
  # application views created with {Vedeu.renders} or {Vedeu.views}.
  #
  module DisplayBuffer

    # Store the view and immediate refresh it; causing to be pushed to the
    # Terminal.
    #
    # @return [Interface]
    def store_immediate
      store_deferred

      Vedeu::Refresh.by_name(name)

      self
    end

    # Store the view. This view will be shown next time the refresh event is
    # triggered for the interface.
    #
    # @return [Interface]
    def store_deferred
      return store_new_buffer unless Vedeu.buffers_repository.registered?(name)

      Vedeu.log("Updating buffer: '#{name}'")

      Vedeu.buffers_repository.find(name).add(self)

      self
    end

    private

    # Registers a set of buffers for the interface.
    #
    # @see Vedeu::Buffer
    # @return [Interface]
    def store_new_buffer
      store_new_interface

      unless Vedeu.buffers_repository.registered?(name)
        Vedeu.log("Registering buffer: '#{name}'")

        Buffer.new(name, self).store
      end

      self
    end

    # Registers the interface.
    #
    # @return [Interface]
    def store_new_interface
      unless Vedeu.interfaces_repository.registered?(name)
        Vedeu.log("Registering interface: '#{name}'")

        self.store
      end

      self
    end

  end # DisplayBuffer

end # Vedeu
