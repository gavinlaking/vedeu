#!/usr/bin/env ruby

require 'bundler/setup'
require 'vedeu'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    log Dir.tmpdir + '/vedeu.log'
    debug!
    run_once!
    standalone!
    renderers(Vedeu::Renderers::Terminal.new,
              Vedeu::Renderers::Text.new(
                filename: Dir.tmpdir + '/misc_view.out'))
    height 40
  end

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

  Vedeu.interface 'horiz_ruler' do
    foreground '#ffffff'
    geometry do
      x 1
      width 80
      y 1
      height 1
    end
  end
  Vedeu.interface 'vert_ruler' do
    foreground '#ffffff'
    geometry do
      x 1
      width 1
      y 2
      height 48
    end
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
      y  4
      yn 15
    end
    group :my_group
    zindex 2
  end

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
    geometry do
      x(27)
      xn(47)
      y(5)
      yn(15)
    end
    zindex(1)
  end

  Vedeu.interface 'default_border' do
    geometry do
      x      50
      y      4
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#f44336'
  end

  Vedeu.interface 'border_off' do
    geometry do
      x      62
      y      4
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#e91e63'
  end

  Vedeu.interface 'no_top' do
    geometry do
      x      50
      y      9
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#9c27b0'
  end

  Vedeu.interface 'no_bottom' do
    geometry do
      x      62
      y      9
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#673ab7'
  end

  Vedeu.interface 'no_left' do
    geometry do
      x      50
      y      14
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#3f51b5'
  end

  Vedeu.interface 'no_right' do
    geometry do
      x      62
      y      14
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#2196f3'
  end

  Vedeu.interface 'custom_corners' do
    geometry do
      x      3
      y      17
      height 4
      width  10
    end
    colour  foreground: '#ffffff', background: '#03a9f4'
  end

  Vedeu.interface 'custom_sides' do
    geometry do
      x      15
      y      17
      height 4
      width  10
    end
    colour  foreground: '#000000', background: '#00bcd4'
  end

  Vedeu.interface 'only_top' do
    colour  foreground: '#ffffff', background: '#009688'
    border do
      foreground  '#ffffff'
      show_right  false
      show_bottom false
      show_left   false
    end
    geometry do
      x      27
      y      17
      height 4
      width  10
    end
  end

  Vedeu.interface 'only_bottom' do
    colour  foreground: '#000000', background: '#8bc34a'
    border do
      background  '#00ff00'
      foreground  '#000000'
      show_top   false
      show_right false
      show_left  false
    end
    geometry do
      x      39
      y      17
      height 4
      width  10
    end
  end

  Vedeu.interface 'only_left' do
    colour  foreground: '#000000', background: '#cddc39'
    border do
      background  '#cd39cd'
      foreground  '#000000'
      show_top    false
      show_bottom false
      show_right  false
    end
    geometry do
      x      3
      y      23
      height 4
      width  10
    end
  end

  Vedeu.interface 'only_right' do
    colour  foreground: '#000000', background: '#ffeb3b'
    border do
      background  '#cd39cd'
      foreground  '#000000'
      show_top    false
      show_bottom false
      show_left   false
    end
    geometry do
      x      27
      y      23
      height 4
      width  10
    end
  end

  Vedeu.interface 'custom_colour' do
    geometry do
      x      15
      y      23
      height 4
      width  10
    end
    colour foreground: '#000000', background: '#ffc107'
  end

  Vedeu.interface 'negative' do
    geometry do
      x      62
      y      23
      height 4
      width  10
    end
    colour foreground: '#000000', background: '#ff9800'
    style  'normal'
  end

  Vedeu.renders do
    view 'horiz_ruler' do
      background '#0046a3'
      line do
        stream '1--------1'
        stream '---------2'
        stream '---------3'
        stream '---------4'
        stream '---------5'
        stream '---------6'
        stream '---------7'
        stream '---------8'
        stream '---------9'
      end
    end
    view 'vert_ruler' do
      background '#0046a3'
      line '-'; line '-'; line '-'; line '-';
      line '-'; line '-'; line '-'; line '-'; line '1';
      line '-'; line '-'; line '-'; line '-'; line '-';
      line '-'; line '-'; line '-'; line '-'; line '2';
      line '-'; line '-'; line '-'; line '-'; line '-';
      line '-'; line '-'; line '-'; line '-'; line '3';
      line '-'; line '-'; line '-'; line '-'; line '-';
      line '-'; line '-'; line '-'; line '-'; line '4';
      line '-'; line '-'; line '-'; line '-'; line '-';
    end

    view 'main_interface' do
      line { left   'Left',        background: '#f44336' }
      line { centre 'Centre',      background: '#e91e63' }
      line { center 'Center',      background: '#9c27b0' }
      line { right  'Right',       background: '#673ab7' }
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

    view('default_border') do
      border do
        foreground '#ffffff'
      end
      lines do
        line 'default'
        line '4, 10'
      end
    end
    view('border_off') do
      lines do
        line 'border'
        line 'off'
        line '4, 10'
      end
    end
    view('no_top') do
      lines do
        line 'no top'
        line '4, 10'
      end
    end
    view('no_bottom') do
      lines do
        line 'no'
        line 'bottom'
        line '4, 10'
      end
    end
    view('no_left') do
      lines do
        line 'no left'
        line '4, 10'
      end
    end
    view('no_right') do
      lines do
        line 'no right'
        line '4, 10'
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
        line '4, 10'
      end
    end
    view('only_bottom') do
      lines do
        line 'only'
        line 'bottom'
        line '4, 10'
      end
    end
    view('only_left') do
      lines do
        line 'only'
        line 'left'
        line '4, 10'
      end
    end
    view('only_right') do
      lines do
        line 'only'
        line 'right'
        line '4, 10'
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

end # DSLApp

DSLApp.start(ARGV)
