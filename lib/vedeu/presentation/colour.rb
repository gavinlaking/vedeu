# frozen_string_literal: true

module Vedeu

  module Presentation

    # Provides colour related presentation behaviour.
    #
    # @api private
    #
    module Colour

      include Vedeu::Repositories::Parent
      include Vedeu::Presentation::Colour::Background
      include Vedeu::Presentation::Colour::Foreground

      # @return [Vedeu::Colours::Colour]
      def colour
        @_colour ||= if colour?
                       Vedeu::Colours::Colour.coerce(@colour)

                     elsif parent_colour?
                       Vedeu::Colours::Colour.coerce(parent_colour)

                     elsif named_colour?
                       Vedeu::Colours::Colour.coerce(named_colour)

                     else
                       Vedeu::Colours::Colour.new

                     end
      end

      # Allows the setting of the model's colour by coercing the given
      # value into a Vedeu::Colours::Colour.
      #
      # @return [Vedeu::Colours::Colour]
      def colour=(value)
        @_colour = @colour = Vedeu::Colours::Colour.coerce(value)
      end

      # @return [Boolean]
      def colour?
        present?(@colour)
      end

      private

      # @return [Vedeu::Colours::Colour]
      def named_colour
        Vedeu.interfaces.by_name(name).colour
      end

      # @return [Boolean]
      def named_colour?
        return false if self.is_a?(Vedeu::Interfaces::Interface)

        present?(name) && Vedeu.interfaces.registered?(name)
      end

      # @return [Vedeu::Colours::Colour]
      def parent_colour
        parent.colour
      end

      # @return [Boolean]
      def parent_colour?
        present?(parent) && parent.respond_to?(:colour?)
      end

    end # Colour

  end # Presentation

end # Vedeu
