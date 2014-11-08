#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

-> { its -> { a } }
trap('INT') { exit! }

require 'vedeu'

class VedeuCursorApp
  include Vedeu

  event(:_initialize_) { Vedeu.trigger(:_refresh_) }

  interface 'iron' do
    cursor  true
    centred true
    colour  foreground: '#ff0000', background: '#000000'
    height  4
    width   15

    # provide 'vim' direction keys
    keys do
      key('k') { Vedeu.trigger(:_cursor_up_)    }
      key('l') { Vedeu.trigger(:_cursor_right_) }
      key('j') { Vedeu.trigger(:_cursor_down_)  }
      key('h') { Vedeu.trigger(:_cursor_left_)  }
    end
  end

  interface 'gold' do
    cursor false
    colour foreground: '#00ff00', background: '#001100'
    height 4
    width  15
    x      use('iron').left
    y      use('iron').south
  end

  keys do
    key(:up)    { Vedeu.trigger(:_cursor_up_)    }
    key(:right) { Vedeu.trigger(:_cursor_right_) }
    key(:down)  { Vedeu.trigger(:_cursor_down_)  }
    key(:left)  { Vedeu.trigger(:_cursor_left_)  }
  end

  render do
    view 'iron' do
      line do
        stream do
          text 'A 23456789 '
        end
        stream do
          background '#550000'
          foreground '#ffff00'
          text 'hydrogen'
        end
        stream do
          text ' helium'
        end
      end
      line 'B 23456789 lithium beryllium boron nitrogen'
      line do
        stream do
          text 'C 23456789'
        end
        stream do
          text ' carbon oxygen '
        end
        stream do
          background '#aadd00'
          foreground '#000000'
          text 'fluorine'
        end
      end
      line 'D 23456789'
      line
      line 'E 23456789 neon sodium'
      line do
        stream do
          text 'F 23456789 magnesium '
        end
        stream do
          foreground '#00aaff'
          text 'aluminium'
        end
      end
      line 'G 23456789 silicon'
      line do
        stream do
          background '#550000'
          foreground '#ff00ff'
          text 'H 234'
        end
      end
    end

    view 'gold' do
      cursor false
      line 'Cursor: '
    end
  end

  focus('iron') # not working right?!

  Vedeu.configure do
    debug!
    log '/tmp/vedeu_cursor_app.log'
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.new(argv).execute!
  end
end

VedeuCursorApp.start(ARGV)
