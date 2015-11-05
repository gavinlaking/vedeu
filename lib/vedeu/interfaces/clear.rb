module Vedeu

  module Interfaces

    # Clear the named interface.
    #
    class Clear

      include Vedeu::Common

      class << self

        # Clear the interface with the given name.
        #
        # @example
        #   Vedeu.trigger(:_clear_view_, name)
        #   Vedeu.clear_by_name(name)
        #
        # @return [Array<Array<Vedeu::Views::Char>>]
        # @see #initialize
        def render(name = Vedeu.focus)
          name || Vedeu.focus

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
        def clear_content_by_name(name = Vedeu.focus)
          name || Vedeu.focus

          new(name, content_only: true, direct: true).render
        end

      end # Eigenclass

      # Return a new instance of Vedeu::Interfaces::Clear.
      #
      # @param name [String|Symbol] The name of the interface to
      #   clear.
      # @param options [Hash]
      # @option options content_only [Boolean] Only clear the content
      #   not the border as well. Defaults to false.
      # @option options direct [Boolean] Write the content directly
      #   to the terminal using a faster mechanism. The virtual buffer
      #   will still be updated. This improves the refresh time for
      #   Vedeu as we will not be building a grid of
      #   {Vedeu::Views::Char} objects.
      # @return [Vedeu::Interfaces::Clear]
      def initialize(name, options = {})
        @name    = present?(name) ? name : Vedeu.focus
        @options = options
      end

      # @return [Array<Array<Vedeu::Views::Char>>]
      def render
        if direct?
          Vedeu.direct_write(optimised_output)

          Vedeu::Terminal::Buffer.update(output)

        else
          Vedeu.render_output(output)

        end
      end

      protected

      # @!attribute [r] name
      # @return [String]
      attr_reader :name

      private

      # Returns the border for the interface.
      #
      # @return (see Vedeu::Borders::Repository#by_name)
      def border
        @border ||= Vedeu.borders.by_name(name)
      end

      # @return [String] A string of blank characters.
      def chars
        @chars ||= (' ' * width).freeze
      end

      # @return [Vedeu::Colours::Colour]
      def colour
        @colour ||= interface.colour
      end

      # @return [Boolean]
      def content_only?
        options[:content_only]
      end

      # @return [Hash<Symbol => Boolean>]
      def defaults
        {
          content_only: false,
          direct:       false,
        }
      end

      # @return [Boolean]
      def direct?
        options[:direct]
      end

      # Returns the geometry for the interface.
      #
      # @return (see Vedeu::Geometry::Repository#by_name)
      def geometry
        @geometry ||= Vedeu.geometries.by_name(name)
      end

      # @return [Fixnum]
      def height
        @height ||= if content_only?
                      border.height

                    else
                      geometry.height

                    end
      end

      # Returns the interface by name.
      #
      # @return (see Vedeu::Interfaces::Repository#by_name)
      def interface
        @interface ||= Vedeu.interfaces.by_name(name)
      end

      # @return [Hash<Symbol => Boolean>]
      def options
        defaults.merge!(@options)
      end

      # @return [String]
      def optimised_output
        Vedeu.timer("Optimised clearing #{clearing}: '#{name}'".freeze) do
          height.times.map do |iy|
            Vedeu::Geometry::Position.new(y + iy, x).to_s + colour.to_s + chars
          end.join + Vedeu::Geometry::Position.new(y, x).to_s
        end
      end

      # For each visible line of the interface, set the foreground and
      # background colours to those specified when the interface was
      # defined, then starting write space characters over the area
      # which the interface occupies.
      #
      # @return [Array<Array<Vedeu::Views::Char>>]
      def output
        Vedeu.timer("Clearing #{clearing}: '#{name}'".freeze) do
          @clear ||= Array.new(height) do |iy|
            Array.new(width) do |ix|
              Vedeu::Views::Char.new(value:    ' '.freeze,
                                     colour:   colour,
                                     position: [y + iy, x + ix])
            end
          end
        end
      end

      # @return [String]
      def clearing
        @clearing ||= if content_only?
                        'content'.freeze

                      else
                        'interface'.freeze

                      end
      end

      # @return [Fixnum]
      def width
        @width ||= if content_only?
                     border.width

                   else
                     geometry.width

                   end
      end

      # @return [Fixnum]
      def y
        @y ||= if content_only?
                 border.by

               else
                 geometry.y

               end
      end

      # @return [Fixnum]
      def x
        @x ||= if content_only?
                 border.bx

               else
                 geometry.x

               end
      end

    end # Clear

  end # Interfaces

  # @!method clear_by_name
  #   @see Vedeu::Interfaces::Clear.clear_by_name
  def_delegators Vedeu::Interfaces::Clear,
                 :clear_by_name

  # @!method clear_content_by_name
  #   @see Vedeu::Interfaces.Clear.clear_content_by_name
  def_delegators Vedeu::Interfaces::Clear,
                 :clear_content_by_name

  # :nocov:

  # See {file:docs/events/visibility.md#\_clear_view_}
  Vedeu.bind(:_clear_view_) { |name| Vedeu.clear_by_name(name) }

  # See {file:docs/events/visibility.md#\_clear_view_content_}
  Vedeu.bind(:_clear_view_content_) do |name|
    Vedeu.clear_content_by_name(name)
  end

  # :nocov:

end # Vedeu
