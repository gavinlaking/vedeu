#!/usr/bin/env ruby

require 'bundler/setup'
require 'vedeu'

# An example application to demonstrate colours, cursor and interface movement,
# maximising/unmaximising of interfaces and toggling of cursors and interfaces.
#
# If you have cloned this repository from GitHub, you can run this example:
#
#     ./test/support/examples/material_colours_app.rb
#
class VedeuMaterialColoursApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  # Be aware that running an application with debugging enabled will affect
  # performance.
  Vedeu.configure do
    # background '#607d8b'
    # colour background: '#607d8b', foreground: '#ffff00'
    debug!
    # foreground '#ffff00'
    # profile!
    log '/tmp/vedeu_material_colours_app.log'
    # height 11
    # width  20
    # renderers(Vedeu::Renderers::File
    #             .new(filename: '/tmp/material_colours.out'))
  end

  # Borders can be defined as standalone declarations.
  Vedeu.border 'no_bottom' do
    background  '#000000'
    foreground  '#ffffff'
    show_bottom false
  end
  Vedeu.border 'no_left' do
    background  '#000000'
    foreground  '#ffffff'
    show_left false
  end
  Vedeu.border 'no_right' do
    background  '#000000'
    foreground  '#ffffff'
    show_right false
  end
  Vedeu.border 'no_top' do
    background  '#000000'
    foreground  '#ffffff'
    show_top false
  end

  Vedeu.interface 'main_interface' do
    border 'main_interface' do
      colour foreground: '#ffffff', background: :default
      title 'Rainbow!'
      caption('Unicorns!')
    end
    colour foreground: '#ffffff', background: :default
    cursor!
    geometry 'main_interface' do
      x  3
      xn 24
      y  2
      yn 13
    end
    group :my_group
    zindex 2
  end

  # This interface uses the 'parens' style for the DSL, which sometimes helps
  # Ruby to understand the values you provide.
  #
  # It also uses custom border characters to demonstrate that functionality.
  Vedeu.interface 'other_interface' do
    border 'other_interface' do
      colour(foreground: '#ffffff', background: :default)
      title('Wow!')
      caption('Shiny!')
      horizontal('-')
      top_right('+')
      top_left('+')
      bottom_right('+')
      bottom_left('+')
    end
    colour(foreground: '#ffffff', background: :default)
    cursor!
    geometry 'other_interface' do
      x(27)
      xn(47)
      y(3)
      yn(13)
    end
    zindex(1)
  end

  Vedeu.interface 'default_border' do
    geometry do
      x      50
      y      2
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#f44336'
  end

  Vedeu.interface 'border_off' do
    geometry do
      x      62
      y      2
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#e91e63'
  end

  Vedeu.interface 'no_top' do
    geometry do
      x      50
      y      7
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#9c27b0'
  end

  Vedeu.interface 'no_bottom' do
    geometry do
      x      62
      y      7
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#673ab7'
  end

  Vedeu.interface 'no_left' do
    geometry do
      x      50
      y      12
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#3f51b5'
  end

  Vedeu.interface 'no_right' do
    geometry do
      x      62
      y      12
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#2196f3'
  end

  Vedeu.interface 'custom_corners' do
    geometry do
      x      50
      y      17
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#03a9f4'
  end

  Vedeu.interface 'custom_sides' do
    geometry do
      x      62
      y      17
      height 4
      width  10
    end
    colour  foreground: '#000000', background: '#00bcd4'
  end

  # Borders can be defined as part of the interface definition.
  Vedeu.interface 'only_top' do
    colour  foreground: '#ffffff', background: '#009688'
    border do
      foreground  '#ffffff'
      show_right  false
      show_bottom false
      show_left   false
    end
    geometry do
      x      50
      y      22
      height 4
      width  10
    end
  end

  Vedeu.interface 'only_bottom' do
    colour  foreground: '#000000', background: '#8bc34a'
    border do
      foreground  '#000000'
      show_top   false
      show_right false
      show_left  false
    end
    geometry do
      x      62
      y      22
      height 4
      width  10
    end
  end

  Vedeu.interface 'only_left' do
    colour  foreground: '#000000', background: '#cddc39'
    border do
      foreground  '#000000'
      show_top    false
      show_bottom false
      show_right  false
    end
    geometry do
      x      50
      y      27
      height 4
      width  10
    end
  end

  Vedeu.interface 'only_right' do
    colour  foreground: '#000000', background: '#ffeb3b'
    border do
      foreground  '#000000'
      show_top    false
      show_bottom false
      show_left   false
    end
    geometry do
      x      62
      y      27
      height 4
      width  10
    end
  end

  Vedeu.interface 'custom_colour' do
    geometry do
      x      50
      y      32
      height 4
      width  10
    end
    colour foreground: '#000000', background: '#ffc107'
  end

  Vedeu.interface 'negative' do
    geometry do
      x      62
      y      32
      height 4
      width  10
    end
    colour foreground: '#000000', background: '#ff9800'
    style  'normal'
  end

  Vedeu.interface 'keys_interface' do
    colour(foreground: '#ffffff', background: :default)
    geometry 'keys_interface' do
      x(3)
      xn(45)
      y(15)
      yn(34)
    end
    zindex(0)
  end

  Vedeu.keymap('_global_') do
    key(:up)    { Vedeu.trigger(:_cursor_up_)     }
    key(:right) { Vedeu.trigger(:_cursor_right_)  }
    key(:down)  { Vedeu.trigger(:_cursor_down_)   }
    key(:left)  { Vedeu.trigger(:_cursor_left_)   }
    key(:home)  { Vedeu.trigger(:_cursor_top_)    }
    key(:end)   { Vedeu.trigger(:_cursor_bottom_) }

    key(:insert) do
      Vedeu.log(type:    :debug,
                message: "Commands: #{Vedeu.all_commands.inspect}")
      Vedeu.log(type:    :debug,
                message: "Keypresses: #{Vedeu.all_keypresses.inspect}")
    end

    key('q', :ctrl_c) { Vedeu.trigger(:_exit_) }
    # key(:escape)    { Vedeu.trigger(:_mode_switch_, :fake) }
    key(:f1)    { Vedeu.trigger(:_mode_switch_, :fake) }
    key(:f2)    { Vedeu.trigger(:_mode_switch_, :raw) }
    key(:f3)    { Vedeu.trigger(:_mode_switch_, :cooked) }
    key(:shift_tab) { Vedeu.trigger(:_focus_prev_) }
    key(:tab)       { Vedeu.trigger(:_focus_next_) }

    key('1') { Vedeu.trigger(:_hide_interface_, 'main_interface') }
    key('2') { Vedeu.trigger(:_show_interface_, 'main_interface') }
    key('3') { Vedeu.trigger(:_hide_interface_, 'other_interface') }
    key('4') { Vedeu.trigger(:_show_interface_, 'other_interface') }

    key('a') { Vedeu.trigger(:_view_left_, 'main_interface')  }
    key('s') { Vedeu.trigger(:_view_down_, 'main_interface')  }
    key('d') { Vedeu.trigger(:_view_up_, 'main_interface')    }
    key('f') { Vedeu.trigger(:_view_right_, 'main_interface') }

    key('w') { Vedeu.trigger(:_toggle_group_, :my_group) }
    key('e') { Vedeu.trigger(:_hide_group_, :my_group) }
    key('r') { Vedeu.trigger(:_show_group_, :my_group) }
    key('t') do
      Vedeu.trigger(:_toggle_interface_, 'main_interface')
      Vedeu.trigger(:_toggle_interface_, 'other_interface')
    end

    key('h') { Vedeu.trigger(:_view_left_, 'other_interface')  }
    key('j') { Vedeu.trigger(:_view_down_, 'other_interface')  }
    key('k') { Vedeu.trigger(:_view_up_, 'other_interface')    }
    key('l') { Vedeu.trigger(:_view_right_, 'other_interface') }

    key('m') { Vedeu.trigger(:_maximise_, 'main_interface') }
    key('n') { Vedeu.trigger(:_unmaximise_, 'main_interface') }
    key('b') { Vedeu.trigger(:_maximise_, 'other_interface') }
    key('v') { Vedeu.trigger(:_unmaximise_, 'other_interface') }

    key('x') { Vedeu.trigger(:_set_border_caption_, Vedeu.focus, 'Amazing!') }
    key('z') { Vedeu.trigger(:_set_border_title_, Vedeu.focus, 'Surprise!') }
  end

  Vedeu.renders do
    view 'main_interface' do
      line { centre 'Red',         width: 20, background: '#f44336' }
      line { centre 'Pink',        width: 20, background: '#e91e63' }
      line { centre 'Purple',      width: 20, background: '#9c27b0' }
      line { centre 'Deep Purple', width: 20, background: '#673ab7' }
      line { centre 'Indigo',      width: 20, background: '#3f51b5' }
      line { centre 'Blue',        width: 20, background: '#2196f3' }
      line { centre 'Light Blue',  width: 20, background: '#03a9f4' }
      line { centre 'Cyan',        width: 20, background: '#00bcd4' }
      line { centre 'Teal',        width: 20, background: '#009688' }
      line { centre 'Green',       width: 20, background: '#4caf50' }
      line { centre 'Light Green', width: 20, background: '#8bc34a' }
      line { centre 'Lime',        width: 20, background: '#cddc39' }
      line { centre 'Yellow',      width: 20, background: '#ffeb3b' }
      line { centre 'Amber',       width: 20, background: '#ffc107' }
      line { centre 'Orange',      width: 20, background: '#ff9800' }
      line { centre 'Deep Orange', width: 20, background: '#ff5722' }
      line { centre 'Brown',       width: 20, background: '#795548' }
      line { centre 'Grey',        width: 20, background: '#9e9e9e' }
      line { centre 'Blue Grey',   width: 20, background: '#607d8b' }
    end

    view 'other_interface' do
      line { centre 'Blue Grey',   width: 20, background: '#607d8b' }
      line { centre 'Grey',        width: 20, background: '#9e9e9e' }
      line { centre 'Brown',       width: 20, background: '#795548' }
      line { centre 'Deep Orange', width: 20, background: '#ff5722' }
      line { centre 'Orange',      width: 20, background: '#ff9800' }
      line { centre 'Amber',       width: 20, background: '#ffc107' }
      line { centre 'Yellow',      width: 20, background: '#ffeb3b' }
      line { centre 'Lime',        width: 20, background: '#cddc39' }
      line { centre 'Light Green', width: 20, background: '#8bc34a' }
      line { centre 'Green',       width: 20, background: '#4caf50' }
      line { centre 'Teal',        width: 20, background: '#009688' }
      line { centre 'Cyan',        width: 20, background: '#00bcd4' }
      line { centre 'Light Blue',  width: 20, background: '#03a9f4' }
      line { centre 'Blue',        width: 20, background: '#2196f3' }
      line { centre 'Indigo',      width: 20, background: '#3f51b5' }
      line { centre 'Deep Purple', width: 20, background: '#673ab7' }
      line { centre 'Purple',      width: 20, background: '#9c27b0' }
      line { centre 'Pink',        width: 20, background: '#e91e63' }
      line { centre 'Red',         width: 20, background: '#f44336' }
    end

    view 'keys_interface' do
      cursor false
      line {
        stream {
          left "\u2190 \u2193 \u2191 \u2192",
               foreground: '#ffff00', width: 15
        }
        stream { left "Move cursor" }
      }
      line {
        stream {
          left "home",
               foreground: '#ffff00', width: 15
        }
        stream { left "Move cursor to first line" }
      }
      line {
        stream {
          left "end",
               foreground: '#ffff00', width: 15
        }
        stream { left "Move cursor to last line" }
      }
      line {}
      line {
        stream {
          left 'a, s, d, f',
          foreground: '#ffff00', width: 15
        }
        stream { left "Move Rainbow! (\u2190 \u2193 \u2191 \u2192)" }
      }
      line {
        stream {
          left 'h, j, k, l',
          foreground: '#ffff00', width: 15
        }
        stream { left "Move Wow! (\u2190 \u2193 \u2191 \u2192)" }
      }
      line {}
      line {
        stream {
          left 't',
          foreground: '#ffff00', width: 15
        }
        stream { left 'Toggle Rainbow!/Wow!' }
      }
      line {
        stream {
          left '1, 2',
          foreground: '#ffff00', width: 15
        }
        stream { left 'Hide/Show Rainbow!' }
      }
      line {
        stream {
          left '3, 4',
          foreground: '#ffff00', width: 15
        }
        stream { left 'Hide/Show Wow!' }
      }
      line {}
      line {
        stream {
          left 'n, m',
          foreground: '#ffff00', width: 15
        }
        stream { left 'Un/Maximise Rainbow!' }
      }
      line {
        stream {
          left 'v, b',
          foreground: '#ffff00', width: 15
        }
        stream { left 'Un/Maximise Wow!' }
      }
      line {}
      line {
        stream {
          left 'escape',
                foreground: '#ffff00', width: 15
        }
        stream { left 'Mode Switch' }
      }
      line {
        stream {
          left 'shift+tab',
          foreground: '#ffff00', width: 15
        }
        stream { left 'Focus previous view' }
      }
      line {
        stream {
          left 'tab',
          foreground: '#ffff00', width: 15
        }
        stream { left 'Focus next view' }
      }
      line {}
      line {
        stream {
          left 'q',
               foreground: '#ffff00', width: 15
        }
        stream { left 'Exit' }
      }
    end
    view('default_border') do
      border do
        foreground '#ffffff'
      end
      lines do
        line 'default'
      end
    end
    view('border_off') do
      lines do
        line 'border'
        line 'off'
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
        foreground   '#000000'
        top_left     'A', colour: { background: '#ff5722' }
        top_right    'B', colour: { background: '#0000ff', foreground: '#ffffff' }
        bottom_left  'C', colour: { background: '#ffff00', foreground: '#000000' }
        bottom_right 'D', colour: { background: '#ffffff' }
      end
      lines do
        line 'custom'
        line 'corners'
      end
    end
    view('custom_sides') do
      border do
        background '#ff5722'

        top_horizontal    '*', colour: { background: '#000000', foreground: '#ffffff' }
        left_vertical     '$', colour: { background: '#0000ff', foreground: '#ffffff' }
        right_vertical    '%', colour: { background: '#ffff00', foreground: '#000000' }
        bottom_horizontal '&', colour: { background: '#ffffff' }
      end
      lines do
        line 'custom'
        line 'sides'
      end
    end
    view('only_top') do
      lines do
        line 'only'
        line 'top'
      end
    end
    view('only_bottom') do
      lines do
        line 'only'
        line 'bottom'
      end
    end
    view('only_left') do
      lines do
        line 'only'
        line 'left'
      end
    end
    view('only_right') do
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

  Vedeu.focus_by_name 'main_interface'

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # VedeuMaterialColoursApp

VedeuMaterialColoursApp.start(ARGV)
