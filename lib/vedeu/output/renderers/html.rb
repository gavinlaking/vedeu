module Vedeu

  module Renderers

    # Renders a {Vedeu::VirtualBuffer} or {Vedeu::Output} as a HTML table.
    #
    # @api private
    class HTML < Vedeu::Renderers::File

      # Returns a new instance of Vedeu::Renderers::HTML.
      #
      # @param options [Hash]
      # @return [Vedeu::Renderers::HTML]
      def initialize(options = {})
        @options = options
      end

      # @param output [Array<Array<Vedeu::Char>>]
      # @return [String]
      def render(output)
        content = output

        if write_file?
          super(Vedeu::Template.parse(self, template))

        else
          Vedeu::Template.parse(self, template)

        end
      end

      # @return [String]
      def html_body
        out = ''
        Array(content).each do |line|
          out << "<tr>\n"
          line.each do |char|
            if char.is_a?(Vedeu::Char)
              out << char.to_html
              out << "\n"
            end
          end
          out << "</tr>\n"
        end
        out
      end

      private

      def content=(value)
        options[:content] = value
      end

      # @param content [Array<Array<Vedeu::Char>>]
      def content
        options[:content]
      end

      # @return [String]
      def template
        options[:template]
      end

      # @return [Hash<Symbol => void>]
      def options
        defaults.merge!(@options)
      end

      # @return [Hash<Symbol => void>]
      def defaults
        {
          content:  '',
          template: default_template,
        }
      end

      # @return [String]
      def default_template
        ::File.dirname(__FILE__) + '/../templates/html_renderer.vedeu'
      end

    end # HTML

  end # Renderers

end # Vedeu
