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

        ::JSON.pretty_generate(sorted)
      end

      # @return [Array]
      def sorted
        Array(output).flatten.sort { |a, b| a.position <=> b.position }.map { |char| char.to_hash }
      end

    end # JSON

  end # Renderers

end # Vedeu
