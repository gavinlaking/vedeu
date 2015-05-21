#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'vedeu'

# An example application to demonstrate cursors; their movement and effect on
# the viewport of the interface in focus.
class VedeuCursorApp

  include Vedeu

  configure do
    debug!
    log '/tmp/vedeu_cursor_app.log'
  end

  interface 'main_interface' do
    colour foreground: '#ff0000', background: '#000000'
    cursor!

    geometry do
      centred true
      height  10
      width   20
    end
  end

  keymap('_global_') do
    key(:up,    'k') { Vedeu.trigger(:_cursor_up_)    }
    key(:right, 'l') { Vedeu.trigger(:_cursor_right_) }
    key(:down,  'j') { Vedeu.trigger(:_cursor_down_)  }
    key(:left,  'h') { Vedeu.trigger(:_cursor_left_)  }

    key('m') { Vedeu.trigger(:_maximise_, 'main_interface') }
    key('u') { Vedeu.trigger(:_unmaximise_, 'main_interface') }
  end

  renders do
    view 'main_interface' do
      border do
        colour foreground: '#aadd00', background: '#000000'
        title 'Move!'
      end
      lines do
        streams do
          text 'A.3 '
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
          text 'B.34 '
          text 'lithium ', colour: { foreground: '#63d48e' }
          text 'beryllium '
          text 'boron', colour: { background: '#770033' }
          text ' nitrogen'
        end
      end
      lines do
        streams do
          text 'C.345'
          text ' carbon oxygen '
        end
        streams do
          background '#aadd00'
          foreground '#00ddaa'
          text 'fluorine'
        end
      end
      lines do
        streams do
          text 'D.3456'
        end
      end
      lines do
        streams do
          text 'E.34567 neon sodium', colour: { foreground: '#ffffff' }
        end
      end
      lines do
        streams do
          text 'F.345678 magnesium '
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
          text 'H.34567890'
        end
      end
    end
  end

  focus_by_name 'main_interface'

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end

VedeuCursorApp.start(ARGV)
