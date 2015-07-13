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
          @y      = geometry.y
          @x      = geometry.x
          @width  = geometry.width
          @height = geometry.height
          @colour = interface.colour
          @clear ||= Array.new(@width) do |iy|
            Array.new(@height) do |ix|
              Vedeu::Char.new(value:    ' ',
                              colour:   @colour,
                              position: [@y + iy, @x + ix])
            end
          end
        end
      end

    end # NamedInterface

  end # Clear

end # Vedeu
