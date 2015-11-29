module Vedeu

  module Presentation

    # Provides colour related presentation behaviour.
    #
    module Colour

      include Vedeu::Presentation::Colour::Background
      include Vedeu::Presentation::Colour::Foreground

      # @return [Vedeu::Colours::Colour]
      def colour
        @colour ||= if attributes[:colour]
                      Vedeu::Colours::Colour.coerce(attributes[:colour])

                    elsif self.is_a?(Vedeu::Views::Char) && name
                      Vedeu::Colours::Colour.coerce(interface.colour)

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
        @colour = attributes[:colour] = Vedeu::Colours::Colour.coerce(value)
      end

    end # Colour

  end # Presentation

end # Vedeu
