#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'vedeu'

# An example application to demonstrate colours.
class VedeuMaterialColoursApp

  include Vedeu

  configure do
    # debug!
    log '/tmp/vedeu_material_colours_app.log'
    renderers Vedeu::Renderers::File
  end

  interface 'main_interface' do
    border 'main_interface' do
      colour foreground: '#ffffff', background: '#000000'
      title 'Rainbow!'
    end
    colour foreground: '#ffffff', background: '#000000'
    cursor!
    geometry 'main_interface' do
      x  5
      xn 25
      y  3
      yn 13
    end
  end

  interface 'other_interface' do
    border 'other_interface' do
      colour foreground: '#ffffff', background: '#000000'
      title 'Wow!'
    end
    colour foreground: '#ffffff', background: '#000000'
    cursor!
    geometry 'other_interface' do
      x  27
      xn 47
      y  3
      yn 13
    end
  end

  keymap('_global_') do
    key(:up,    'k') { Vedeu.trigger(:_cursor_up_)    }
    key(:right, 'l') { Vedeu.trigger(:_cursor_right_) }
    key(:down,  'j') { Vedeu.trigger(:_cursor_down_)  }
    key(:left,  'h') { Vedeu.trigger(:_cursor_left_)  }
    key('t')         do
      Vedeu.trigger(:_toggle_interface_, 'main_interface')
      Vedeu.trigger(:_toggle_interface_, 'other_interface')
    end
    key('1') { Vedeu.trigger(:_hide_interface_, 'main_interface') }
    key('2') { Vedeu.trigger(:_show_interface_, 'main_interface') }
    key('3') { Vedeu.trigger(:_hide_interface_, 'other_interface') }
    key('4') { Vedeu.trigger(:_show_interface_, 'other_interface') }
  end

  renders do
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
  end

  focus_by_name 'main_interface'

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end

VedeuMaterialColoursApp.start(ARGV)
