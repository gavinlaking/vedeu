module Vedeu

  module Clear

    # Clear the named interface.
    #
    class Interface

      class << self

        # Clear the interface with the given name.
        #
        # @example
        #   Vedeu.trigger(:_clear_view_, name)
        #   Vedeu.clear_by_name(name)
        #
        # @return [Array<Array<Vedeu::Views::Char>>]
        # @see #initialize
        def render(name)
          new(name).render
        end
        alias_method :clear_by_name, :render
        alias_method :by_name, :render

        # Clear the content of the interface with the given name.
        #
        # @example
        #   Vedeu.trigger(:_clear_view_content_, name)
        #   Vedeu.clear_content_by_name(name)
        #
        # @return [Array<Array<Vedeu::Views::Char>>]
        # @see #initialize
        def clear_content_by_name(name)
          new(name, content_only: true).render
        end

      end # Eigenclass

      # Return a new instance of Vedeu::Clear::Interface.
      #
      # @param name [String|Symbol] The name of the interface to
      #   clear.
      # @param options [Hash]
      # @option options content_only [Boolean] Only clear the content
      #   not the border as well. Defaults to false.
      # @return [Vedeu::Clear::Interface]
      def initialize(name, options = {})
        @name    = name
        @options = options
      end

      # @return [Array<Array<Vedeu::Views::Char>>]
      def render
        Vedeu.render_output(output)
      end

      protected

      # @!attribute [r] name
      # @return [String]
      attr_reader :name

      private

      # @see Vedeu::Borders::Repository#by_name
      def border
        @border ||= Vedeu.borders.by_name(name)
      end

      # @return [Vedeu::Colours::Colour]
      def colour
        interface.colour
      end

      # @return [Boolean]
      def content_only?
        options[:content_only]
      end

      # @return [Hash<Symbol => Boolean>]
      def defaults
        {
          content_only: false,
        }
      end

      # @see Vedeu::Geometry::Repository#by_name
      def geometry
        @geometry ||= Vedeu.geometries.by_name(name)
      end

      # @return [Fixnum]
      def height
        return border.height if content_only?

        geometry.height
      end

      # @see Vedeu::Interfaces::Repository#by_name
      def interface
        @interface ||= Vedeu.interfaces.by_name(name)
      end

      # @return [Hash<Symbol => Boolean>]
      def options
        defaults.merge!(@options)
      end

      # For each visible line of the interface, set the foreground and
      # background colours to those specified when the interface was
      # defined, then starting write space characters over the area
      # which the interface occupies.
      #
      # @return [Array<Array<Vedeu::Views::Char>>]
      def output
        Vedeu.timer("Clearing #{clearing}: '#{name}'".freeze) do
          @y      = y
          @x      = x
          @width  = width
          @height = height
          @colour = colour

          @clear ||= Array.new(@height) do |iy|
            Array.new(@width) do |ix|
              Vedeu::Views::Char.new(value:    ' '.freeze,
                                     colour:   @colour,
                                     position: [@y + iy, @x + ix])
            end
          end
        end
      end

      # @return [String]
      def clearing
        return 'content'.freeze if content_only?

        'interface'.freeze
      end

      # @return [Fixnum]
      def width
        return border.width if content_only?

        geometry.width
      end

      # @return [Fixnum]
      def y
        return border.by if content_only?

        geometry.y
      end

      # @return [Fixnum]
      def x
        return border.bx if content_only?

        geometry.x
      end

    end # Interface

  end # Clear

  # @!method clear_by_name
  #   @see Vedeu::Clear::Interface.render
  def_delegators Vedeu::Clear::Interface, :clear_by_name

  # @!method clear_content_by_name
  #   @see Vedeu::Clear::Interface.clear_content_by_name
  def_delegators Vedeu::Clear::Interface, :clear_content_by_name

  # See {file:docs/events/visibility.md#\_clear_view_}
  Vedeu.bind(:_clear_view_) { |name| Vedeu.clear_by_name(name) }

  # See {file:docs/events/visibility.md#\_clear_view_content_}
  Vedeu.bind(:_clear_view_content_) do |name|
    Vedeu.clear_content_by_name(name)
  end

end # Vedeu
