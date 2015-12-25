# frozen_string_literal: true

module Vedeu

  module Renderers

    # Renders a {Vedeu::Buffers::Terminal} as JSON.
    #
    class JSON < Vedeu::Renderers::File

      # Returns a new instance of Vedeu::Renderers::JSON.
      #
      # @param options [Hash]
      # @return [Vedeu::Renderers::JSON]
      def initialize(options = {})
        @options = options || {}
      end

      # Render a cleared output.
      #
      # @return [String]
      def clear
        json = parse({})

        super(json, { compression: false })

        json
      end

      # @param output [Vedeu::Models::Page]
      # @return [String]
      def render(output)
        json = parse(output)

        super(json, { compression: false })

        json
      end

      private

      # @param output [Vedeu::Models::Page]
      # @return [String]
      def parse(output)
        ::JSON.pretty_generate(as_hash(output))
      end

      # @param output [Vedeu::Models::Page]
      # @return [Array]
      def as_hash(output)
        return output if output.is_a?(Hash)

        output.content.map(&:to_hash)
      end

    end # JSON

  end # Renderers

end # Vedeu
