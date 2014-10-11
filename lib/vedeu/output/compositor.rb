module Vedeu

  # Combines stored interface layout/geometry with an interface view/buffer
  # to create a single view to be sent to the terminal for output.
  #
  # @api private
  class Compositor

    include Common

    # @param name [String] The name of the interface/buffer.
    # @return [Compositor]
    def self.render(name)
      new(name).render
    end

    # Initialize a new Compositor.
    #
    # @param name [String] The name of the interface/buffer.
    # @return [Compositor]
    def initialize(name)
      @name = name
    end

    # Send the view to the terminal.
    #
    # @return [Array]
    def render
      Terminal.output(view)
    end

    private

    attr_reader :name

    # Renders the buffer unless empty, otherwise clears the area which the
    # interface occupies.
    #
    # @api private
    # @return [String]
    def view
      if buffer
        Render.call(Interface.new(new_interface))

      else
        Clear.call(Interface.new(interface))

      end
    end

    # Combine the buffer attributes with the interface attributes. Buffer
    # presentation attributes will override interface defaults.
    #
    # @api private
    # @return [Hash]
    def new_interface
      combined = interface
      combined[:lines]  = buffer[:lines]
      combined[:colour] = buffer[:colour] if defined_value?(buffer[:colour])
      combined[:style]  = buffer[:style]  if defined_value?(buffer[:style])
      combined
    end

    # Returns the attributes of the named interface (layout).
    #
    # @api private
    # @return [Hash]
    def interface
      @_interface ||= Vedeu::Interfaces.find(name)
    end

    # Returns the attributes of the latest buffer (view).
    #
    # @api private
    # @return [Hash]
    def buffer
      @_buffer ||= Vedeu::Buffers.latest(name)
    end

  end # Compositor

end # Vedeu
