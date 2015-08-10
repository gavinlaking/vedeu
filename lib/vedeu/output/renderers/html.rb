module Vedeu

  module Renderers

    # Renders a {Vedeu::Buffers::VirtualBuffer} or
    # {Vedeu::Output::Output} as a HTML snippet; a table by default.
    #
    class HTML < Vedeu::Renderers::File

      # Returns a new instance of Vedeu::Renderers::HTML.
      #
      # @param options [Hash]
      # @option options content [String]
      # @option options end_row_tag [String]
      # @option options start_row_tag [String]
      # @option options template [String]
      # @return [Vedeu::Renderers::HTML]
      def initialize(options = {})
        @options = options || {}
      end

      # @param output [Array<Array<Vedeu::Views::Char>>]
      # @return [String]
      def render(output)
        @content = output

        super(Vedeu::Templating::Template.parse(self, template))
      end

      # @return [String]
      def html_body
        return '' if content.is_a?(Vedeu::Models::Escape)

        out = ''

        Array(content).flatten.each do |line|
          out << "#{start_row_tag}\n"

          if line.is_a?(String)
            out << line

          elsif line.is_a?(Vedeu::Escape)
            out << line.to_html(options)

          else
            #line.each do |char|
              # if char.is_a?(Vedeu::Views::Char)
              out << line.to_html(options)
              out << "\n"
              # end
            #end

          end

          out << "#{end_row_tag}\n"
        end

        out
      end

      private

      # @return [Array<Array<Vedeu::Views::Char>>]
      def content
        @content || options[:content]
      end
      alias_method :output, :content

      # @return [String]
      def end_tag
        options[:end_tag]
      end

      # @return [String]
      def end_row_tag
        options[:end_row_tag]
      end

      # @return [String]
      def end_tag
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

      # Combines the options provided at instantiation with the
      # default values.
      #
      # @return [Hash<Symbol => void>]
      def options
        defaults.merge!(@options)
      end

      # The default values for a new instance of this class.
      #
      # @return [Hash<Symbol => void>]
      def defaults
        super.merge({
          content:       '',
          end_tag:       '</td>',
          end_row_tag:   '</tr>',
          start_tag:     '<td',
          start_row_tag: '<tr>',
          template:      default_template,
        })
      end

      # @return [String]
      def default_template
        ::File.dirname(__FILE__) + '/../templates/html_renderer.vedeu'
      end

    end # HTML

  end # Renderers

end # Vedeu
