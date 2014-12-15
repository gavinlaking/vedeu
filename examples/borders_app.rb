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
    border
    x       2
    y       2
    height  3
    width   7
    colour  foreground: '#ffffff', background: '#ff0000'
  end

  interface 'tan' do
    x       11
    y       2
    height  3
    width   7
    colour  foreground: '#ffffff', background: '#00ff00'
  end

  interface 'tal' do
    border  show_top: false
    x       20
    y       2
    height  3
    width   7
    colour  foreground: '#ffffff', background: '#0000ff'
  end

  interface 'ums' do
    border  show_bottom: false
    x       29
    y       2
    height  3
    width   7
    colour  foreground: '#000000', background: '#ffff00'
  end

  interface 'ulp' do
    border  show_left: false
    x       38
    y       2
    height  3
    width   7
    colour  foreground: '#000000', background: '#ffff00'
  end

  interface 'hur' do
    border  show_right: false
    x       47
    y       2
    height  3
    width   7
    colour  foreground: '#000000', background: '#ffff00'
  end

  interface 'sto' do
    border  top_right: 'B', top_left: 'A', bottom_right: 'D', bottom_left: 'C'
    x       2
    y       7
    height  3
    width   7
    colour  foreground: '#ffffff', background: '#ff0000'
  end

  interface 'sod' do
    border  horizontal: '*', vertical: '$'
    x       11
    y       7
    height  3
    width   7
    colour  foreground: '#ffffff', background: '#00ff00'
  end

  interface 'sil' do
    border  show_right: false, show_bottom: false, show_left: false
    x       20
    y       7
    height  3
    width   7
    colour  foreground: '#ffffff', background: '#0000ff'
  end

  interface 'ver' do
    border  show_top: false, show_right: false, show_left: false
    x       29
    y       7
    height  3
    width   7
    colour  foreground: '#000000', background: '#ffff00'
  end

  interface 'ico' do
    border  show_top: false, show_bottom: false, show_right: false
    x       38
    y       7
    height  3
    width   7
    colour  foreground: '#000000', background: '#ffff00'
  end

  interface 'sel' do
    border  show_top: false, show_bottom: false, show_left: false
    x       47
    y       7
    height  3
    width   7
    colour  foreground: '#000000', background: '#ffff00'
  end

  interface 'ens' do
    border  colour: { foreground: '#ffff00', background: '#0000ff' }
    x       2
    y       12
    height  3
    width   7
    colour  foreground: '#ffffff', background: '#ff0000'
  end

  interface 'eab' do
    border  style: 'negative'
    x       11
    y       12
    height  3
    width   7
    colour  foreground: '#000000', background: '#00ff00'
    style   'normal'
  end

  render do
    view('lur') { line 'on'   }
    view('tan') { line 'off'  }
    view('tal') { line 'no t' }
    view('ums') { line 'no b' }
    view('ulp') { line 'no l' }
    view('hur') { line 'no r' }

    view('sto') { line 'chars'; line '1' }
    view('sod') { line 'chars'; line '2' }
    view('sil') { line 'only';  line 't' }
    view('ver') { line 'only';  line 'b' }
    view('ico') { line 'only';  line 'l' }
    view('sel') { line 'only';  line 'r' }

    view('ens') { line 'color' }
    view('eab') { line 'style' }
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
