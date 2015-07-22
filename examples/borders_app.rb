#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'vedeu'

# An example application to demonstrate borders.
#
# If you have cloned this repository from GitHub, you can run this example:
#
#     ./examples/borders_app.rb
#
class VedeuBordersApp

  # Be aware that running an application with debugging enabled will affect
  # performance.
  Vedeu.configure do
    # debug!
    log '/tmp/vedeu_borders_app.log'
    raw!
    run_once!
    standalone!
  end

  Vedeu.interface 'default_border' do
    geometry do
      x      2
      y      2
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#ff0000'
  end

  Vedeu.interface 'border_off' do
    geometry do
      x      14
      y      2
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#ff0000'
  end

  Vedeu.interface 'no_top' do
    geometry do
      x      26
      y      2
      height 4
      width  10
    end
    colour  foreground: '#000000', background: '#ff5500'
  end

  Vedeu.interface 'no_bottom' do
    geometry do
      x      38
      y      2
      height 4
      width  10
    end
    colour  foreground: '#000000', background: '#ff5500'
  end

  Vedeu.interface 'no_left' do
    geometry do
      x      50
      y      2
      height 4
      width  10
    end
    colour  foreground: '#000000', background: '#ff5500'
  end

  Vedeu.interface 'no_right' do
    geometry do
      x      62
      y      2
      height 4
      width  10
    end
    colour  foreground: '#000000', background: '#ff5500'
  end

  Vedeu.interface 'custom_corners' do
    geometry do
      x      2
      y      8
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#ff0000'
  end

  Vedeu.interface 'custom_sides' do
    geometry do
      x      14
      y      8
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#ff0000'
  end

  Vedeu.interface 'only_top' do
    geometry do
      x      26
      y      8
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#0000ff'
  end

  Vedeu.interface 'only_bottom' do
    geometry do
      x      38
      y      8
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#0000ff'
  end

  Vedeu.interface 'only_left' do
    geometry do
      x      50
      y      8
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#0000ff'
  end

  Vedeu.interface 'only_right' do
    geometry do
      x      62
      y      8
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#0000ff'
  end

  Vedeu.interface 'custom_colour' do
    geometry do
      x      2
      y      14
      height 4
      width  10
    end
    colour foreground: '#ffffff', background: '#ff0000'
  end

  Vedeu.interface 'negative' do
    geometry do
      x      14
      y      14
      height 4
      width  10
    end
    colour foreground: '#000000', background: '#00ff00'
    style  'normal'
  end

  Vedeu.keymap '_global_' do
    key('r') { Vedeu.trigger(:_refresh_) }

    key('q')        { Vedeu.trigger(:_exit_) }
    key(:escape)    { Vedeu.trigger(:_mode_switch_) }
    key(:shift_tab) { Vedeu.trigger(:_focus_prev_) }
    key(:tab)       { Vedeu.trigger(:_focus_next_) }
  end

  # Borders can be defined as part of a view (see below), or standalone.
  Vedeu.border 'no_bottom' do
    foreground  '#ffffff'
    show_bottom false
  end
  Vedeu.border 'no_left' do
    foreground  '#ffffff'
    show_left false
  end
  Vedeu.border 'no_right' do
    foreground  '#ffffff'
    show_right false
  end
  Vedeu.border 'no_top' do
    foreground  '#ffffff'
    show_top false
  end

  Vedeu.renders do
    view('default_border') do
      border do
        foreground '#ffffff'
      end
      lines do
        line 'all on'
      end
    end
    view('border_off') do
      lines do
        line 'all off'
      end
    end
    view('no_top') do
      lines do
        line 'no top'
      end
    end
    view('no_bottom') do
      lines do
        line 'no'
        line 'bottom'
      end
    end
    view('no_left') do
      lines do
        line 'no left'
      end
    end
    view('no_right') do
      lines do
        line 'no right'
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
        line 'custom'
        line 'corners'
      end
    end
    view('custom_sides') do
      border do
        horizontal '*'
        vertical   '$'
      end
      lines do
        line 'custom'
        line 'sides'
      end
    end
    view('only_top') do
      border do
        foreground  '#ffffff'
        show_right  false
        show_bottom false
        show_left   false
      end
      lines do
        line 'only'
        line 'top'
      end
    end
    view('only_bottom') do
      border do
        foreground  '#ffffff'
        show_top   false
        show_right false
        show_left  false
      end
      lines do
        line 'only'
        line 'bottom'
      end
    end
    view('only_left') do
      border do
        foreground  '#ffffff'
        show_top    false
        show_bottom false
        show_right  false
      end
      lines do
        line 'only'
        line 'left'
      end
    end
    view('only_right') do
      border do
        foreground  '#ffffff'
        show_top    false
        show_bottom false
        show_left   false
      end
      lines do
        line 'only'
        line 'right'
      end
    end
    view('custom_colour') do
      border do
        colour foreground: '#ff5500', background: '#0000ff'
      end
      lines do
        line 'custom'
        line 'color'
      end
    end
    view('negative') do
      border do
        style 'negative'
      end
      lines do
        line 'custom'
        line 'style'
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # VedeuBordersApp

VedeuBordersApp.start(ARGV)
