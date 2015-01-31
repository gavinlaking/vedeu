require 'vedeu/support/repository'

module Vedeu

  # This module is included in Vedeu::Interface to provide means to store client
  # application views created with {Vedeu.renders} or {Vedeu.views}.
  #
  module DisplayBuffer

    include Vedeu::Common

    # Store the view and immediate refresh it; causing to be pushed to the
    # Terminal.
    #
    # @return [Interface]
    def store_immediate
      store_deferred

      Vedeu::Refresh.by_name(name)

      self
    end

    # Store the view if it has a name. This view will be shown next time the
    # refresh event is triggered for the interface.
    #
    # @return [Interface]
    def store_deferred
      unless defined_value?(name)
        fail InvalidSyntax, 'Cannot store an interface without a name.'
      end

      return store_new_buffer unless Vedeu.buffers.registered?(name)

      Vedeu.log("Updating buffer: '#{name}'")

      Vedeu.buffers.find(name).add(self)

      self
    end

    private

    # Registers a set of buffers for the interface unless already registered,
    # and also adds interface's name to list of focussable interfaces.
    #
    # @see Vedeu::Buffer
    # @return [Interface]
    def store_new_buffer
      unless Vedeu.buffers.registered?(name)
        Vedeu.log("Registering buffer: '#{name}'")

        Buffer.new(name, self).store
      end

      self
    end

    # Registers refresh events for the interface unless already registered.
    #
    # @return [Interface]
    def store_refresh_events
      options = { delay: delay }
      event   = "_refresh_#{name}_".to_sym

      unless Vedeu.events.registered?(event)
        Vedeu.bind(event, options) { Vedeu::Refresh.by_name(name) }
      end

      unless group.nil? || group.empty?
        event = "_refresh_group_#{group}_".to_sym

        unless Vedeu.events.registered?(event)
          Vedeu.bind(event, options) { Vedeu::Refresh.by_group(group) }
        end
      end

      self
    end

    # Registers interface name in focus list unless already registered.
    #
    # @return [Interface]
    def store_focusable
      unless Vedeu.focusable.registered?(name)
        Vedeu.focusable.add(name)
      end

      self
    end

    # Registers a new cursor for the interface unless already registered.
    #
    # @return [Interface]
    def store_cursor
      unless Vedeu.cursors.registered?(name)
        Vedeu::Cursor.new({ name: name }).store
      end

      self
    end

  end # DisplayBuffer

end # Vedeu
