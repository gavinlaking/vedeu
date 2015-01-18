require 'vedeu/support/common'

module Vedeu

  # Before the content of the buffer can be output to the terminal, if there are
  # any changes to the geometry of the interface (stored in the buffer), then
  # these need to be stored; replacing those already stored. This is our last
  # chance to do this as the terminal may have resized, or the client
  # application may have specified this this view should move to a new location.

  # Combines stored interface layout/geometry with an interface view/buffer
  # to create a single view to be sent to the terminal for output.
  #
  # @api private
  class Compositor

    include Vedeu::Common

    # Convenience method to initialize a new Compositor and call its {#compose}
    # method.
    #
    # @return [Compositor]
    # @see #initialize
    def self.compose(buffer)
      new(buffer).compose
    end

    # Initialize a new Compositor.
    #
    # @param buffer [Inteface]
    # @return [Compositor]
    def initialize(buffer)
      @buffer = buffer
    end

    # @todo What do we do about resizing terminals. I don't want to overwrite
    # the stored geometry and when the terminal returns to original size not also
    # return the interface back to its originally prescribed dimensions.
    #
    # @note
    # If the buffer has geometry stored, we should check whether this is different
    # to the geometries repository- the client application is wanting to resize
    # or move the interface.
    #
    # If it is different, overwrite the old geometry with the new.
    #
    # If the buffer does not have geometry stored, retrieve the geometry for this
    # interface from the geometries repository so we can draw this buffer in the
    # correct place.
    #
    # @return [Array<Interface>]
    def compose
      if interface && interface.geometry
        # client provided geometry

      else
        # retrieve stored geometry

      end

      Output.render(interface) if interface
    end

    private

    attr_reader :buffer

    def interface
      buffer.current
    end

  end # Compositor

end # Vedeu
