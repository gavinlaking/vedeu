#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

-> { its -> { a } }
trap('INT') { exit! }

require 'vedeu'

class VedeuCursorApp
  include Vedeu

  configure do
    colour_mode 16777216
    debug!
    log '/tmp/vedeu_cursor_app.log'
  end

  bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  interface 'main_interface' do
    colour foreground: '#ff0000', background: '#000000'
    cursor!

    geometry do
      centred true
      height  8
      width   8
    end
  end

  keymap('_global_') do
    key(:up,    'k') { Vedeu.trigger(:_cursor_up_)    }
    key(:right, 'l') { Vedeu.trigger(:_cursor_right_) }
    key(:down,  'j') { Vedeu.trigger(:_cursor_down_)  }
    key(:left,  'h') { Vedeu.trigger(:_cursor_left_)  }
  end

  renders do
    view 'main_interface' do
      border do
        colour foreground: '#aadd00', background: '#000000'
      end
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

VedeuCursorApp.start(ARGV)
