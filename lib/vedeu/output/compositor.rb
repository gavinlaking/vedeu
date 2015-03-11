module Vedeu

  # Before the content of the buffer can be output to the terminal, if there are
  # any changes to the geometry of the interface (stored in the buffer), then
  # these need to be stored; replacing those already stored. This is our last
  # chance to do this as the terminal may have resized, or the client
  # application may have specified this this view should move to a new location.

  # Combines stored interface layout/geometry with an interface view/buffer
  # to create a single view to be sent to the terminal for output.
  #
  class Compositor

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

    # @return [Array<Interface>]
    def compose
      buffer.map do |view|
        view.colour   = interface.colour   unless view.colour
        view.style    = interface.style    unless view.style

        Vedeu::Output.render(view)
      end
    end

    private

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    # @return [Vedeu::Interface]
    def buffer
      Vedeu.buffers.find(name).content
    end

    # @return [Vedeu::Interface]
    def interface
      @interface ||= Vedeu.interfaces.find(name)
    end

  end # Compositor

end # Vedeu
