#!/usr/bin/env ruby

require 'bundler/setup'
require 'vedeu'

class ColoursApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    log '/tmp/colours.log'
    renderers Vedeu::Renderers::File.new(filename: '/tmp/colours.out')
  end

  Vedeu.interface :interface_colours_view do
    colour background: '#550000', foreground: '#aaaa00'

    border do
      background '#673ab7'
      foreground '#ff9800'
      title 'Interface Colours'
    end
    geometry do
      align(:top, :left, 50, 20)
    end
  end

  Vedeu.keymap '_global_' do
    key('q') { Vedeu.exit }
  end

  Vedeu.render do
    view(:interface_colours_view) do
      # line "test" - does not work, (wrong number of args for lines dsl/view.rb:240)

      lines do
        line "A line using interface colours.".freeze
        line ""
        line do
          stream do
            text "Stream { ".freeze
            text "background".freeze, background: '#001177'
            text " }".freeze
          end
        end
        line do
          stream do
            text "Stream { ".freeze
            text "foreground".freeze, foreground: '#aa00ff'
            text " }".freeze
          end
        end
        line do
          stream do
            text "Stream { ".freeze
            text "background".freeze, background: '#117700'
            text " }".freeze
          end
        end
        line do
          stream do
            text "Stream { ".freeze
            text "foreground".freeze, foreground: '#00aaff'
            text " }".freeze
          end
        end
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # ColoursApp

ColoursApp.start
