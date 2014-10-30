module Vedeu

  # Combines stored interface layout/geometry with an interface view/buffer
  # to create a single view to be sent to the terminal for output.
  #
  # @api private
  class Compositor

    include Common

    # Convenience method to initialize a new Compositor and call its {#render}
    # method.
    #
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
      Terminal.output(view, cursor)
    end

    private

    attr_reader :name

    # Renders the cursor into the currently focussed interface. May be hidden.
    #
    # @return [String]
    def cursor
      Interface.new(Interfaces.find(Focus.current)).cursor.to_s
    end

    # Provides the latest view to the terminal.
    #
    # When there is new content to be shown, we first clear the area occupied by
    # the previous content, then clear the area for the new content, and then
    # finally render the new content.
    #
    # @return [String]
    def view
      if latest?
        Clear.call(Interface.new(previous)) if previous?

        Clear.call(Interface.new(new_interface))

        Render.call(Interface.new(new_interface))

      else
        Clear.call(Interface.new(interface))

        ''

      end
    end

    # Combine the buffer attributes with the interface attributes. Buffer
    # presentation attributes will override interface defaults.
    #
    # @return [Hash]
    def new_interface
      combined = interface

      if defined_value?(latest[:geometry])
        latest[:geometry].each do |k, v|
          combined[:geometry][k] = v if defined_value?(k)
        end
      end

      combined[:lines]  = latest[:lines]
      combined[:colour] = latest[:colour] if defined_value?(latest[:colour])
      combined[:style]  = latest[:style]  if defined_value?(latest[:style])
      combined
    end

    # Returns a boolean indicating whether there is new content available to be
    # displayed.
    #
    # @return [Boolean]
    def latest?
      !!(latest)
    end

    # Returns the attributes of the latest buffer (view).
    #
    # @return [Hash|NilClass]
    def latest
      @_buffer ||= Buffers.latest(name)
    end

    # Returns a boolean indicating whether there is a previous buffer available.
    #
    # @return [Boolean]
    def previous?
      !!(previous)
    end

    # Returns the attributes of the previous buffer if available.
    #
    # @return [Hash|NilClass]
    def previous
      @_previous ||= Buffers.previous(name)
    end

    # Returns the attributes of the named interface (layout).
    #
    # @return [Hash]
    def interface
      @_interface ||= Interfaces.find(name)
    end

  end # Compositor

end # Vedeu
