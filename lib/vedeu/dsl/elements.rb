module Vedeu

  module DSL

    module Elements

      include Vedeu::Common

      # @param block [Proc]
      # @return [void]
      def lines(&block)
        requires_block!(&block)
        requires_model!

        l = Vedeu::Views::View.build(default_attributes(&block), &block)
        model.value = l.value
      end

      # @param value [String]
      # @param options [Hash]
      # @param block [Proc]
      # @return [void]
      def line(value = '', options = {}, &block)
        requires_model!

        value      = present?(value) ? value : ''
        options    = Vedeu::DSL::Options.new(options).options
        attributes = options.merge!(default_attributes(&block))
        attrs      = { value: value }

        l = if block_given?
              Vedeu::Views::Line.build(attributes.merge!(attrs), &block)

            else
              s  = Vedeu::Views::Stream.new(attributes.merge!(attrs))
              ss = Vedeu::Views::Streams.coerce([s])

              Vedeu::Views::Line.new(attributes.merge!(value: ss))

            end

        if view_model? || line_model?
          model.add(l)

        else
          fail Vedeu::Error::Fatal,
               "Cannot add line to '#{model.class.name}' model."

        end
      end

      # @param block [Proc]
      # @return [void]
      def streams(&block)
        requires_block!(&block)
        requires_model!

        if view_model?
          l = Vedeu::Views::Line.build(default_attributes(&block), &block)
          model.add(l)

        elsif line_model?
          fail "#{self.class.name}##{__callee__} line model"

        end
      end

      # @param value [String]
      # @param options [Hash]
      # @param block [Proc]
      # @return [void]
      def stream(value = '', options = {}, &block)
        requires_model!

        if view_model?
          fail "#{self.class.name}##{__callee__} view model"

        elsif line_model?
          fail "#{self.class.name}##{__callee__} line model"

        elsif stream_model?
          fail "#{self.class.name}##{__callee__} stream model"

        end
      end

      # @param value [String]
      # @param options [Hash]
      # @return [void]
      def text(value = '', options = {})
        requires_model!

        value      = present?(value) ? value : ''
        options    = Vedeu::DSL::Options.new(options).options
        attributes = options.merge!(default_attributes)
        attrs      = { value: value }

        if view_model? || line_model?
          s  = Vedeu::Views::Stream.new(attributes.merge!(attrs))
          ss = Vedeu::Views::Streams.coerce([s])
          l  = Vedeu::Views::Line.new(attributes.merge!(value: ss))

          model.add(l)

        elsif stream_model?
          fail "#{self.class.name}##{__callee__} stream model"

        end
      end

      private

      # Returns the client object which called the DSL method.
      #
      # @param model [NilClass|void]
      # @param block [Proc]
      # @return [Object]
      def client(model = nil, &block)
        if block_given?
          eval('self', block.binding)

        elsif model
          model.client

        end
      end

      # @param block [Proc]
      # @return [Hash]
      def default_attributes(&block)
        {
          client: client(model, &block),
          name:   model.name,
          # parent: model.parent,
        }
      end

      # @return [Boolean]
      def line_model?
        model.is_a?(Vedeu::Views::Line)
      end

      # @param block [Proc]
      # @raise [Vedeu::Error::RequiresBlock] When the required block
      #   is not given.
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

      # @return [Boolean]
      def stream_model?
        model.is_a?(Vedeu::Views::Stream)
      end

      # @return [Boolean]
      def view_model?
        model.is_a?(Vedeu::Views::View)
      end

    end # Elements

  end # DSL

end # Vedeu
