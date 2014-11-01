module Vedeu

  # Combines stored interface layout/geometry with an interface view/buffer
  # to create a single view to be sent to the terminal for output.
  #
  # @api private
  class Compositor

    include Common
    extend Forwardable

    def_delegators Buffers, :latest?, :latest, :previous?, :previous

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
      if latest?(name)
        Clear.call(Interface.new(previous(name))) if previous?(name)

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
      latest_attrs = latest(name)

      if defined_value?(latest_attrs[:geometry])
        latest_attrs[:geometry].each do |k, v|
          combined[:geometry][k] = v if defined_value?(k)
        end
      end

      combined[:lines]  = latest_attrs[:lines]
      combined[:colour] = latest_attrs[:colour] if defined_value?(latest_attrs[:colour])
      combined[:style]  = latest_attrs[:style]  if defined_value?(latest_attrs[:style])
      combined
    end

    # Returns the attributes of the named interface (layout).
    #
    # @return [Hash]
    def interface
      @_interface ||= Interfaces.find(name)
    end

  end # Compositor

end # Vedeu
