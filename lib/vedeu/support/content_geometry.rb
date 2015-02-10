module Vedeu

  class ContentGeometry

    extend Forwardable

    def_delegators :interface,
      :lines?,
      :lines,
      :geometry

    def_delegators :geometry,
      :height,
      :width,
      :x,
      :y

    def initialize(interface)
      @interface = interface
    end

    # Returns log friendly output.
    #
    # @return [String]
    def inspect
      "<#{self.class.name} (y:#{y} x:#{x} yn:#{yn} xn:#{xn})>"
    end

    # Returns the height of the content, or when no content, the visible height
    # of the interface.
    #
    # @return [Fixnum]
    def yn
      [rows, height].max
    end

    # Returns the width of the content, or when no content, the visible width of
    # the interface.
    #
    # @return [Fixnum]
    def xn
      [columns, width].max
    end

    private

    attr_reader :interface

    # Returns the number of lines of content for this interface.
    #
    # @return [Fixnum]
    def rows
      return height unless lines?

      lines.size
    end

    # Returns the character length of the longest line for this interface.
    #
    # @return [Fixnum]
    def columns
      return width unless lines?

      lines.map { |line| line.size }.max
    end

  end # ContentGeometry

end # Vedeu
