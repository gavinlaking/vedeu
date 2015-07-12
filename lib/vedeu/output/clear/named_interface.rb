module Vedeu

  module Clear

    # Clear the named interface.
    #
    # @api private
    class NamedInterface

      class << self

        # @return [void]
        # @see #initialize
        def render(name)
          new(name).render
        end
        alias_method :clear_by_name, :render
        alias_method :by_name, :render

      end # Eigenclass

      # Return a new instance of Vedeu::Clear::NamedInterface.
      #
      # @param name [String] The name of the interface to clear.
      # @return [Vedeu::Clear::NamedInterface]
      def initialize(name)
        @name = name
      end

      # @return [void]
      def render
        return [] unless interface.visible?

        output
      end

      protected

      # @!attribute [r] name
      # @return [String]
      attr_reader :name

      private

      # @see Vedeu::Geometries#by_name
      def geometry
        @geometry ||= Vedeu.geometries.by_name(name)
      end

      # @see Vedeu::Interfaces#by_name
      def interface
        @interface ||= Vedeu.interfaces.by_name(name)
      end

      # For each visible line of the interface, set the foreground and
      # background colours to those specified when the interface was defined,
      # then starting write space characters over the area which the interface
      # occupies.
      #
      # @return [Array<Array<Vedeu::Char>>]
      def output
        Vedeu.timer("Clearing: #{name}") do
          @clear ||= Array.new(height) do |iy|
            Array.new(width) do |ix|
              Vedeu::Char.new(value:    ' ',
                              colour:   colour,
                              position: Vedeu::Position[y + iy, x + ix])
            end
          end
        end
      end

      def colour
        @colour ||= interface.colour
      end

      def height
        @height ||= geometry.height
      end

      def width
        @width ||= geometry.width
      end

      # @return [Fixnum]
      def x
        @x ||= geometry.x
      end

      # @return [Fixnum]
      def y
        @y ||= geometry.y
      end

    end # NamedInterface

  end # Clear

end # Vedeu
