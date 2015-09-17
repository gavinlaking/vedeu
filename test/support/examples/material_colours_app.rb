#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'vedeu'

# An example application to demonstrate colours, cursor and interface movement,
# maximising/unmaximising of interfaces and toggling of cursors and interfaces.
#
# If you have cloned this repository from GitHub, you can run this example:
#
#     ./examples/material_colours_app.rb
#
# Running this application once, and immediately exiting produces the diagram
# at `./examples/material_colours_app_20150721.svg`. Hopefully this will help
# you to understand how parts of Vedeu work together. Questions are always
# welcome at `https://github.com/gavinlaking/vedeu/issues`
#
class VedeuMaterialColoursApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  # Be aware that running an application with debugging enabled will affect
  # performance.
  Vedeu.configure do
    debug!
    log '/tmp/vedeu_material_colours_app.log'
    renderers Vedeu::Renderers::HTML.new(filename: '/tmp/material', timestamp: true)
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

  Vedeu.interface 'empty_interface' do
    border 'empty_interface' do
      colour(foreground: '#ffffff', background: :default)
      title('Empty!')
      horizontal('-')
      top_right('+')
      top_left('+')
      bottom_right('+')
      bottom_left('+')
    end
    colour(foreground: '#ffffff', background: :default)
    cursor!
    geometry 'empty_interface' do
      x(50)
      xn(64)
      y(5)
      yn(13)
    end
    zindex(1)
  end

  Vedeu.keymap('_global_') do
    key(:up)    { Vedeu.trigger(:_cursor_up_)    }
    key(:right) { Vedeu.trigger(:_cursor_right_) }
    key(:down)  { Vedeu.trigger(:_cursor_down_)  }
    key(:left)  { Vedeu.trigger(:_cursor_left_)  }

    key('q')        { Vedeu.trigger(:_exit_) }
    key(:escape)    { Vedeu.trigger(:_mode_switch_) }
    key(:shift_tab) { Vedeu.trigger(:_focus_prev_) }
    key(:tab)       { Vedeu.trigger(:_focus_next_) }

    key('a') { Vedeu.trigger(:_view_left_, 'main_interface')  }
    key('s') { Vedeu.trigger(:_view_down_, 'main_interface')  }
    key('d') { Vedeu.trigger(:_view_up_, 'main_interface')    }
    key('f') { Vedeu.trigger(:_view_right_, 'main_interface') }

    key('h') { Vedeu.trigger(:_view_left_, 'other_interface')  }
    key('j') { Vedeu.trigger(:_view_down_, 'other_interface')  }
    key('k') { Vedeu.trigger(:_view_up_, 'other_interface')    }
    key('l') { Vedeu.trigger(:_view_right_, 'other_interface') }

    key('t') do
      Vedeu.trigger(:_toggle_interface_, 'main_interface')
      Vedeu.trigger(:_toggle_interface_, 'other_interface')
    end
    key('1') { Vedeu.trigger(:_hide_interface_, 'main_interface') }
    key('2') { Vedeu.trigger(:_show_interface_, 'main_interface') }
    key('3') { Vedeu.trigger(:_hide_interface_, 'other_interface') }
    key('4') { Vedeu.trigger(:_show_interface_, 'other_interface') }
    key('m') { Vedeu.trigger(:_maximise_, 'main_interface') }
    key('n') { Vedeu.trigger(:_unmaximise_, 'main_interface') }
    key('b') { Vedeu.trigger(:_maximise_, 'other_interface') }
    key('v') { Vedeu.trigger(:_unmaximise_, 'other_interface') }
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

    view 'empty_interface' do
      line { line '' }
    end
  end

  Vedeu.focus_by_name 'main_interface'

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # VedeuMaterialColoursApp

VedeuMaterialColoursApp.start(ARGV)
