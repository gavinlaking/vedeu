module Vedeu

  module Renderers

    # Renders a {Vedeu::VirtualBuffer} or {Vedeu::Output} as JSON.
    #
    # @api private
    class JSON < Vedeu::Renderers::File

      # Returns a new instance of Vedeu::Renderers::JSON.
      #
      # @param options [Hash]
      # @return [Vedeu::Renderers::JSON]
      def initialize(options = {})
        @options = options
      end

      # @param output [Array<Array<Vedeu::Char>>]
      # @return [String]
      def render(output)
        super(parsed(output))
      end

      private

      # @param output [Array<Array<Vedeu::Char>>]
      # @return [String]
      def parsed(output)
        return '' if output.nil? || output.empty?

        ::JSON.pretty_generate(as_hash(output))
      end

      # @param output [Array<Array<Vedeu::Char>>]
      # @return [Array]
      def as_hash(output)
        sorted(output).map(&:to_hash)
      end

      # @param output [Array<Array<Vedeu::Char>>]
      # @return [Array]
      def sorted(output)
        Array(output).flatten.sort { |a, b| a.position <=> b.position }
      end

    end # JSON

  end # Renderers

end # Vedeu
