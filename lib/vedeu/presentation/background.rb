module Vedeu

  module Presentation

    module Colour

      # Provides the background colour when included in a class with
      # a colour attribute.
      #
      # @api private
      #
      module Background

        include Vedeu::Repositories::Parent

        # When the background colour for the model exists, return it,
        # otherwise returns the parent background colour, or an empty
        # Vedeu::Colours::Background.
        #
        # @return [Vedeu::Colours::Background]
        def background
          @background ||= if colour && present?(colour.background)
                            colour.background

                          elsif self.is_a?(Vedeu::Views::Char) && name
                            interface.colour.background

                          elsif parent && present?(parent.background)
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

      end # Background

    end # Colour

  end # Presentation

end # Vedeu
