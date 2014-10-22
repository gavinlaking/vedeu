module Vedeu

  module API

    # Provides colour and style helpers for use in the {API::Interface},
    # {API::Line} and {API::Stream} classes.
    #
    # @api public
    module Helpers

      include Common

      # Define the background colour for an interface, line, or a stream. When
      # called with a block, will create a new stream with the background colour
      # specified; see {Vedeu::API::Stream} for directives which are valid
      # within the block. When the block terminates, the background will return
      # to that of the parent.
      #
      # @param value [String]
      # @param block [Proc]
      #
      # @example
      #   interface 'my_interface' do
      #     background '#0022ff'
      #     ...
      #
      #   line do
      #     background '#0022ff'
      #     ...
      #
      #   stream do
      #     background '#0022ff'
      #     ...
      #
      #   foreground('#0022ff') { 'This will be blue.' }
      #
      # @raise [InvalidSyntax] When the value is not defined.
      # @return [Hash]
      def background(value = '', &block)
        unless defined_value?(value)
          fail InvalidSyntax, '`background` requires a value.'
        end

        if block_given?
          attributes[:streams] << API::Stream
            .build({ colour: { background: value },
                     parent: self.view_attributes }, &block)

        else
          attributes[:colour].merge!({ background: value })

        end
      end

      # Define either or both foreground and background colours for an
      # interface, line or a stream.
      #
      # @param values [Hash]
      #
      # @example
      #   interface 'my_interface' do
      #     colour background: '#000000', foreground: '#ffffff'
      #     ...
      #
      #   line do
      #     colour background: '#000000', foreground: '#ffffff'
      #     ...
      #
      #   stream do
      #     colour background: '#000000', foreground: '#ffffff'
      #     ...
      #
      # @raise [InvalidSyntax] When the values parameter does not contain
      #   required keys.
      # @return [Hash]
      def colour(values)
        unless values.key?(:foreground) || values.key?(:background)
          fail InvalidSyntax, '#colour expects a Hash containing ' \
            ':foreground or :background or both.'
        end

        attributes[:colour] = values
      end

      # Define the foreground colour for an interface, line, or a stream. When
      # called with a block, will create a new stream with the foreground colour
      # specified; see {Vedeu::API::Stream} for directives which are valid
      # within the block. When the block terminates, the foreground will return
      # to that of the parent.
      #
      # @param value [String]
      # @param block [Proc]
      #
      # @example
      #   interface 'my_interface' do
      #     foreground '#0022ff'
      #     ...
      #
      #   line do
      #     foreground '#0022ff'
      #     ...
      #
      #   stream do
      #     foreground '#0022ff'
      #     ...
      #
      #   foreground('#0022ff') { 'This will be blue.' }
      #
      # @raise [InvalidSyntax] When the value is not defined.
      # @return [Hash]
      def foreground(value = '')
        unless defined_value?(value)
          fail InvalidSyntax, '`foreground` requires a value.'
        end

        if block_given?
          attributes[:streams] << API::Stream
            .build({ colour: { foreground: value },
                     parent: self.view_attributes }, &block)

        else
          attributes[:colour].merge!({ foreground: value })

        end
      end

      # Define a style or styles for an interface, line or a stream.
      #
      # @param values [Array|String]
      # @param block  [Proc]
      #
      # @example
      #   interface 'my_interface' do
      #     style 'normal'
      #     ...
      #
      #   line do
      #     style ['bold', 'underline']
      #     ...
      #
      #   stream do
      #     style 'blink'
      #     ...
      #
      # @return [Array]
      def style(values = [], &block)
        if block_given?
          attributes[:streams] << API::Stream
                                    .build({ style: Array(values) }, &block)

        else
          Array(values).each { |value| attributes[:style] << value }

        end
      end

    end # Helpers

  end # API

end # Vedeu
