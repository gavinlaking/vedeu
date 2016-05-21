# frozen_string_literal: true

module Vedeu

  module Interfaces

    # Clear the named interface.
    #
    # @api private
    #
    class Clear

      include Vedeu::Common
      extend Forwardable

      def_delegators :geometry,
                     :height,
                     :width

      def_delegators :interface,
                     :colour

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

      end # Eigenclass

      # Return a new instance of Vedeu::Interfaces::Clear.
      #
      # @macro param_name
      # @return [Vedeu::Interfaces::Clear]
      def initialize(name = Vedeu.focus)
        @name = present?(name) ? name : Vedeu.focus
      end

      # @return [Array<Array<Vedeu::Cells::Char>>]
      def render
        Vedeu.render_output(output) if Vedeu.ready?
      end

      protected

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      private

      # @macro geometry_by_name
      def geometry
        @_geometry ||= Vedeu.geometries.by_name(name)
      end

      # @macro interface_by_name
      def interface
        @_interface ||= Vedeu.interfaces.by_name(name)
      end

      # For each visible line of the interface, set the foreground and
      # background colours to those specified when the interface was
      # defined, then starting write space characters over the area
      # which the interface occupies.
      #
      # @return [Array<Array<Vedeu::Cells::Char>>]
      def output
        Vedeu.timer("Clearing interface: '#{name}'") do
          @_clear ||= Array.new(height) do
            Array.new(width) do
              Vedeu::Cells::Clear.new(colour: colour, name: name)
            end
          end
        end
      end

    end # Clear

  end # Interfaces

  # @api public
  # @!method clear_by_name
  #   @see Vedeu::Interfaces::Clear.clear_by_name
  def_delegators Vedeu::Interfaces::Clear,
                 :clear_by_name

end # Vedeu
