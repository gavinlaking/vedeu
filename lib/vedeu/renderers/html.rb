# frozen_string_literal: true

module Vedeu

  module Renderers

    # Renders a {Vedeu::Buffers::Terminal} as a HTML snippet; a table
    # by default.
    #
    class HTML < Vedeu::Renderers::File

      include Vedeu::Renderers::Options

      # @return [String]
      def html_body
        if valid?
          output.inject([]) do |acc, line|
            acc << "#{start_row_tag}\n"
            line.each do |char|
              acc << char.to_html(options)
            end
            acc << "#{end_row_tag}\n"
          end.join

        else
          ''

        end
      end

      private

      # @return [String]
      def content
        if valid?
          Vedeu::Templating::Template.parse(self, template)

        else
          ''

        end
      end

      # Returns a boolean indicating whether the output is a
      # {Vedeu::Cells::Escape}. If it is, it won't be rendered in
      # HTML.
      #
      # @return [Boolean]
      def escape?
        output.is_a?(Vedeu::Cells::Escape) || output.is_a?(Vedeu::Cells::Cursor)
      end

      # @return [Boolean]
      def valid?
        return false if string?(output) || escape?

        true
      end

    end # HTML

  end # Renderers

end # Vedeu
