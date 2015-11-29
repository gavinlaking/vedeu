module Vedeu

  module Presentation

    # Provides style related presentation behaviour.
    #
    module Styles

      # When the style for the model exists, return it, otherwise
      # returns the parent style, or an empty
      # {Vedeu::Presentation::Style}.
      #
      # @return [Vedeu::Presentation::Style]
      def style
        @style ||= if attributes[:style]
                     Vedeu::Presentation::Style.coerce(attributes[:style])

                   elsif self.is_a?(Vedeu::Views::Char) && name
                     Vedeu::Presentation::Style.coerce(interface.style)

                   elsif parent
                     Vedeu::Presentation::Style.coerce(parent.style)

                   else
                     Vedeu::Presentation::Style.new

                   end
      end

      # Allows the setting of the style by coercing the given value
      # into a {Vedeu::Presentation::Style}.
      #
      # @return [Vedeu::Presentation::Style]
      def style=(value)
        @style = Vedeu::Presentation::Style.coerce(value)
      end

    end # Style

  end # Presentation

end # Vedeu
