require 'vedeu/support/common'

module Vedeu

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
        change_geometry(content)

        interface[:lines] = content[:lines]
        change_colour(content)
        change_style(content)

        Output.render(Interface.new(interface))
      end
    end

    private

    attr_reader :interface, :buffer

    def change_colour(content)
      interface[:colour] = content[:colour] if defined_value?(content[:colour])
    end

    def change_geometry(content)
      content[:geometry].each do |k, v|
        interface[:geometry][k] = v if defined_value?(k)
      end if defined_value?(content[:geometry])
    end

    def change_style(content)
      interface[:style] = content[:style] if defined_value?(content[:style])
    end

  end # Compositor

end # Vedeu
