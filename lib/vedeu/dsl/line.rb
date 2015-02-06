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

      include Vedeu::DSL::Alignment
      include Vedeu::Common
      include Vedeu::DSL::Colour
      include Vedeu::DSL::Style

      # Returns an instance of DSL::Line.
      #
      # @param model [Line]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # Specify a single line in a view.
      #
      # @param value [String]
      #
      # @example
      #   Vedeu.renders do
      #     view 'my_interface' do
      #       lines do
      #         line 'This is an uninteresting line of text.'
      #         line 'This is also a line of text.'
      #         ...
      #         text 'This is an alias for `line`, if you prefer.'
      #
      #   Vedeu.renders do
      #     view 'my_interface' do
      #       lines do
      #         line do
      #           # ...
      #
      # @return [Line]
      def line(value = '', &block)
        if block_given?
          streams(&block)

        else
          interface = model.parent
          new_line  = Vedeu::Line.new([], interface, Vedeu::Colour.new, Vedeu::Style.new)
          stream    = Vedeu::Stream.new(value, new_line, Vedeu::Colour.new, Vedeu::Style.new)

          new_line.streams << stream

          interface.lines.add(new_line)

        end
      end
      alias_method :text, :line

      # Define multiple streams (a stream is a subset of a line).
      # Uses Vedeu::DSL::Stream for all directives within the required block.
      #
      # @param block [Proc]
      #
      # @example
      #   Vedeu.renders do
      #     view 'my_interface' do
      #       lines do
      #         streams do
      #           # ...
      #
      # @raise [InvalidSyntax] The required block was not given.
      # @return [Vedeu::Model::Collection<Vedeu::Stream>]
      # @see Vedeu::DSL::Stream for subdirectives.
      def streams(&block)
        unless block_given?
          fail InvalidSyntax, "'#{__callee__}' requires a block."
        end

        model.streams.add(Vedeu::Stream.build({ parent: model }, &block))
      end

      private

      attr_reader :model

      # @param method [Symbol] The name of the method sought.
      # @param args [Array] The arguments which the method was to be invoked
      #   with.
      # @param block [Proc] The optional block provided to the method.
      # @return []
      def method_missing(method, *args, &block)
        Vedeu.log("!!!method_missing '#{method}' (args: #{args.inspect})")

        @client.send(method, *args, &block) if @client
      end

    end # Line

  end # DSL

end # Vedeu
