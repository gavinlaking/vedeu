#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

-> { its -> { a } }
trap('INT') { exit! }

require 'vedeu'

class VedeuBordersApp
  include Vedeu

  configure do
    colour_mode 16777216
    debug!
    log '/tmp/vedeu_borders_app.log'
  end

  bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  interface 'default_border' do
    geometry do
      x      2
      y      2
      height 3
      width  7
    end
    colour  foreground: '#ffffff', background: '#ff0000'
  end

  interface 'border_off' do
    geometry do
      x      11
      y      2
      height 3
      width  7
    end
    colour  foreground: '#ffffff', background: '#ff0000'
  end

  interface 'no_top' do
    geometry do
      x      20
      y      2
      height 3
      width  7
    end
    colour  foreground: '#000000', background: '#ffff00'
  end

  interface 'no_bottom' do
    geometry do
      x      29
      y      2
      height 3
      width  7
    end
    colour  foreground: '#000000', background: '#ffff00'
  end

  interface 'no_left' do
    geometry do
      x      38
      y      2
      height 3
      width  7
    end
    colour  foreground: '#000000', background: '#ffff00'
  end

  interface 'no_right' do
    geometry do
      x      47
      y      2
      height 3
      width  7
    end
    colour  foreground: '#000000', background: '#ffff00'
  end

  interface 'custom_corners' do
    geometry do
      x      2
      y      7
      height 3
      width  7
    end
    colour  foreground: '#ffffff', background: '#ff0000'
  end

  interface 'custom_horizontal_and_vertical' do
    geometry do
      x      11
      y      7
      height 3
      width  7
    end
    colour  foreground: '#ffffff', background: '#ff0000'
  end

  interface 'only_top' do
    geometry do
      x      20
      y      7
      height 3
      width  7
    end
    colour  foreground: '#ffffff', background: '#0000ff'
  end

  interface 'only_bottom' do
    geometry do
      x      29
      y      7
      height 3
      width  7
    end
    colour  foreground: '#ffffff', background: '#0000ff'
  end

  interface 'only_left' do
    geometry do
      x      38
      y      7
      height 3
      width  7
    end
    colour  foreground: '#ffffff', background: '#0000ff'
  end

  interface 'only_right' do
    geometry do
      x      47
      y      7
      height 3
      width  7
    end
    colour  foreground: '#ffffff', background: '#0000ff'
  end

  interface 'custom_colour' do
    geometry do
      x      2
      y      12
      height 3
      width  7
    end
    colour foreground: '#ffffff', background: '#ff0000'
  end

  interface 'negative' do
    geometry do
      x      11
      y      12
      height 3
      width  7
    end
    colour foreground: '#000000', background: '#00ff00'
    style  'normal'
  end

  keymap '_global_' do
    key('r') { Vedeu.trigger(:_refresh_) }
  end

  # Borders can be defined as part of a view (see below), or standalone.
  border 'no_bottom' do
    show_bottom false
  end
  border 'no_left' do
    show_left false
  end
  border 'no_right' do
    show_right false
  end
  border 'no_top' do
    show_top false
  end

  renders do
    view('default_border') do
      border!
      lines do
        line 'on'
      end
    end
    view('border_off') do
      lines do
        line 'off'
      end
    end
    view('no_top') do
      lines do
        line 'no t'
      end
    end
    view('no_bottom') do
      lines do
        line 'no b'
      end
    end
    view('no_left') do
      lines do
        line 'no l'
      end
    end
    view('no_right') do
      lines do
        line 'no r'
      end
    end
    view('custom_corners') do
      border do
        top_right    'B'
        top_left     'A'
        bottom_right 'D'
        bottom_left  'C'
      end
      lines do
        line 'chars'
        line '1'
      end
    end
    view('custom_horizontal_and_vertical') do
      border do
        horizontal '*'
        vertical   '$'
      end
      lines do
        line 'chars'
        line '2'
      end
    end
    view('only_top') do
      border do
        show_right  false
        show_bottom false
        show_left   false
      end
      lines do
        line 'only'
        line 't'
      end
    end
    view('only_bottom') do
      border do
        show_top   false
        show_right false
        show_left  false
      end
      lines do
        line 'only'
        line 'b'
      end
    end
    view('only_left') do
      border do
        show_top    false
        show_bottom false
        show_right  false
      end
      lines do
        line 'only'
        line 'l'
      end
    end
    view('only_right') do
      border do
        show_top    false
        show_bottom false
        show_left   false
      end
      lines do
        line 'only'
        line 'r'
      end
    end
    view('custom_colour') do
      border do
        colour foreground: '#ffff00', background: '#0000ff'
      end
      lines do
        line 'color'
      end
    end
    view('negative') do
      border do
        style 'negative'
      end
      lines do
        line 'style'
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end
end

VedeuBordersApp.start(ARGV)
