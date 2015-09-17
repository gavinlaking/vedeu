module Vedeu

  module DSL

    # Provides methods to be used to define views.
    #
    #   Vedeu.renders do
    #     view 'my_interface' do
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
    class Line

      include Vedeu::DSL
      include Vedeu::DSL::Presentation
      include Vedeu::DSL::Text

      # Returns an instance of DSL::Line.
      #
      # @param model [Vedeu::Views::Line]
      # @param client [Object]
      # @return [Vedeu::DSL::Line]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # Specify a single line in a view.
      #
      #   Vedeu.renders do
      #     view 'my_interface' do
      #       line 'some text...'
      #       # ... some code
      #
      #       line do
      #         # ... some code
      #       end
      #     end
      #   end
      #
      # @raise [Vedeu::Error::InvalidSyntax] When no block or value is
      #   provided.
      # @return [Vedeu::Views::Lines]
      def line(value = '', &block)
        if block_given?
          content = Vedeu::Views::Line.build(client: client,
                                             parent: model.parent, &block)

        elsif value
          content = Vedeu::Views::Line.build(client: client,
                                             parent: model.parent,
                                             value:  [build_stream(value)])

        else
          fail Vedeu::Error::InvalidSyntax, 'block not given'

        end

        model.parent.add(content)
      end
      alias_method :line=, :line

      # Define multiple streams (a stream is a subset of a line).
      # Uses {Vedeu::DSL::Stream} for all directives within the
      # required block.
      #
      #   Vedeu.renders do
      #     view 'my_interface' do
      #       line do
      #         streams do
      #           # ... some code
      #         end
      #
      #         stream do
      #           # ... some code
      #         end
      #       end
      #     end
      #   end
      #
      # @param block [Proc]
      # @raise [Vedeu::Error::InvalidSyntax] The required block was
      #   not given.
      # @return [Vedeu::Views::Streams<Vedeu::Views::Stream>]
      # @see Vedeu::DSL::Stream for subdirectives.
      def streams(&block)
        fail Vedeu::Error::InvalidSyntax, 'block not given' unless block_given?

        model.add(model.member.build(attributes, &block))
      end
      alias_method :stream, :streams
      alias_method :stream=, :streams
      alias_method :streams=, :streams

      private

      # @param value [String]
      # @return [Vedeu::Views::Stream]
      def build_stream(value)
        Vedeu::Views::Stream.build(client: client, parent: model, value: value)
      end

    end # Line

  end # DSL

end # Vedeu
