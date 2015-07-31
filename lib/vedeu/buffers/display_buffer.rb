module Vedeu

  # This module is included in Vedeu::Interface to provide means to store client
  # application views created with {Vedeu.renders} or {Vedeu.views}.
  #
  module DisplayBuffer

    include Vedeu::Common

    # Store the view and immediately refresh it; causing to be pushed to the
    # Terminal.
    #
    # @return [Vedeu::Interface]
    def store_immediate
      store_deferred

      Vedeu::Refresh.by_name(name)

      self
    end

    # When a name is given, the view is stored with this name. This view will be
    # shown next time the refresh event is triggered for the interface.
    #
    # @raise [Vedeu::InvalidSyntax] The name is not defined.
    # @return [Vedeu::Interface]
    def store_deferred
      unless present?(name)
        fail Vedeu::InvalidSyntax, 'Cannot store an interface without a name.'
      end

      Vedeu.buffers.by_name(name).add(self)

      self
    end

  end # DisplayBuffer

end # Vedeu
