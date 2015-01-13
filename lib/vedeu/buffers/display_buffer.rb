require 'vedeu/support/repository'

module Vedeu

  module DisplayBuffer

    def store_immediate
      store_deferred

      Vedeu::Refresh.by_name(name)

      self
    end

    def store_deferred
      return store_new_buffer unless Vedeu.buffers_repository.registered?(name)

      Vedeu.log("Updating buffer: '#{name}'")

      Vedeu.buffers_repository.find(name).add(self)

      self
    end

    private

    def store_new_buffer
      store_new_interface

      unless Vedeu.buffers_repository.registered?(name)
        Vedeu.log("Registering buffer: '#{name}'")

        Buffer.new(name, self).store
      end

      self
    end

    def store_new_interface

      unless Vedeu.interfaces_repository.registered?(name)
        Vedeu.log("Registering interface: '#{name}'")

        self.store
      end

      self
    end

  end # DisplayBuffer

end # Vedeu
