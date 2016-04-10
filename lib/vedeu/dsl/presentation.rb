# frozen_string_literal: true

module Vedeu

  module DSL

    # Provides colour and style helpers for use in the
    # {Vedeu::Interfaces::DSL}, {Vedeu::DSL::Line} and
    # {Vedeu::DSL::Stream} classes.
    #
    module Presentation

      # Define the background colour for an interface, line, or a
      # stream. When called with a block, will create a new stream
      # with the background colour specified. When the block
      # terminates, the background will return to that of the parent.
      #
      # @note The last defined background colour for a particular
      #   interface, line or stream overrides previously defined
      #   entries in the same block.
      #
      # @param value [String] A HTML/CSS value.
      #
      # @example
      #   interface 'my_interface' do
      #     background '#0022ff' # /or/ (blue)
      #     bgcolor    '#22ff00' # /or/ (blue is overridden to green)
      #     bg         '#ff0022' #      (green is overridden to red)
      #     # ...
      #
      #     lines do
      #       background '#2200ff'
      #       # ...
      #
      #       stream do
      #         background '#22ff00'
      #         # ...
      #       end
      #     end
      #   end
      #
      # @return [String]
      def background(value = '')
        colour(background: Vedeu::Colours::Background.coerce(value))
      end
      alias bg background
      alias bgcolor background
      alias background= background
      alias bg= background
      alias bgcolor= background

      # @see Vedeu::DSL::Presentation#background
      def foreground(value = '')
        colour(foreground: Vedeu::Colours::Foreground.coerce(value))
      end
      alias fg foreground
      alias fgcolor foreground
      alias foreground= foreground
      alias fg= foreground
      alias fgcolor= foreground

      # Define either or both foreground and background colours for an
      # interface, line or a stream. At least one attribute is
      # required.
      #
      # @note Rejects invalid keys and empty/nil attributes. Also, the
      #   last defined colour for a particular interface, line or
      #   stream overrides previously defined entries in the same
      #   block.
      #
      # @param attrs [Hash<Symbol => void>]
      #   See {Vedeu::Colours::Colour}
      #
      # @example
      #   interface 'my_interface' do
      #     colour background: '#ff00ff', foreground: '#ffff00'
      #     # ...
      #
      #     lines do
      #       colour background: '#000000', foreground: '#ffffff'
      #       # ...
      #
      #       stream do
      #         colour background: '#000000', foreground: '#ffffff'
      #         # ...
      #       end
      #     end
      #   end
      #
      # @return [Vedeu::Colours::Colour]
      def colour(attrs = {})
        model.colour = Vedeu::Colours::Colour
                       .coerce(colour_attributes.merge!(attrs))
      end
      alias colour= colour

      # Instruct the view to not use wordwrapping. (Default)
      #
      # @return [Boolean]
      def no_wordwrap!
        wordwrap(false)
      end

      # Define a style or styles for an interface, line or a stream.
      #
      # @param value [Array<Symbol>|Array<String>|Symbol|String]
      #
      # @example
      #   interface 'my_interface' do
      #     style 'normal'
      #     # ...
      #   end
      #
      #   lines do
      #     style ['bold', 'underline']
      #     # ...
      #   end
      #
      #   stream do
      #     style 'blink'
      #     # ...
      #   end
      #
      # @return [Vedeu::Presentation::Style]
      def style(value)
        model.style = Vedeu::Presentation::Style.coerce(value)
      end
      alias style= style
      alias styles style
      alias styles= style

      # Specify whether the view should use wordwrapping (default).
      #
      # @param value [Boolean]
      # @return [Boolean]
      def wordwrap(value = true)
        model.wordwrap = Vedeu::Boolean.coerce(value)
      end
      alias wordwrap! wordwrap

      private

      # @return [Hash<Symbol => String>]
      def colour_attributes
        {
          background: model.colour.background,
          foreground: model.colour.foreground,
        }
      end

    end # Presentation

  end # DSL

end # Vedeu
