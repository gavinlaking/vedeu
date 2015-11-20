module Vedeu

  module Terminal

    # All output will be written to this singleton, and #render will
    # be called at the end of each run of {Vedeu::MainLoop};
    # effectively rendering this buffer to each registered renderer.
    # This buffer is not cleared after this action though, as
    # subsequent actions will modify the contents. This means that
    # individual parts of Vedeu can write content here at various
    # points and only at the end of each run of {Vedeu::MainLoop} will
    # it be actually output 'somewhere'.
    #
    module Buffer

      extend self

      # Clears the whole terminal space.
      #
      # @example
      #   Vedeu.clear
      #
      #   # or...
      #
      #   Vedeu.trigger(:_clear_)
      #
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

      # Send the cells to the renderer and return the rendered result.
      #
      # @example
      #   Vedeu.refresh
      #
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
      # @param value_or_values [Array<Array<Vedeu::Views::Char>>]
      # @return [Array<Array<Vedeu::Views::Char>>]
      def update(value_or_values)
        buffer.update(value_or_values)

        self
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
      # @param value [Array<Array<Vedeu::Views::Char>>]
      # @return [Array<Array<Vedeu::Views::Char>>]
      def write(value_or_values)
        buffer.update(value_or_values)

        refresh

        self
      end

      private

      # Return a grid of {Vedeu::Models::Cell} objects defined by the
      # height and width of this virtual terminal.
      #
      # @return [Vedeu::Buffers::View]
      def buffer
        @buffer ||= Vedeu::Buffers::View.new(name: name)
      end
      alias_method :cells, :buffer

    end # Buffer

  end # Terminal

  # @!method clear
  #   @see Vedeu::Terminal::Buffer#clear
  def_delegators Vedeu::Terminal::Buffer,
                 :clear,
                 :refresh

  # :nocov:

  # @see Vedeu::Terminal::Buffer#clear
  Vedeu.bind(:_clear_) { Vedeu.clear }

  # @see Vedeu::Terminal::Buffer#output
  Vedeu.bind(:_drb_retrieve_output_) { Vedeu::Terminal::Buffer.output }

  # @see Vedeu::Terminal::Buffer#write
  Vedeu.bind(:_drb_store_output_) { |data| Vedeu::Terminal::Buffer.write(data) }

  # :nocov:

end # Vedeu
