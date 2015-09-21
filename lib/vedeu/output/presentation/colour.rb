module Vedeu

  module Presentation

    # Provides colour related presentation behaviour.
    #
    module Colour

      # When the background colour for the model exists, return it,
      # otherwise returns the parent background colour, or an empty
      # Vedeu::Colours::Background.
      #
      # @return [Vedeu::Colours::Background]
      def background
        @background ||= if colour
                          colour.background

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

      # @return [Vedeu::Colours::Colour]
      def colour
        @colour ||= if attributes[:colour]
                      Vedeu::Colours::Colour.coerce(attributes[:colour])

                    elsif parent
                      Vedeu::Colours::Colour.coerce(parent.colour)

                    else
                      Vedeu::Colours::Colour.new

                    end
      end

      # Allows the setting of the model's colour by coercing the given
      # value into a Vedeu::Colours::Colour.
      #
      # @return [Vedeu::Colours::Colour]
      def colour=(value)
        @colour = Vedeu::Colours::Colour.coerce(value)
      end

      # When the foreground colour for the model exists, return it,
      # otherwise returns the parent foreground colour, or an empty
      # Vedeu::Colours::Foreground.
      #
      # @return [Vedeu::Colours::Foreground]
      def foreground
        @foreground ||= if colour
                          colour.foreground

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
        @colour = Vedeu::Colours::Colour.coerce(
          background: colour.background,
          foreground: Vedeu::Colours::Foreground.coerce(value))
      end

    end # Colour

  end # Presentation

end # Vedeu
