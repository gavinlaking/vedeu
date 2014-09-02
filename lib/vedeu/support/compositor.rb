require 'pry'

module Vedeu

  # Combines stored interface layout/geometry with an interface view/buffer
  # to create a single interface.
  class Compositor

    # @param name [String] The name of the interface and buffer to combine into
    #   a view.
    # @return [Compositor]
    def self.render(name)
      new(name).render
    end

    # Initialize a new Compositor.
    #
    # @param name [String] The name of the interface and buffer to combine into
    #   a view.
    # @return [Compositor]
    def initialize(name)
      @name = name
    end

    # Send the view to the terminal to be displayed on the screen, then return
    # an instance of the compositor.
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
        #Interface.new(new_interface).render

        Vedeu.log(new_interface.inspect, true)

        Render.call(Interface.new(new_interface))
      else
        #Interface.new(interface).clear
        Clear.call(Interface.new(interface))
      end
    end

    # Combine the buffer attributes with the interface attributes, if the buffer
    # has no content, then the content of the interface will be used.
    #
    # @api private
    # @return [Hash]
    def new_interface
      buffer.merge(interface) do |attribute, view, layout|
        if attribute == :lines && view.empty?
          layout

        else
          view

        end
      end
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
