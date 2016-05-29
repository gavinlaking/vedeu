# frozen_string_literal: true

module Vedeu

  module Interfaces

    # Clear the content of the named interface.
    #
    # @api private
    #
    class ClearContent

      include Vedeu::Common
      extend Forwardable

      def_delegators :geometry,
                     :bordered_height,
                     :bordered_width,
                     :bx,
                     :by

      def_delegators :interface,
                     :colour

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
        @_chars ||= (' ' * bordered_width)
      end

      # @macro geometry_by_name
      def geometry
        @_geometry ||= Vedeu.geometries.by_name(name)
      end

      # @macro interface_by_name
      def interface
        @_interface ||= Vedeu.interfaces.by_name(name)
      end

      # @param iy [Fixnum]
      # @return [String]
      def optimised_line(iy)
        Vedeu::Geometries::Position.new(by + iy, bx).to_s + colour.to_s + chars
      end

      # @return [String]
      def optimised_output
        Vedeu.timer("Optimised clearing content: '#{name}'") do
          Array.new(bordered_height) do |iy|
            optimised_line(iy)
          end.join + Vedeu::Geometries::Position.new(by, bx)
        end
      end

      # For each visible line of the interface, set the foreground and
      # background colours to those specified when the interface was
      # defined, then starting write space characters over the area
      # which the interface occupies.
      #
      # @return [Array<Array<Vedeu::Cells::Clear>>]
      def output
        Vedeu.timer("Clearing content: '#{name}'") do
          @_clear ||= Vedeu::Buffers::Clear.new(height: bordered_height,
                                                name:   name,
                                                width:  bordered_width).buffer
        end
      end

    end # ClearContent

  end # Interfaces

  # @api public
  # @!method clear_content_by_name
  #   @see Vedeu::Interfaces.ClearContent.clear_content_by_name
  def_delegators Vedeu::Interfaces::ClearContent,
                 :clear_content_by_name

end # Vedeu
