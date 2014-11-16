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
    # @return [String] The escape sequence to render the cursor as shown or
    #   hidden.
    def cursor
      Interface.new(Interfaces.find(Focus.current)).cursor.to_s
    end

    # Return the content for this buffer.
    #
    # - If we have new content (i.e. content on 'back') to be shown, we first
    #   clear the area occupied by the previous content, then clear the area for
    #   the new content, and then finally render the new content.
    # - If there is no new content (i.e. 'back' is empty), check the 'front'
    #   buffer and display that.
    # - If there is no new content, and the front buffer is empty, display the
    #   'previous' buffer.
    # - If the 'previous' buffer is empty, return an empty hash.
    #
    # @return [Hash]
    def view
      if buffer.content_for?(:back)
        Clear.call(compose(buffer.previous)) if buffer.content_for?(:previous)

        buffer.swap

        Render.call(compose(buffer.front))

      elsif buffer.content_for?(:front)
        Render.call(compose(buffer.front))

      elsif buffer.content_for?(:previous)
        Render.call(compose(buffer.previous))

      else
        Clear.call(compose({}), { direct: false })

      end
    end

    # Return a new instance of Interface built by combining the buffer content
    # attributes with the stored interface attributes.
    #
    # @return [Interface]
    def compose(content)
      if defined_value?(content[:geometry])
        content[:geometry].each do |k, v|
          interface[:geometry][k] = v if defined_value?(k)
        end
      end

      interface[:lines]  = content[:lines]
      interface[:colour] = content[:colour] if defined_value?(content[:colour])
      interface[:style]  = content[:style]  if defined_value?(content[:style])

      Interface.new(interface)
    end

    # Returns the attributes of the named interface (layout).
    #
    # @return [Hash]
    def interface
      @_interface ||= Interfaces.find(name)
    end

    # Return the named Buffer (view).
    #
    # @return [Buffer]
    def buffer
      @_buffer ||= Buffers.find(name)
    end

  end # Compositor

end # Vedeu
