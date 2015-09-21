module Vedeu

  module Renderers

    # Renders a {Vedeu::Terminal::Buffer} as a HTML snippet; a table
    # by default.
    #
    class HTML < Vedeu::Renderers::File

      # Returns a new instance of Vedeu::Renderers::HTML.
      #
      # @param options [Hash]
      # @option options content [String] Defaults to an empty string.
      # @option options end_tag [String] Defaults to '</td>'.
      # @option options end_row_tag [String] Defaults to '</tr>'.
      # @option options filename [String] Provide a filename for the
      #   output. Defaults to 'out'.
      # @option options start_tag [String] Defaults to '<td' (note the
      #   end of the tag is missing, this is so that inline styles can
      #   be added later).
      # @option options start_row_tag [String] Defaults to '<tr>'.
      # @option options template [String]
      # @option options timestamp [Boolean] Append a timestamp to the
      #   filename.
      # @option options write_file [Boolean] Whether to write the file
      #   to the given filename.
      # @return [Vedeu::Renderers::HTML]
      def initialize(options = {})
        @options = options || {}
        @output  = nil
      end

      # @param output [Vedeu::Models::Page]
      # @return [String]
      def render(output)
        @output = output

        super(Vedeu::Templating::Template.parse(self, template)) unless escape?
      end

      # @return [String]
      def html_body
        return '' if output.is_a?(Vedeu::Models::Escape)

        out = ''

        output.each do |line|
          out << "#{start_row_tag}\n"
          line.each { |char| out << char.to_html(options) }
          out << "#{end_row_tag}\n"
        end

        out
      end

      private

      # Returns a boolean indicating whether the output is a
      # {Vedeu::Models::Escape}. If it is, it won't be rendered in
      # HTML.
      #
      # @return [Boolean]
      def escape?
        output.is_a?(Vedeu::Models::Escape)
      end

      # @return [Array<Array<Vedeu::Views::Char>>]
      def output
        @output || options[:output]
      end

      # @return [String]
      def end_tag
        options[:end_tag]
      end

      # @return [String]
      def end_row_tag
        options[:end_row_tag]
      end

      # @return [String]
      def start_tag
        options[:start_tag]
      end

      # @return [String]
      def start_row_tag
        options[:start_row_tag]
      end

      # @return [String]
      def template
        options[:template]
      end

      # The default values for a new instance of this class.
      #
      # @return [Hash<Symbol => void>]
      def defaults
        {
          content:       '',
          end_tag:       '</td>',
          end_row_tag:   '</tr>',
          filename:      'out',
          start_tag:     '<td',
          start_row_tag: '<tr>',
          template:      default_template,
          timestamp:     false,
          write_file:    true,
        }
      end

      # @return [String]
      def default_template
        ::File.dirname(__FILE__) + '/../templates/html_renderer.vedeu'
      end

    end # HTML

  end # Renderers

end # Vedeu
