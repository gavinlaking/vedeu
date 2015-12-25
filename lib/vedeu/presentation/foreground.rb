# frozen_string_literal: true

module Vedeu

  module Presentation

    module Colour

      # Provides the foreground colour when included in a class with
      # a colour attribute.
      #
      # @api private
      #
      module Foreground

        include Vedeu::Repositories::Parent

        # When the foreground colour for the model exists, return it,
        # otherwise returns the parent foreground colour, or an empty
        # Vedeu::Colours::Foreground.
        #
        # @return [Vedeu::Colours::Foreground]
        def foreground
          @foreground ||= if colour && present?(colour.foreground)
                            colour.foreground

                          elsif self.is_a?(Vedeu::Views::Char) && name
                            interface.colour.foreground

                          elsif parent && present?(parent.foreground)
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

      end # Foreground

    end # Colour

  end # Presentation

end # Vedeu
