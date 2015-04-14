#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'vedeu'

# An example application to demonstrate geometry.
#
class VedeuGeometryApp

  include Vedeu

  configure do
    debug!
    log '/tmp/vedeu_geometry_app.log'
  end

  interface 'main_interface' do
    colour foreground: '#ff0000', background: '#000000'
    cursor!

    # Geometry can be defined within the interface.
    geometry do
      height  8
      width   8
      x       2
      y       2
    end
  end

  interface 'second' do
    colour foreground: '#0000ff', background: '#000000'
    cursor!
  end

  # Geometry can be defined either before or after the interface.
  geometry 'second' do
    height  8
    width   8
    x       12
    y       2
  end

  keymap('_global_') do
    key(:up,    'k') { Vedeu.trigger(:_cursor_up_)    }
    key(:right, 'l') { Vedeu.trigger(:_cursor_right_) }
    key(:down,  'j') { Vedeu.trigger(:_cursor_down_)  }
    key(:left,  'h') { Vedeu.trigger(:_cursor_left_)  }
  end

  renders do
    view 'second' do
      border!
      lines do
        line 'A.987654321'
        line 'B.987654321'
        line 'C.987654321'
        line 'D.987654321'
        line 'E.987654321'
        line 'F.987654321'
        line 'G.987654321'
        line 'H.987654321'
      end
    end
    view 'main_interface' do
      border!
      lines do
        streams do
          text 'A.3456789 '
        end
        streams do
          background '#550000'
          foreground '#ffff00'
          text 'hydrogen'
        end
        streams do
          text ' helium'
        end
      end
      lines do
        streams do
          text 'B.3456789 lithium beryllium boron nitrogen'
        end
      end
      lines do
        streams do
          text 'C.3456789'
          text ' carbon oxygen '
        end
        streams do
          background '#aadd00'
          foreground '#000000'
          text 'fluorine'
        end
      end
      lines do
        streams do
          text 'D.3456789'
        end
      end
      lines do
        streams do
          text 'E.3456789 neon sodium'
        end
      end
      lines do
        streams do
          text 'F.3456789 magnesium '
        end
        streams do
          foreground '#00aaff'
          text 'aluminium'
        end
      end
      lines do
        streams do
          text 'G.3456789 silicon'
        end
      end
      lines do
        streams do
          background '#550000'
          foreground '#ff00ff'
          text 'H.34'
        end
      end
    end
  end

  focus_by_name 'main_interface'

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end

VedeuGeometryApp.start(ARGV)
