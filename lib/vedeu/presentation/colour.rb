# frozen_string_literal: true

module Vedeu

  module Presentation

    # Provides colour related presentation behaviour.
    #
    # @api private
    #
    module Colour

      include Vedeu::Presentation::Parent

      # When the background colour for the model exists, return it,
      # otherwise returns the parent background colour, or an empty
      # Vedeu::Colours::Background.
      #
      # @return [Vedeu::Colours::Background]
      def background
        @background ||= if colour && present?(colour.background)
                          colour.background

                        elsif named_colour?
                          named_colour.background

                        elsif parent? && present?(parent.background)
                          parent.background

                        else
                          Vedeu::Colours::Background.new

                        end
      end

      # Allows the setting of the background colour by coercing the
      # given value into a Vedeu::Colours::Background colour.
      #
      # @return [Vedeu::Colours::Background]
      def background=(value)
        @background = colour.background = value
        @_colour = @colour = colour
      end

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

      # When the foreground colour for the model exists, return it,
      # otherwise returns the parent foreground colour, or an empty
      # Vedeu::Colours::Foreground.
      #
      # @return [Vedeu::Colours::Foreground]
      def foreground
        @foreground ||= if colour && present?(colour.foreground)
                          colour.foreground

                        elsif named_colour?
                          named_colour.foreground

                        elsif parent? && present?(parent.foreground)
                          parent.foreground

                        else
                          Vedeu::Colours::Foreground.new

                        end
      end

      # Allows the setting of the foreground colour by coercing the
      # given value into a Vedeu::Colours::Foreground colour.
      #
      # @return [Vedeu::Colours::Foreground]
      def foreground=(value)
        @foreground = colour.foreground = value
        @_colour = @colour = colour
      end

      private

      # @macro interface_by_name
      def interface
        Vedeu.interfaces.by_name(name)
      end

      # @return [Vedeu::Colours::Colour]
      def named_colour
        interface.colour
      end

      # @return [Boolean]
      def named_colour?
        return false if is_a?(Vedeu::Interfaces::Interface)

        present?(name) && Vedeu.interfaces.registered?(name)
      end

      # @return [Vedeu::Colours::Colour]
      def parent_colour
        parent.colour
      end

      # @return [Boolean]
      def parent_colour?
        parent? && parent.respond_to?(:colour?)
      end

      # Renders the colour attributes of the receiver and yields (to
      # then render the styles).
      #
      # @macro param_block
      # @return [String]
      def render_colour(&block)
        "#{colour}#{yield}"
      end

    end # Colour

  end # Presentation

end # Vedeu
