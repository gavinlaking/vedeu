require 'vedeu/support/alignment'
require 'vedeu/support/common'
require 'vedeu/dsl/colour'
require 'vedeu/dsl/style'

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

      include Vedeu::Alignment
      include Vedeu::Common
      include Vedeu::DSL::Colour
      include Vedeu::DSL::Style

      # Returns an instance of DSL::Line.
      #
      # @param model [Line]
      def initialize(model)
        @model = model
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
      # @return [Line]
      def line(value = '')
        interface = model.parent
        new_line  = Vedeu::Line.new([], interface, Vedeu::Colour.new, Vedeu::Style.new)
        stream    = Vedeu::Stream.new(value, new_line, Vedeu::Colour.new, Vedeu::Style.new)

        new_line.streams << stream

        interface.lines.add(new_line)
      end
      alias_method :text, :line

      # Define multiple streams (a stream is a subset of a line).
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

    end # Line

  end # DSL

end # Vedeu
