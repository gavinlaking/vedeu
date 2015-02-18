module Vedeu

  # Sends the interface to the terminal or output device.
  #
  class Output

    # Writes content (the provided interface object with associated lines,
    # streams, colours and styles) to the area defined by the interface.
    #
    # @return [Array|String]
    # @see #initialize
    def self.render(interface)
      new(interface).render
    end

    # Return a new instance of Output.
    #
    # @param interface [Interface]
    # @return [Output]
    def initialize(interface)
      @interface = interface
    end

    # Send the view to the terminal.
    #
    # @return [Array]
    def render
      Vedeu.trigger(:_output_, virtual_view)

      Terminal.output(view, interface.cursor.to_s)
    end

    private

    attr_reader :interface

    # For each visible line of the interface, set the foreground and background
    # colours to those specified when the interface was defined, then starting
    # write space characters over the area which the interface occupies.
    #
    # @return [String]
    def clear
      Vedeu.log("Clearing view: '#{interface.name}'")

      interface.height.times.inject([interface.colour]) do |line, index|
        line << interface.origin(index) { ' ' * interface.width }
      end.join
    end

    # Produces a single string which contains all content and escape sequences
    # required to render this interface in the terminal window.
    #
    # @return [String]
    def view
      out = [ clear ]

      Vedeu.log("Rendering view: '#{interface.name}'")

      viewport.each_with_index do |line, index|
        out << interface.origin(index)
        out << line.join
      end

      out.join
    end

    def viewport
      @_viewport ||= Vedeu::Viewport.new(interface).render
    end

    # omg!
    def virtual_clear
      out = []
      interface.height.times do |hi|
        row = []
        interface.width.times do |wi|
          v   = interface.raw_origin(hi)
          pos = Vedeu::Position.new(v.first, (v.last + wi))
          row << Vedeu::Char.new(' ', nil, interface.colour, nil, pos)
        end
        out << row
      end
      out
    end

    # omg!
    def virtual_view
      out = [ virtual_clear ]

      viewport.each_with_index do |line, line_index|
        row = []
        line.each_with_index do |char, char_index|
          v   = interface.raw_origin(line_index)
          pos = Vedeu::Position.new(v.first, (v.last + char_index))
          row << if char.is_a?(Vedeu::Char)
            char.position=(pos)
            char

          else
            Vedeu::Char.new(char, nil, interface.colour, nil, pos)

          end
        end
        out << row
      end
      out
    end

  end # Output

end # Vedeu
