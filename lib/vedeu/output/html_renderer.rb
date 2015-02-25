module Vedeu

  class HTMLRenderer

    # @param output [Array<Array<Vedeu::Char>>]
    # @return [String]
    def self.render(output)
      new(output).render
    end

    # @param output [Array<Array<Vedeu::Char>>]
    # @return [Vedeu::HTMLRenderer]
    def initialize(output)
      @output  = output
    end

    # @return [String]
    def render
      html_header + html_body + html_footer
    end

    # @param path [String]
    # @return [String]
    def to_file(path = file_path)
      content = render

      File.open(path, "w", 0644) { |file| file.write(content) }

      content
    end

    private

    attr_reader :output

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

    # @return [String]
    def html_header
      <<-HTML
        <html>
          <head>
            <style type='text/css'>
              body { background:#000; }
              td { border:1px #171717 solid;
                font-size:12px;
                font-family:monospace;
                height:18px;
                margin:1px;
                text-align:center;
                vertical-align:center;
                width:18px; }
            </style>
          </head>
          <body>
            <table>
      HTML
    end

    # @return [String]
    def html_footer
      "</table></body></html>"
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
