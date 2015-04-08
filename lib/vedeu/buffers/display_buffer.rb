require 'vedeu/repositories/all'

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
    # @raise [InvalidSyntax] The name is not defined.
    # @return [Interface]
    def store_deferred
      unless defined_value?(name)
        fail InvalidSyntax, 'Cannot store an interface without a name.'
      end

      store_new_buffer

      self
    end

    private

    # Registers a set of buffers for the interface unless already registered,
    # and also adds interface's name to list of focussable interfaces.
    #
    # @see Vedeu::Buffer
    # @return [Interface]
    def store_new_buffer
      if Vedeu.buffers.registered?(name)
        Vedeu.buffers.find(name).add(self)

      else
        Vedeu::Buffer.new(name: name, back: self).store

      end

      self
    end

    # Registers interface name in focus list unless already registered.
    #
    # @return [Interface]
    def store_focusable
      Vedeu.focusable.add(name) unless Vedeu.focusable.registered?(name)

      self
    end

    # Registers a new cursor for the interface unless already registered.
    #
    # @return [Interface]
    def store_cursor
      Vedeu::Cursor.new(name: name).store unless Vedeu.cursors.registered?(name)

      self
    end

    # Registers a new group for the interface unless already registered.
    #
    # @return [Interface]
    def store_group
      unless group.nil? || group.empty? || Vedeu.groups.registered?(group)
        Vedeu::Group.new(name, group).store
      end

      self
    end

  end # DisplayBuffer

end # Vedeu
