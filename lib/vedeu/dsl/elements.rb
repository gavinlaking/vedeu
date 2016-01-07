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

        if view_model?
          if model.lines?
            l = Vedeu::Views::Line.build(attrs, &block)
            model.add(l)

          else
            l = Vedeu::Views::View.build(attrs, &block)
            model.value = l.value

          end

        elsif line_model?
          l = Vedeu::Views::Line.build(attrs, &block)
          model.value = l.value

        else
          l = Vedeu::Views::View.build(attrs, &block)
          model.value = l.value

        end
      end
      alias_method :streams, :lines

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
              if view_model?
                # Vedeu.log(type:    :blue,
                #           message: "line blk view_model")

                Vedeu::Views::Line.build(attrs, &block)

              elsif line_model?
                # Vedeu.log(type:    :magenta,
                #           message: "line blk line_model")

                if model.streams?
                  # Vedeu.log(type:    :red,
                  #           message: "streams: #{model.streams.size}")
                  # Vedeu::Views::Streams.build(attrs, &block)
                  # model.add(nil, &block)

                else
                  # Vedeu.log(type:    :red,
                  #           message: "no streams: #{model.streams.size}")

                  Vedeu::Views::Line.build(attrs, &block)

                end
              else
                # Vedeu.log(type:    :red,
                #           message: "line blk !!!_model")

                Vedeu::Views::Line.build(attrs, &block)
              end

            else
              if view_model?
                # Vedeu.log(type: :blue, message: "line noblk view_model")
                s  = Vedeu::Views::Stream.new(attrs)
                ss = Vedeu::Views::Streams.coerce([s])

                Vedeu::Views::Line.new(attrs.merge!(value: ss))
              elsif line_model?
                # Vedeu.log(type: :magenta, message: "line noblk line_model")
                s  = Vedeu::Views::Stream.new(attrs)
                ss = Vedeu::Views::Streams.coerce([s])

                Vedeu::Views::Line.new(attrs.merge!(value: ss))
              else
                # Vedeu.log(type: :red, message: "line noblk !!!_model")

                s  = Vedeu::Views::Stream.new(attrs)
                ss = Vedeu::Views::Streams.coerce([s])

                Vedeu::Views::Line.new(attrs.merge!(value: ss))
              end

            end

        if view_model?
          # Vedeu.log(type: :green, message: "add line view_model #{l.class.name}  (#{l.object_id})->#{model.class.name} (#{model.object_id})")
          model.add(l)

        elsif line_model?
          # Vedeu.log(type: :yellow, message: "add line line_model #{l.value.class.name}  (#{l.value.object_id})->#{model.class.name} (#{model.object_id})")
          model.add(l.value)

        else
          fail Vedeu::Error::Fatal,
               "Cannot add line to '#{model.class.name}' model."

        end
      end

      # @param value [String] The value for the stream. Ignored when a
      #   block is given.
      # @param opts [Hash]
      # @option opts ... [void]
      # @param block [Proc]
      # @raise [Vedeu::Error::Fatal]
      # @return [void]
      def stream(value = '', opts = {}, &block)
        requires_model!

        attrs = Vedeu::DSL::Attributes.build(self, model, value, opts, &block)

        l = if block_given?
              if view_model?
                # Vedeu.log(type: :blue, message: "stream blk view_model")
                Vedeu::Views::Line.build(attrs, &block)

              elsif line_model?
                # Vedeu.log(type: :magenta, message: "stream blk line_model")
                Vedeu::Views::Stream.build(attrs, &block)

              elsif stream_model?
                # Vedeu.log(type: :yellow, message: "stream blk stream_model")
                Vedeu::Views::Stream.build(attrs, &block)

              else
                # Vedeu.log(type: :red, message: "stream blk !!!_model")
                Vedeu::Views::Stream.build(attrs, &block)

              end

            else
              # Vedeu.log(type: :magenta, message: "stream noblk")
              s  = Vedeu::Views::Stream.new(attrs)
              ss = Vedeu::Views::Streams.coerce([s])

              Vedeu::Views::Line.new(attrs.merge!(value: ss))

            end

        if view_model?
          # Vedeu.log(type: :green, message: "add stream view_model #{l.class.name} (#{l.object_id})->#{model.class.name} (#{model.object_id})")
          model.add(l)

        elsif line_model?
          # Vedeu.log(type: :magenta, message: "add stream line_model #{l.class.name} (#{l.object_id})->#{model.class.name} (#{model.object_id})")
          model.add([l])

        elsif stream_model?
          # Vedeu.log(type: :yellow, message: "add stream stream_model #{l.class.name} (#{l.object_id})->#{model.class.name} (#{model.object_id})")
          model.add([l])

        else
          fail Vedeu::Error::Fatal,
               "Cannot add stream to '#{model.class.name}' model."

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

        if view_model?
          attrs = Vedeu::DSL::Attributes.build(self, model, value, opts)
          s  = Vedeu::Views::Stream.new(attrs)
          ss = Vedeu::Views::Streams.coerce([s])
          l  = Vedeu::Views::Line.new(attrs.merge!(value: ss))

          # Vedeu.log(type: :blue, message: "#{model.name} text [1] view_model #{value.inspect} (#{model.inspect})")

          tmp = model.add(l)

          # Vedeu.log(type: :blue, message: "#{model.name} text [2] view_model #{value.inspect} (#{model.inspect})")

          tmp

        elsif line_model?
          attrs = Vedeu::DSL::Attributes.build(self, model, value, opts)
          s  = Vedeu::Views::Stream.new(attrs)
          # ss = Vedeu::Views::Streams.coerce([s])
          # l  = Vedeu::Views::Line.new(attrs.merge!(value: ss))

          # Vedeu.log(type: :magenta, message: "#{model.name} text [1] line_model #{value.inspect} (#{model.inspect})")

          # tmp = model.add(ss)
          tmp = model.add(s)
          # tmp = model.add(s.value)

          # Vedeu.log(type: :magenta, message: "#{model.name} text [2] line_model #{value.inspect} (#{model.inspect})")

          tmp

        elsif stream_model?
          attrs = Vedeu::DSL::Attributes.build(self, model, value, opts)
          s  = Vedeu::Views::Stream.new(attrs)

          # Vedeu.log(type: :red, message: "text [1] stream_model #{s.value.inspect}")
          # Vedeu.log(type: :yellow, message: "text [2] stream_model (#{model.inspect})")

          tmp = model.add(s.value)

          # Vedeu.log(type: :green, message: "text [3] stream_model (#{tmp.inspect})")

          tmp

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

    end # Elements

  end # DSL

end # Vedeu
