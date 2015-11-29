module Vedeu

  module Presentation

    module Colour

      module Foreground

        # When the foreground colour for the model exists, return it,
        # otherwise returns the parent foreground colour, or an empty
        # Vedeu::Colours::Foreground.
        #
        # @return [Vedeu::Colours::Foreground]
        def foreground
          @foreground ||= if colour
                            colour.foreground

                          elsif self.is_a?(Vedeu::Views::Char) && name
                            interface.colour.background

                          elsif parent
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
          @colour = attributes[:colour] = Vedeu::Colours::Colour.coerce(
            background: colour.background,
            foreground: Vedeu::Colours::Foreground.coerce(value))
        end

      end # Foreground

    end # Colour

  end # Presentation

end # Vedeu
