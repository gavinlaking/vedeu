module Vedeu

  module Presentation

    # Provides style related presentation behaviour.
    #
    module Style

      # When the style for the model exists, return it, otherwise returns the
      # parent style, or an empty Vedeu::Style.
      #
      # @return [Vedeu::Style]
      def style
        @style ||= if attributes[:style]
                     Vedeu::Style.coerce(attributes[:style])

                   elsif parent
                     Vedeu::Style.coerce(parent.style)

                   else
                     Vedeu::Style.new

                   end
      end

      # Allows the setting of the style by coercing the given value into a
      # Vedeu::Style.
      #
      # @return [Vedeu::Style]
      def style=(value)
        @style = Vedeu::Style.coerce(value)
      end

    end # Style

  end # Presentation

end # Vedeu
