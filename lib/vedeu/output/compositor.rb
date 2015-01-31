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
    def self.compose(name)
      new(name).compose
    end

    # Initialize a new Compositor.
    #
    # @param name [String] The name of the buffer.
    # @return [Compositor]
    def initialize(name)
      @name = name
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
      buffer.map do |view|
        view.border   = interface.border   unless view.border
        view.colour   = interface.colour   unless view.colour
        view.style    = interface.style    unless view.style
        view.geometry = interface.geometry unless view.geometry

        Output.render(view)
      end
    end

    private

    attr_reader :name

    def buffer
      Vedeu.buffers.find(name).content
    end

    def interface
      @interface ||= Vedeu.interfaces.find(name)
    end

  end # Compositor

end # Vedeu
