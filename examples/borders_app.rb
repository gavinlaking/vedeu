#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

-> { its -> { a } }
trap('INT') { exit! }

require 'vedeu'

class VedeuBordersApp
  include Vedeu

  configure do
    debug!
    log '/tmp/vedeu_borders_app.log'
  end

  bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  interface 'apple' do
    border do
    end
    geometry do
      x      2
      y      2
      height 3
      width  7
    end
    colour  foreground: '#ffffff', background: '#ff0000'
  end

  interface 'ball' do
    geometry do
      x      11
      y      2
      height 3
      width  7
    end
    colour  foreground: '#ffffff', background: '#00ff00'
  end

  interface 'chair' do
    border do
      show_top false
    end
    geometry do
      x      20
      y      2
      height 3
      width  7
    end
    colour  foreground: '#ffffff', background: '#0000ff'
  end

  interface 'door' do
    border do
      show_bottom false
    end
    geometry do
      x      29
      y      2
      height 3
      width  7
    end
    colour  foreground: '#000000', background: '#ffff00'
  end

  interface 'egg' do
    border do
      show_left false
    end
    geometry do
      x      38
      y      2
      height 3
      width  7
    end
    colour  foreground: '#000000', background: '#ffff00'
  end

  interface 'fish' do
    border do
      show_right false
    end
    geometry do
      x      47
      y      2
      height 3
      width  7
    end
    colour  foreground: '#000000', background: '#ffff00'
  end

  interface 'girl' do
    border do
      top_right    'B'
      top_left     'A'
      bottom_right 'D'
      bottom_left  'C'
    end
    geometry do
      x      2
      y      7
      height 3
      width  7
    end
    colour  foreground: '#ffffff', background: '#ff0000'
  end

  interface 'hat' do
    border do
      horizontal '*'
      vertical   '$'
    end
    geometry do
      x      11
      y      7
      height 3
      width  7
    end
    colour  foreground: '#ffffff', background: '#00ff00'
  end

  interface 'ice' do
    border do
      show_right  false
      show_bottom false
      show_left   false
    end
    geometry do
      x      20
      y      7
      height 3
      width  7
    end
    colour  foreground: '#ffffff', background: '#0000ff'
  end

  interface 'jug' do
    border do
      show_top   false
      show_right false
      show_left  false
    end
    geometry do
      x      29
      y      7
      height 3
      width  7
    end
    colour  foreground: '#000000', background: '#ffff00'
  end

  interface 'kite' do
    border do
      show_top    false
      show_bottom false
      show_right  false
    end
    geometry do
      x      38
      y      7
      height 3
      width  7
    end
    colour  foreground: '#000000', background: '#ffff00'
  end

  interface 'leaf' do
    border do
      show_top    false
      show_bottom false
      show_left   false
    end
    geometry do
      x      47
      y      7
      height 3
      width  7
    end
    colour  foreground: '#000000', background: '#ffff00'
  end

  interface 'moon' do
    border do
      colour foreground: '#ffff00', background: '#0000ff'
    end
    geometry do
      x      2
      y      12
      height 3
      width  7
    end
    colour foreground: '#ffffff', background: '#ff0000'
  end

  interface 'net' do
    border do
      style 'negative'
    end
    geometry do
      x      11
      y      12
      height 3
      width  7
    end
    colour foreground: '#000000', background: '#00ff00'
    style  'normal'
  end

  renders do
    view('apple') do
      lines do
        line 'on'
      end
    end
    view('ball') do
      lines do
        line 'off'
      end
    end
    view('chair') do
      lines do
        line 'no t'
      end
    end
    view('door') do
      lines do
        line 'no b'
      end
    end
    view('egg') do
      lines do
        line 'no l'
      end
    end
    view('fish') do
      lines do
        line 'no r'
      end
    end
    view('girl') do
      lines do
        line 'chars'
        line '1'
      end
    end
    view('hat') do
      lines do
        line 'chars'
        line '2'
      end
    end
    view('ice') do
      lines do
        line 'only'
        line 't'
      end
    end
    view('jug') do
      lines do
        line 'only'
        line 'b'
      end
    end
    view('kite') do
      lines do
        line 'only'
        line 'l'
      end
    end
    view('leaf') do
      lines do
        line 'only'
        line 'r'
      end
    end
    view('moon') do
      lines do
        line 'color'
      end
    end
    view('net') do
      lines do
        line 'style'
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.new(argv).execute!
  end
end

VedeuBordersApp.start(ARGV)
