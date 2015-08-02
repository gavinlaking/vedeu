module Vedeu

  module Presentation

    # Provides colour related presentation behaviour.
    #
    module Colour

      # When the background colour for the model exists, return it, otherwise
      # returns the parent background colour, or an empty Vedeu::Background.
      #
      # @return [Vedeu::Background]
      def background
        @background ||= if colour
                          colour.background

                        elsif parent
                          parent.background

                        else
                          Vedeu::Background.new

                        end
      end

      # Allows the setting of the background colour by coercing the given value
      # into a Vedeu::Background colour.
      #
      # @return [Vedeu::Background]
      def background=(value)
        @colour = Vedeu::Colour.coerce(
          background: Vedeu::Background.coerce(value),
          foreground: colour.foreground)
      end

      # @return [Vedeu::Colour]
      def colour
        @colour ||= if attributes[:colour]
                      Vedeu::Colour.coerce(attributes[:colour])

                    elsif parent
                      Vedeu::Colour.coerce(parent.colour)

                    else
                      Vedeu::Colour.new

                    end
      end

      # Allows the setting of the model's colour by coercing the given value
      # into a Vedeu::Colour.
      #
      # @return [Vedeu::Colour]
      def colour=(value)
        @colour = Vedeu::Colour.coerce(value)
      end

      # When the foreground colour for the model exists, return it, otherwise
      # returns the parent foreground colour, or an empty Vedeu::Foreground.
      #
      # @return [Vedeu::Foreground]
      def foreground
        @foreground ||= if colour
                          colour.foreground

                        elsif parent
                          parent.foreground

                        else
                          Vedeu::Foreground.new

                        end
      end

      # Allows the setting of the foreground colour by coercing the given value
      # into a Vedeu::Foreground colour.
      #
      # @return [Vedeu::Foreground]
      def foreground=(value)
        @colour = Vedeu::Colour.coerce(
          background: colour.background,
          foreground: Vedeu::Foreground.coerce(value))
      end

    end # Colour

  end # Presentation

end # Vedeu
