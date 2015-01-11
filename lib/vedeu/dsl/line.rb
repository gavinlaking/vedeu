require 'vedeu/dsl/colour'
require 'vedeu/dsl/style'
require 'vedeu/support/common'

module Vedeu

  module DSL

    # Provides methods to be used to define views.
    #
    # @api public
    class Line

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
      # @param block [Proc]
      #
      # @example
      #   view 'my_interface' do
      #     line 'This is a line of text...'
      #     line 'and so is this...'
      #     ...
      #
      # @return [Line]
      def line(value = '')
        _stream = Vedeu::Stream.new(value, nil, Vedeu::Colour.new, Vedeu::Style.new)
        _line   = Vedeu::Line.new([], model, Vedeu::Colour.new, Vedeu::Style.new)
        _stream.parent = _line
        _line.streams << _stream

        interface = model.parent
        interface.lines.add(_line)
      end

      # Define a stream (a subset of a line).
      #
      # @param value [String]
      # @param block [Proc] Block contains directives relating to Vedeu::Stream.
      #
      # @example
      #   ...
      #     lines do
      #       stream do
      #         ...
      #
      #   ...
      #     lines do
      #       stream 'Some text goes here...'
      #       ...
      #
      # @return [Array]
      def stream(value = '', &block)
        model.streams.add(Vedeu::Stream.build({
          parent: model, value: value
        }), &block)
      end
      alias_method :text, :stream

      # Define multiple streams (a stream is a subset of a line).
      #
      # @param block [Proc]
      #
      # @example
      #   ...
      #     lines do
      #       streams do
      #         ...
      #
      # @return [Array]
      def streams(&block)
        return requires_block(__callee__) unless block_given?

        model.streams.add(Vedeu::Stream.build({ parent: model }, &block))
      end

      private

      attr_reader :model

    end # Line

  end # DSL

end # Vedeu
