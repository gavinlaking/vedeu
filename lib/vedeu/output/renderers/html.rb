module Vedeu

  module Renderers

    # Renders a {Vedeu::VirtualBuffer} or {Vedeu::Output} as a HTML table.
    class HTML

      # @param output [Array<Array<Vedeu::Char>>]
      # @return [String]
      def self.render(output)
        new(output).to_file
      end

      # @param output [Array<Array<Vedeu::Char>>]
      # @param path [String]
      # @return [String]
      def self.to_file(output, path = nil)
        new(output).to_file(path)
      end

      # Returns a new instance of Vedeu::Renderers::HTML.
      #
      # @param output [Array<Array<Vedeu::Char>>]
      # @return [Vedeu::Renderers::HTML]
      def initialize(output)
        @output = output
      end

      # @return [String]
      def render
        Vedeu::Template.parse(self, template)
      end

      # Writes the parsed template to a file (at the given path) and returns the
      # contents.
      #
      # @param path [String]
      # @return [String]
      def to_file(path = file_path)
        content = render

        ::File.open(path, 'w') { |file| file.write(content) }

        content
      end

      # @return [String]
      def html_body
        out = ''
        Array(output).each do |line|
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

      protected

      # @!attribute [r] output
      # @return [Array<Array<Vedeu::Char>>]
      attr_reader :output

      private

      # @return [String]
      def template
        ::File.dirname(__FILE__) + '/../templates/html_renderer.vedeu'
      end

      # @return [String]
      def file_path
        "/tmp/vedeu_html_#{timestamp}.html"
      end

      # return [Fixnum]
      def timestamp
        @timestamp ||= Time.now.to_i
      end

    end # HTML

  end # Renderers

end # Vedeu
