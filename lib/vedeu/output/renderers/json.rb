module Vedeu

  module Renderers

    # Renders a {Vedeu::VirtualBuffer} or {Vedeu::Output} as JSON.
    #
    # @api private
    class JSON < Vedeu::Renderers::File

      private

      # @return [String]
      def parsed
        return '' if output.nil? || output.empty?

        ::JSON.pretty_generate(as_hash)
      end

      # @return [Array]
      def as_hash
        sorted.map(&:to_hash)
      end

      # @return [Array]
      def sorted
        Array(output).flatten.sort { |a, b| a.position <=> b.position }
      end

    end # JSON

  end # Renderers

end # Vedeu
