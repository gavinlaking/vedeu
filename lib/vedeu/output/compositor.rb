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
    def self.compose(interface, buffer)
      new(interface, buffer).compose
    end

    # Initialize a new Compositor.
    #
    # @param interface [Hash] The attributes of the interface to be refreshed.
    # @param buffer [Hash] The atttributes of the buffer to refresh the
    #   interface with.
    # @return [Compositor]
    def initialize(interface, buffer)
      @interface = interface
      @buffer    = buffer
    end

    # Return a new instance of Interface built by combining the buffer content
    # attributes with the stored interface attributes.
    #
    # @return [Array<Hash>] The updated interface attributes.
    def compose
      buffer.content.each do |content|
        change_colour(content)
        change_content(content)
        change_geometry(content)
        change_style(content)

        Output.render(Interface.new(interface))
      end
    end

    private

    attr_reader :interface, :buffer

    # Changes the colour of the interface to that requested by the view.
    #
    # @note The change is currently not permanent.
    #
    # @param content []
    # @return []
    def change_colour(content)
      interface[:colour] = content[:colour] if defined_value?(content[:colour])
    end

    # Changes the content of the interface to that requested by the view.
    #
    # @note The change is currently not permanent.
    #
    # @param content []
    # @return []
    def change_content(content)
      interface[:lines] = content[:lines] if defined_value?(content[:lines])
    end

    # Changes the geometry of the interface to that requested by the view.
    #
    # @note The change is currently not permanent.
    #
    # @param content []
    # @return []
    def change_geometry(content)
      content[:geometry].each do |k, v|
        interface[:geometry][k] = v if defined_value?(k)
      end if defined_value?(content[:geometry])
    end

    # Changes the style of the interface to that requested by the view.
    #
    # @note The change is currently not permanent.
    #
    # @param content []
    # @return []
    def change_style(content)
      interface[:style] = content[:style] if defined_value?(content[:style])
    end

  end # Compositor

end # Vedeu
