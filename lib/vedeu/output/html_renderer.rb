module Vedeu

  # Renders a {Vedeu::VirtualBuffer} or {Vedeu::Output} as a HTML table.
  #
  class HTMLRenderer

    # @param output [Array<Array<Vedeu::Char>>]
    # @return [String]
    def self.render(output)
      new(output).render
    end

    # @param output [Array<Array<Vedeu::Char>>]
    # @param path [String]
    # @return [String]
    def self.to_file(output, path = nil)
      new(output).to_file(path)
    end

    # @param output [Array<Array<Vedeu::Char>>]
    # @return [Vedeu::HTMLRenderer]
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

      File.open(path, "w", 0644) { |file| file.write(content) }

      content
    end

    # @return [String]
    def html_body
      out = ''
      Array(output).each do |line|
        out << "<tr>\n"
        line.each do |char|
          out << char.to_html
          out << "\n"
        end
        out << "</tr>\n"
      end
      out
    end

    private

    # @!attribute [r] output
    # @return [Array<Array<Vedeu::Char>>]
    attr_reader :output

    # @return [String]
    def template
      File.dirname(__FILE__) + '/templates/html_renderer.vedeu'
    end

    # @return [String]
    def file_path
      "/tmp/vedeu_html_#{timestamp}.html"
    end

    # return [Fixnum]
    def timestamp
      @timestamp ||= Time.now.to_i
    end

  end # HTMLRenderer

end # Vedeu
