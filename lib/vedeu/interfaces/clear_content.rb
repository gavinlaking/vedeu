# frozen_string_literal: true

module Vedeu

  module Interfaces

    # Clear the content of the named interface.
    #
    # @api private
    #
    class ClearContent

      include Vedeu::Common

      class << self

        # {include:file:docs/dsl/by_method/clear_content_by_name.md}
        # @return [Vedeu::Buffers::View]
        # @see #initialize
        def clear_content_by_name(name = Vedeu.focus)
          new(name).render
        end

      end # Eigenclass

      # Return a new instance of Vedeu::Interfaces::ClearContent.
      #
      # @macro param_name
      # @return [Vedeu::Interfaces::ClearContent]
      def initialize(name = Vedeu.focus)
        @name = present?(name) ? name : Vedeu.focus
      end

      # @return [Vedeu::Buffers::View]
      def render
        if Vedeu.ready?
          Vedeu.direct_write(optimised_output)

          Vedeu.buffer_update(output)
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

      # @macro geometry_by_name
      def geometry
        @_geometry ||= Vedeu.geometries.by_name(name)
      end

      # @return [Fixnum]
      def height
        @_height ||= geometry.bordered_height
      end

      # @macro interface_by_name
      def interface
        Vedeu.interfaces.by_name(name)
      end

      # @return [String]
      def optimised_output
        Vedeu.timer("Optimised clearing content: '#{name}'") do
          Array.new(height) do |iy|
            [
              Vedeu::Geometries::Position.new(y + iy, x).to_s,
              colour.to_s,
              chars,
            ].join
          end.join + Vedeu::Geometries::Position.new(y, x).to_s
        end
      end

      # For each visible line of the interface, set the foreground and
      # background colours to those specified when the interface was
      # defined, then starting write space characters over the area
      # which the interface occupies.
      #
      # @return [Array<Array<Vedeu::Cells::Char>>]
      def output
        Vedeu.timer("Clearing content: '#{name}'") do
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

      # @return [Fixnum]
      def width
        @_width ||= geometry.bordered_width
      end

      # @return [Fixnum]
      def y
        @_y ||= geometry.by
      end

      # @return [Fixnum]
      def x
        @_x ||= geometry.bx
      end

    end # ClearContent

  end # Interfaces

  # @api public
  # @!method clear_content_by_name
  #   @see Vedeu::Interfaces.ClearContent.clear_content_by_name
  def_delegators Vedeu::Interfaces::ClearContent,
                 :clear_content_by_name

end # Vedeu
