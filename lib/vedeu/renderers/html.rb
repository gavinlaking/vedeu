# frozen_string_literal: true

module Vedeu

  module Renderers

    # Renders a {Vedeu::Buffers::Terminal} as a HTML snippet; a table
    # by default.
    #
    # @api private
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

      # @return [Boolean]
      def valid?
        return false if string?(output) || escape?(output)

        true
      end

    end # HTML

  end # Renderers

end # Vedeu
