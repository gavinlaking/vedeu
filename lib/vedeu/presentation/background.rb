module Vedeu

  module Presentation

    module Colour

      module Background

        # When the background colour for the model exists, return it,
        # otherwise returns the parent background colour, or an empty
        # Vedeu::Colours::Background.
        #
        # @return [Vedeu::Colours::Background]
        def background
          @background ||= if colour
                            colour.background

                          elsif self.is_a?(Vedeu::Views::Char) && name
                            interface.colour.background

                          elsif parent
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
          @colour = Vedeu::Colours::Colour.coerce(
            background: Vedeu::Colours::Background.coerce(value),
            foreground: colour.foreground)
        end

      end # Background

    end # Colour

  end # Presentation

end # Vedeu
