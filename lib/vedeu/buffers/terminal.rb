# frozen_string_literal: true

module Vedeu

  module Buffers

    # All output will be written to this singleton, and #render will
    # be called at the end of each run of {Vedeu::MainLoop};
    # effectively rendering this buffer to each registered renderer.
    # This buffer is not cleared after this action though, as
    # subsequent actions will modify the contents. This means that
    # individual parts of Vedeu can write content here at various
    # points and only at the end of each run of {Vedeu::MainLoop} will
    # it be actually output 'somewhere'.
    #
    module Terminal

      extend self

      # {include:file:docs/dsl/by_method/clear.md}
      # @return [String|void] Most likely to be a String.
      def clear
        reset!

        Vedeu.renderers.clear
      end

      # Returns the buffer content.
      #
      # @example
      #   Vedeu.trigger(:_drb_retrieve_output_)
      #
      # @return [Vedeu::Models::Page]
      def output
        Vedeu::Models::Page.coerce(buffer)
      end

      # {include:file:docs/dsl/by_method/refresh.md}
      # @return [String|void] Most likely to be a String.
      def refresh
        Vedeu.renderers.render(output)
      end

      # Removes all content from the virtual terminal; effectively
      # clearing it.
      #
      # @return [Vedeu::Buffers::View]
      def reset!
        @buffer = buffer.reset!
      end

      # Write a collection of cells to the virtual terminal, but do
      # not send to a renderer.
      #
      # @param value_or_values [Array<Array<Vedeu::Cells::Char>>]
      # @return [Array<Array<Vedeu::Cells::Char>>]
      def update(value_or_values)
        buffer.update(value_or_values)
      end

      # Write a collection of cells to the virtual terminal, will
      # then send written content to be rendered by a renderer. This
      # method is used internally by Vedeu, but can be triggered in
      # DRb mode pushing the given data in to the virtual buffer of
      # the running client application as per the example.
      #
      # @example
      #   Vedeu.trigger(:_drb_store_output_, value_or_values)
      #
      # @param value_or_values [Array<Array<Vedeu::Cells::Char>>]
      # @return [Array<Array<Vedeu::Cells::Char>>]
      def write(value_or_values)
        update(value_or_values)

        refresh
      end

      private

      # Return a grid of {Vedeu::Cells::Empty} objects defined by the
      # height and width of this virtual terminal.
      #
      # @return [Vedeu::Buffers::View]
      def buffer
        @buffer ||= Vedeu::Buffers::View.new(name: name)
      end
      alias cells buffer

    end # Terminal

  end # Buffers

  # @api public
  # @!method clear
  #   @see Vedeu::Buffers::Terminal#clear
  # @api public
  # @!method refresh
  #   @see Vedeu::Buffers::Terminal#refresh
  def_delegators Vedeu::Buffers::Terminal,
                 :clear,
                 :refresh

  # :nocov:

  # @see Vedeu::Buffers::Terminal#clear
  Vedeu.bind(:_clear_) { Vedeu.clear }

  # @see Vedeu::Buffers::Terminal#output
  Vedeu.bind(:_drb_retrieve_output_) { Vedeu::Buffers::Terminal.output }

  # @see Vedeu::Buffers::Terminal#write
  Vedeu.bind(:_drb_store_output_) do |data|
    Vedeu::Buffers::Terminal.write(data)
  end

  # :nocov:

end # Vedeu
