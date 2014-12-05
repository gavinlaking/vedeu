module Vedeu

  class Pipe

    def initialize()
    end


  end # Pipe

end # Vedeu

require 'strscan'

module ANSI2HTML
  class Main
    COLOR = {
       '1' => 'bold',
      '30' => 'black',
      '31' => 'red',
      '32' => 'green',
      '33' => 'yellow',
      '34' => 'blue',
      '35' => 'magenta',
      '36' => 'cyan',
      '37' => 'white',
      '90' => 'grey'
    }

    def self.execute
      new(STDIN.read, STDOUT, ARGV.index('--envelope'), ARGV.index('--black'))
    end

    def initialize(ansi, out, envelope=false, black=false)
      if(envelope)
        background, color = black ? %w(black white) : %w(white black)
        out.print %{<!doctype html>
<html>
<head>
  <meta charset="utf-8" />
  <style>
    body     { background-color: #{background};color: #{color}; }
    .bold    { font-weight: bold; }
    .black   { color: black; }
    .red     { color: red; }
    .green   { color: green; }
    .yellow  { color: yellow; }
    .blue    { color: blue; }
    .magenta { color: magenta; }
    .cyan    { color: cyan; }
    .white   { color: white; }
    .grey    { color: grey; }
  </style>
</head>
<body><pre><code>}
      end
      s = StringScanner.new(ansi.gsub("<", "&lt;"))
      while(!s.eos?)
        if s.scan(/\e\[(3[0-7]|90|1)m/)
          out.print(%{<span class="#{COLOR[s[1]]}">})
        else
          if s.scan(/\e\[0m/)
            out.print(%{</span>})
          else
            out.print(s.scan(/./m))
          end
        end
      end

      if(envelope)
        out.print %{</code></pre></body></html>}
      end
    end
  end
end
