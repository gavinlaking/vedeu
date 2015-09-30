module Vedeu

  module Clear

    # Clear the named interface.
    #
    class Interface

      class << self

        # Clear the interface with the given name.
        #
        # @example
        #   Vedeu.clear_by_name(name)
        #
        # @return [Array<Array<Vedeu::Views::Char>>]
        # @see #initialize
        def render(name)
          new(name).render
        end
        alias_method :clear_by_name, :render
        alias_method :by_name, :render

      end # Eigenclass

      # Return a new instance of Vedeu::Clear::Interface.
      #
      # @param name [String] The name of the interface to clear.
      # @return [Vedeu::Clear::Interface]
      def initialize(name)
        @name = name
      end

      # @return [Array<Array<Vedeu::Views::Char>>]
      def render
        Vedeu::Output::Output.render(output)
      end

      protected

      # @!attribute [r] name
      # @return [String]
      attr_reader :name

      private

      # @see Vedeu::Geometry::Repository#by_name
      def geometry
        @geometry ||= Vedeu.geometries.by_name(name)
      end

      # @see Vedeu::Models::Interfaces#by_name
      def interface
        @interface ||= Vedeu.interfaces.by_name(name)
      end

      # For each visible line of the interface, set the foreground and
      # background colours to those specified when the interface was
      # defined, then starting write space characters over the area
      # which the interface occupies.
      #
      # @return [Array<Array<Vedeu::Views::Char>>]
      def output
        Vedeu.timer("Clearing: '#{name}'") do
          @y      = geometry.y
          @x      = geometry.x
          @width  = geometry.width
          @height = geometry.height
          @colour = interface.colour

          @clear ||= Array.new(@height) do |iy|
            Array.new(@width) do |ix|
              Vedeu::Views::Char.new(value:    ' ',
                                     colour:   @colour,
                                     position: [@y + iy, @x + ix])
            end
          end
        end
      end

    end # Interface

  end # Clear

  # @!method clear_by_name
  #   @see Vedeu::Clear::Interface.render
  def_delegators Vedeu::Clear::Interface, :clear_by_name

end # Vedeu
