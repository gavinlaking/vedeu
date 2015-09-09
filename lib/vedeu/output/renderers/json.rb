module Vedeu

  module Renderers

    # Renders a {Vedeu::Buffers::VirtualBuffer} or
    # {Vedeu::Output::Output} as JSON.
    #
    class JSON < Vedeu::Renderers::File

      # Returns a new instance of Vedeu::Renderers::JSON.
      #
      # @param options [Hash]
      # @return [Vedeu::Renderers::JSON]
      def initialize(options = {})
        @options = options || {}
      end

      # @param buffer [Vedeu::Terminal::Buffer]
      # @return [String]
      def render(buffer)
        super(parsed(buffer))
      end

      private

      # @param buffer [Vedeu::Terminal::Buffer]
      # @return [String]
      def parsed(buffer)
        ::JSON.pretty_generate(as_hash(buffer))
      end

      # @param buffer [Vedeu::Terminal::Buffer]
      # @return [Array]
      def as_hash(buffer)
        buffer.output.flatten.map do |char|
          char.to_hash
        end
      end

    end # JSON

  end # Renderers

end # Vedeu
