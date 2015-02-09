require 'vedeu/dsl/shared/all'
require 'vedeu/support/common'

module Vedeu

  module DSL

    # Provides methods to be used to define views.
    #
    # @example
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
    # @api public
    class Line

      include Vedeu::Common
      include Vedeu::DSL
      include Vedeu::DSL::Colour
      include Vedeu::DSL::Style
      include Vedeu::DSL::Text

      # Returns an instance of DSL::Line.
      #
      # @param model [Vedeu::Line]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # Specify a single line in a view.
      #
      # @example
      #   Vedeu.renders do
      #     view 'my_interface' do
      #       line 'some text...'
      #       # ...
      #
      #       line do
      #         # ...
      #
      # @return [Vedeu::Line]
      def line(value = '', &block)
        content = if block_given?
          Vedeu::Line.build({ client: client,
                              parent: model.parent }, &block)

        elsif value
          stream = Vedeu::Stream.build({ client: client,
                                         parent: model,
                                         value: value })
          Vedeu::Line.build({ client:  client,
                              parent:  model.parent,
                              streams: [stream] })

        else
          fail InvalidSyntax, 'block not given'

        end

        model.parent.add(content)
      end

      # Define multiple streams (a stream is a subset of a line).
      # Uses {Vedeu::DSL::Stream} for all directives within the required block.
      #
      # @param block [Proc]
      #
      # @example
      #   Vedeu.renders do
      #     view 'my_interface' do
      #       line do
      #         streams do
      #           # ...
      #
      #         stream do
      #           # ...
      #
      # @raise [InvalidSyntax] The required block was not given.
      # @return [Vedeu::Streams<Vedeu::Stream>]
      # @see Vedeu::DSL::Stream for subdirectives.
      def streams(&block)
        fail InvalidSyntax, 'block not given' unless block_given?

        model.add(child.build(attributes, &block))
      end
      alias_method :stream, :streams

      private

      attr_reader :client, :model

      # Return the class name for the children on this model.
      #
      # @return [Class]
      def child
        Vedeu::Stream
      end

      # @return [Hash]
      def attributes
        {
          client: client,
          parent: model,
        }
      end

    end # Line

  end # DSL

end # Vedeu
