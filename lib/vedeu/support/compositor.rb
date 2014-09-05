module Vedeu

  # Combines stored interface layout/geometry with an interface view/buffer
  # to create a single view to be sent to the terminal for output.
  class Compositor

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

    # Send the view to the terminal, then return an instance of Compositor.
    #
    # @return [Compositor]
    def render
      Terminal.output(view)

      self
    end

    private

    attr_reader :name

    # @api private
    # @return [String]
    def view
      if buffer
        Render.call(Interface.new(new_interface))

      else
        Clear.call(Interface.new(interface))

      end
    end

    # Combine the buffer attributes with the interface attributes, if the buffer
    # has no content, then the content of the interface will be used.
    #
    # @api private
    # @return [Hash]
    def new_interface
      combined = interface
      combined[:lines]  = buffer[:lines]
      combined[:colour] = buffer[:colour] unless buffer[:colour].nil? || buffer[:colour].empty?
      combined[:style]  = buffer[:style]  unless buffer[:style].nil?  || buffer[:style].empty?
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
  end
end
