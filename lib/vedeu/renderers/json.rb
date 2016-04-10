# frozen_string_literal: true

module Vedeu

  module Renderers

    # Renders a {Vedeu::Buffers::Terminal} as JSON.
    #
    # @api private
    #
    class JSON < Vedeu::Renderers::File

      include Vedeu::Renderers::Options

      # Render a cleared output.
      #
      # @return [Hash]
      def clear
        render({})
      end

      private

      # @return [Array]
      def as_hash
        output.content.map(&:to_h)
      end

      # @return [String]
      def content
        if hash?(output)
          ::JSON.pretty_generate(output)

        else
          Vedeu.log(type:    :render,
                    message: "#{self.class.name}#content: #{output.class.name}")

          ::JSON.pretty_generate(as_hash)
        end
      end

    end # JSON

  end # Renderers

end # Vedeu
