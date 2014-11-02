module Vedeu

  # Attempts to convert the provided interface object with associated lines,
  # streams, colours, styles, etc, into a single string containing all content
  # and escape sequences.
  #
  # @api private
  class Render

    # Create a new instance of Render with the provided {Vedeu::Interface} and
    # then convert the interface into a single string of content and escape
    # sequences.
    #
    # @param interface [Interface]
    # @return [String]
    def self.call(interface)
      new(interface).render
    end

    # Return a new instance of Render.
    #
    # @param interface [Interface]
    # @return [Render]
    def initialize(interface)
      @interface = interface
    end

    # Produces a single string which contains all content and escape sequences
    # required to render this interface to a position in the terminal window.
    #
    # @return [String]
    def render
      out = [ Clear.call(interface, { direct: false }) ]

      Vedeu.log("Rendering view: '#{interface.name}'")

      interface.viewport.each_with_index do |line, index|
        out << interface.origin(index)
        out << line.join
      end
      out.join
    end

    private

    attr_reader :interface

  end # Render

end # Vedeu
