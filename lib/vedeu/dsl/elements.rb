# frozen_string_literal: true

module Vedeu

  module DSL

    # @todo This documentation needs editing and is out of date.
    # (GL: 2015-12-25)
    #
    # Provides methods to be used to define views.
    #
    #   Vedeu.renders do
    #     view :my_interface do
    #       lines do
    #         background '#000000'
    #         foreground '#ffffff'
    #         line 'This is white text on a black background.'
    #         line 'Next is a blank line:'
    #         line ''
    #
    #         streams { stream 'We can define ' }
    #
    #         streams do
    #           foreground '#ff0000'
    #           stream 'parts of a line '
    #         end
    #
    #         streams { stream 'independently using ' }
    #
    #         streams do
    #           foreground '#00ff00'
    #           stream 'streams.'
    #         end
    #       end
    #     end
    #   end
    #
    # @api public
    #
    module Elements

      include Vedeu::Common
      include Vedeu::DSL::Presentation

      # @todo This documentation needs editing. (GL: 2015-12-17)
      #
      # Specify multiple lines in a view.
      #
      # @example
      #   Vedeu.view :my_interface do
      #     lines do
      #       # ... see {Vedeu::DSL::Line} and {Vedeu::DSL::Stream}
      #     end
      #   end
      #
      #   Vedeu.view :my_interface do
      #     line do
      #       # ... see {Vedeu::DSL::Line} and {Vedeu::DSL::Stream}
      #     end
      #   end
      #
      # @param block [Proc]
      # @macro raise_requires_block
      # @raise [Vedeu::Error::Fatal]
      # @return [void]
      def lines(&block)
        requires_block!(&block)
        requires_model!

        attrs = Vedeu::DSL::Attributes.build(self, model, nil, {}, &block)

        l = Vedeu::Views::View.build(attrs, &block)
        model.value = l.value
      end

      # @todo This documentation needs editing. (GL: 2015-12-17)
      #
      # Specify a single line in a view.
      #
      #   Vedeu.renders do
      #     view :my_interface do
      #       lines do
      #         line 'some text...'
      #         # ... some code
      #
      #         line 'some more text...'
      #         # ... some code
      #       end
      #     end
      #   end
      #
      # @param value [String] The value for the line. Ignored when a
      #   block is given.
      # @param opts [Hash]
      # @option opts ... [void]
      # @param block [Proc]
      # @raise [Vedeu::Error::Fatal]
      # @return [void]
      def line(value = '', opts = {}, &block)
        requires_model!

        attrs = Vedeu::DSL::Attributes.build(self, model, value, opts, &block)

        l = if block_given?
              Vedeu::Views::Line.build(attrs, &block)

            else
              s  = Vedeu::Views::Stream.new(attrs)
              ss = Vedeu::Views::Streams.coerce([s])

              Vedeu::Views::Line.new(attrs.merge!(value: ss))

            end

        if view_model? || line_model?
          model.add(l)

        else
          fail Vedeu::Error::Fatal,
               "Cannot add line to '#{model.class.name}' model."

        end
      end

      # @todo This documentation needs editing. (GL: 2015-12-17)
      #
      # Define multiple streams (a stream is a subset of a line).
      # Uses {Vedeu::DSL::Stream} for all directives within the
      # required block.
      #
      #   Vedeu.renders do
      #     view :my_interface do
      #       lines do
      #         line do
      #           streams do
      #             # ... some code
      #           end
      #
      #           stream do
      #             # ... some code
      #           end
      #         end
      #       end
      #     end
      #   end
      #
      # @param block [Proc]
      # @macro raise_requires_block
      # @raise [Vedeu::Error::Fatal]
      # @return [void]
      def streams(&block)
        requires_block!(&block)
        requires_model!

        attrs = Vedeu::DSL::Attributes.build(self, model, nil, {}, &block)

        l = Vedeu::Views::Line.build(attrs, &block)

        if view_model?
          model.add(l)

        elsif line_model?
          model.value = l.value

        end
      end

      # @todo This documentation needs editing. (GL: 2015-12-17)
      #
      # @param value [String]
      # @param opts [Hash]
      # @option opts ... [void]
      # @param block [Proc]
      # @raise [Vedeu::Error::Fatal]
      # @return [void]
      def stream(value = '', opts = {}, &block)
        requires_model!

        attrs = Vedeu::DSL::Attributes.build(self, model, value, opts, &block)

        l = if block_given?
              Vedeu::Views::Line.build(attrs, &block)

            else
              s  = Vedeu::Views::Stream.new(attrs)
              ss = Vedeu::Views::Streams.coerce([s])

              Vedeu::Views::Line.new(attrs.merge!(value: ss))

            end

        if view_model? || line_model?
          model.add(l)

        else
          fail Vedeu::Error::Fatal,
               "Cannot add line to '#{model.class.name}' model."

        end
      end

      # @todo This documentation needs editing. (GL: 2015-12-17)
      #
      # Specify the content for a view. Provides the means to align a
      # string (or object responding to `to_s`), and add it as a Line
      # or to the Stream.
      #
      # @note If using the convenience methods; left, centre, center
      #   or right, then a specified align option will be ignored.
      #
      # @example
      #   lines do
      #     centre '...'
      #   end
      #
      #   line do
      #     right '...'
      #   end
      #
      #   line do
      #     stream do
      #       text '...'
      #     end
      #   end
      #
      #   left 'This will be left aligned.', width: 35
      #   # => 'This will be left aligned.         '
      #
      #   centre 'This will be aligned centrally.', width: 35
      #   # => '  This will be aligned centrally.  '
      #   # centre is also aliased to center
      #
      #   right 'This will be right aligned.', width: 35
      #   # => '        This will be right aligned.'
      #
      #   right 'This will be right aligned.', width: 35,
      #     align: centre
      #
      #   text 'This will be truncated here. More text here.',
      #     width: 28 # => 'This will be truncated here.'
      #
      #   text 'Padded with hyphens.', width: 25, pad: '-',
      #     align: :right # => '-----Padded with hyphens.'
      #
      # @param value [String|Object] A string or object that responds
      #   to `to_s`.
      # @param opts [Hash<Symbol => void>] Text options.
      # @option opts :align [Symbol] One of `:left`,
      #   `:centre`/`:center`, or `:right`.
      # @option opts :width [Integer|NilClass] The width of the
      #   text stream to add. If the `string` provided is longer than
      #   this value, the string will be truncated. If no width is
      #   provided in the context of 'lines', then the interface width
      #   is used. If no width is provided in the context of a
      #   'stream', then no alignment will occur.
      # @option opts :pad [String] The character to use to pad the
      #   width, by default uses an empty space (0x20). Only when the
      #   string is shorter than the specified width.
      # @raise [Vedeu::Error::Fatal]
      # @return [void]
      def text(value = '', opts = {})
        requires_model!

        if view_model? || line_model?
          attrs = Vedeu::DSL::Attributes.build(self, model, value, opts)
          s  = Vedeu::Views::Stream.new(attrs)
          ss = Vedeu::Views::Streams.coerce([s])
          l  = Vedeu::Views::Line.new(attrs.merge!(value: ss))

          model.add(l)

        else
          fail Vedeu::Error::Fatal,
               "Cannot add text to '#{model.class.name}' model."

        end
      end

      # @param (see #text)
      # @return (see #text)
      def centre(value = '', opts = {})
        opts.merge!(align: :centre)

        text(value, opts)
      end
      alias_method :center, :centre

      # @param (see #text)
      # @return (see #text)
      def left(value = '', opts = {})
        opts.merge!(align: :left)

        text(value, opts)
      end

      # @param (see #text)
      # @return (see #text)
      def right(value = '', opts = {})
        opts.merge!(align: :right)

        text(value, opts)
      end

      private

      # Returns a boolean indicating the model is a
      # {Vedeu::Views::Line}.
      #
      # @return [Boolean]
      def line_model?
        model.is_a?(Vedeu::Views::Line)
      end

      # @param block [Proc]
      # @macro raise_requires_block
      # @return [NilClass]
      def requires_block!(&block)
        fail Vedeu::Error::RequiresBlock unless block_given?
      end

      # @raise [Vedeu::Error::Fatal] When the model cannot be
      #   determined.
      # @return [NilClass]
      def requires_model!
        fail Vedeu::Error::Fatal,
             'No model, cannot continue.' unless present?(model)
      end

      # Returns a boolean indicating the model is a
      # {Vedeu::Views::View}.
      #
      # @return [Boolean]
      def view_model?
        model.is_a?(Vedeu::Views::View)
      end

    end # Elements

  end # DSL

end # Vedeu
