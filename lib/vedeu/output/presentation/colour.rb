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

                        else
                          parent_background

                        end
      end

      # Allows the setting of the background colour by coercing the given value
      # into a Vedeu::Background colour.
      #
      # @return [Vedeu::Background]
      def background=(value)
        self.colour = Vedeu::Colour.coerce(
          background: Vedeu::Background.coerce(value),
          foreground: colour.foreground)
      end

      # @return [Vedeu::Colour]
      def colour
        @colour ||= if attributes[:colour]
                      Vedeu::Colour.coerce(attributes[:colour])

                    elsif parent_colour
                      Vedeu::Colour.coerce(parent_colour)

                    else
                      Vedeu::Colour.new

                    end
      end

      # Allows the setting of the model's colour by coercing the given value
      # into a Vedeu::Colour.
      #
      # @return [Vedeu::Colour]
      def colour=(value)
        @colour = attributes[:colour] = Vedeu::Colour.coerce(value)
      end

      # When the foreground colour for the model exists, return it, otherwise
      # returns the parent foreground colour, or an empty Vedeu::Foreground.
      #
      # @return [Vedeu::Foreground]
      def foreground
        @foreground ||= if colour
                          colour.foreground

                        else
                          parent_foreground

                        end
      end

      # Allows the setting of the foreground colour by coercing the given value
      # into a Vedeu::Foreground colour.
      #
      # @return [Vedeu::Foreground]
      def foreground=(value)
        self.colour = Vedeu::Colour.coerce(
          foreground: Vedeu::Foreground.coerce(value),
          background: colour.background)
      end

      # When a parent colour is available, returns the parent background colour,
      # otherwise an empty Vedeu::Background.
      #
      # @return [Vedeu::Background]
      def parent_background
        if parent_colour
          parent_colour.background

        else
          Vedeu::Background.new

        end
      end

      # Returns the parent colour when available or NilClass.
      #
      # @return [String|NilClass]
      def parent_colour
        parent.colour if parent
      end

      # When a parent colour is available, returns the parent foreground colour,
      # otherwise an empty Vedeu::Foreground.
      #
      # @return [Vedeu::Foreground]
      def parent_foreground
        if parent_colour
          parent_colour.foreground

        else
          Vedeu::Foreground.new

        end
      end

    end # Colour

  end # Presentation

end # Vedeu
