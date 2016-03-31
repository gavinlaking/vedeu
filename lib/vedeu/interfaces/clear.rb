# frozen_string_literal: true

module Vedeu

  module Interfaces

    # Clear the named interface.
    #
    # @api private
    #
    class Clear

      include Vedeu::Common

      class << self

        # {include:file:docs/dsl/by_method/clear_by_name.md}
        # @return [Array<Array<Vedeu::Cells::Char>>]
        # @see #initialize
        def render(name = Vedeu.focus)
          name || Vedeu.focus

          new(name).render
        end
        alias clear_by_name render
        alias by_name render

        # {include:file:docs/dsl/by_method/clear_content_by_name.md}
        # @return [Array<Array<Vedeu::Cells::Char>>]
        # @see #initialize
        def clear_content_by_name(name = Vedeu.focus)
          name || Vedeu.focus

          new(name, content_only: true, direct: true).render
        end

      end # Eigenclass

      # Return a new instance of Vedeu::Interfaces::Clear.
      #
      # @macro param_name
      # @param options [Hash]
      # @option options content_only [Boolean] Only clear the content
      #   not the border as well. Defaults to false.
      # @option options direct [Boolean] Write the content directly
      #   to the terminal using a faster mechanism. The virtual buffer
      #   will still be updated. This improves the refresh time for
      #   Vedeu as we will not be building a grid of
      #   {Vedeu::Cells::Char} objects.
      # @return [Vedeu::Interfaces::Clear]
      def initialize(name, options = {})
        @name    = present?(name) ? name : Vedeu.focus
        @options = options
      end

      # @return [Array<Array<Vedeu::Cells::Char>>]
      def render
        if direct?
          Vedeu.direct_write(optimised_output)

          Vedeu.buffer_update(output)

        else
          Vedeu.render_output(output)

        end
      end

      protected

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      private

      # @return [String] A string of blank characters.
      def chars
        @_chars ||= (' ' * width)
      end

      # @return [Vedeu::Colours::Colour]
      def colour
        @_colour ||= interface.colour
      end

      # @return [Boolean]
      def content_only?
        options[:content_only]
      end

      # @macro defaults_method
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

      # @macro geometry_by_name
      def geometry
        @_geometry ||= Vedeu.geometries.by_name(name)
      end

      # @return [Fixnum]
      def height
        @_height ||= if content_only?
                       geometry.bordered_height

                     else
                       geometry.height

                     end
      end

      # @macro interface_by_name
      def interface
        Vedeu.interfaces.by_name(name)
      end

      # @return [Hash<Symbol => Boolean>]
      def options
        defaults.merge!(@options)
      end

      # @return [String]
      def optimised_output
        Vedeu.timer("Optimised clearing #{clearing}: '#{name}'") do
          Array.new(height) do |iy|
            [
              build_position(y + iy, x),
              colour.to_s,
              chars,
            ].join
          end.join + build_position(y, x)
        end
      end

      # For each visible line of the interface, set the foreground and
      # background colours to those specified when the interface was
      # defined, then starting write space characters over the area
      # which the interface occupies.
      #
      # @return [Array<Array<Vedeu::Cells::Char>>]
      def output
        Vedeu.timer("Clearing #{clearing}: '#{name}'") do
          @_clear ||= Array.new(height) do |iy|
            Array.new(width) do |ix|
              position = Vedeu::Geometries::Position.new((y + iy), (x + ix))
              Vedeu::Cells::Clear.new(colour:   colour,
                                      name:     name,
                                      position: position)
            end
          end
        end
      end

      # @return [String]
      def clearing
        @_clearing ||= if content_only?
                         'content'

                       else
                         'interface'

                       end
      end

      # @param pos_y [Fixnum]
      # @param pos_x [Fixnum]
      # @return [Vedeu::Geometries::Position]
      # @todo Not sure if #to_s is required here. (GL: 2015-11-30)
      def build_position(pos_y, pos_x)
        Vedeu::Geometries::Position.new(pos_y, pos_x).to_s
      end

      # @return [Fixnum]
      def width
        @_width ||= if content_only?
                      geometry.bordered_width

                    else
                      geometry.width

                    end
      end

      # @return [Fixnum]
      def y
        @_y ||= if content_only?
                  geometry.by

                else
                  geometry.y

                end
      end

      # @return [Fixnum]
      def x
        @_x ||= if content_only?
                  geometry.bx

                else
                  geometry.x

                end
      end

    end # Clear

  end # Interfaces

  # @api public
  # @!method clear_by_name
  #   @see Vedeu::Interfaces::Clear.clear_by_name
  # @api public
  # @!method clear_content_by_name
  #   @see Vedeu::Interfaces.Clear.clear_content_by_name
  def_delegators Vedeu::Interfaces::Clear,
                 :clear_by_name,
                 :clear_content_by_name

end # Vedeu
