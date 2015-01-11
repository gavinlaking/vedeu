#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

-> { its -> { a } }
trap('INT') { exit! }

require 'vedeu'

class VedeuBordersApp
  include Vedeu

  event(:_initialize_) { trigger(:_refresh_) }

  interface 'lur' do
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

  interface 'tan' do
    geometry do
      x      11
      y      2
      height 3
      width  7
    end
    colour  foreground: '#ffffff', background: '#00ff00'
  end

  interface 'tal' do
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

  interface 'ums' do
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

  interface 'ulp' do
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

  interface 'hur' do
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

  interface 'sto' do
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

  interface 'sod' do
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

  interface 'sil' do
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

  interface 'ver' do
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

  interface 'ico' do
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

  interface 'sel' do
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

  interface 'ens' do
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

  interface 'eab' do
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
    view('lur') do
      lines do
        line 'on'
      end
    end
    view('tan') do
      lines do
        line 'off'
      end
    end
    view('tal') do
      lines do
        line 'no t'
      end
    end
    view('ums') do
      lines do
        line 'no b'
      end
    end
    view('ulp') do
      lines do
        line 'no l'
      end
    end
    view('hur') do
      lines do
        line 'no r'
      end
    end

    view('sto') do
      lines do
        line 'chars'; line '1'
      end
    end
    view('sod') do
      lines do
        line 'chars'; line '2'
      end
    end
    view('sil') do
      lines do
        line 'only';  line 't'
      end
    end
    view('ver') do
      lines do
        line 'only';  line 'b'
      end
    end
    view('ico') do
      lines do
        line 'only';  line 'l'
      end
    end
    view('sel') do
      lines do
        line 'only';  line 'r'
      end
    end

    view('ens') do
      lines do
        line 'color'
      end
    end
    view('eab') do
      lines do
        line 'style'
      end
    end
  end

  Vedeu.configure do
    debug!
    log '/tmp/vedeu_borders_app.log'
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.new(argv).execute!
  end
end

VedeuBordersApp.start(ARGV)
