module Vedeu

  module Presentation

    module Style

      # Returns the parent style when available or NilClass.
      #
      # @return [String|NilClass]
      def parent_style
        if parent
          parent.style

        else
          Vedeu::Style.new

        end
      end

      # @return [Vedeu::Style]
      def style
        @style ||= if attributes[:style]
                     Vedeu::Style.coerce(attributes[:style])

                   elsif parent_style
                     Vedeu::Style.coerce(parent_style)

                   else
                     Vedeu::Style.new

                   end
      end

      # @return [Vedeu::Style]
      def style=(value)
        @style = Vedeu::Style.coerce(value)
      end

    end # Style

  end # Presentation

end # Vedeu
