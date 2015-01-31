module Vedeu

  class ContentGeometry

    extend Forwardable

    def_delegators :interface, :content?, :content

    def initialize(interface)
      @interface = interface
    end

    # Returns the height of the content, or when no content, the visible height
    # of the interface.
    #
    # @return [Fixnum]
    def height
      if content?
        [content.size, interface.height].max

      else
        interface.height

      end
    end

    # Returns the width of the content, or when no content, the visible width of
    # the interface.
    #
    # @return [Fixnum]
    def width
      if content?
        [maximum_line_length, interface.width].max

      else
        interface.width

      end
    end

    private

    attr_reader :interface

    # Returns the character length of the longest line for this interface.
    #
    # @return [Fixnum]
    def maximum_line_length
      content.map { |line| line.size }.max
    end

  end # ContentGeometry

end # Vedeu
