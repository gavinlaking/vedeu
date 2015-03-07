module Vedeu

  # Provides information about the content within an interface or view.
  #
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

    # @param interface [Vedeu::Interface]
    # @return [Vedeu::ContentGeometry]
    def initialize(interface)
      @interface = interface
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

    # @!attribute [r] interface
    # @return [Vedeu::Interface]
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
