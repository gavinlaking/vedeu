#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

-> { its -> { a } }
trap('INT') { exit! }

require 'vedeu'

class VedeuCursorApp
  include Vedeu

  event(:_initialize_) { trigger(:_refresh_) }

  interface 'iron' do
    centred true
    colour  foreground: '#ff0000', background: '#000000'
    height  4
    width   2
  end

  interface 'krypton' do
    centred false
    colour  foreground: '#ffff00', background: '#000000'
    height  4
    width   4
    y       { use('iron').top }
    x       { use('iron').east(1) }
  end

  interface 'francium' do
    centred false
    colour  foreground: '#ff00ff', background: '#000000'
    height  4
    width   4
    y       { use('iron').top }
    x       { use('iron').west(5) }
  end

  keys do
    key(:up)    { trigger(:_cursor_up_)    }
    key(:right) { trigger(:_cursor_right_) }
    key(:down)  { trigger(:_cursor_down_)  }
    key(:left)  { trigger(:_cursor_left_)  }
  end

  render do
    view 'iron' do
      line do
        text 'Fe'
      end
    end
    view 'francium' do
      line do
        stream do
          text 'Fr'
          align :centre
          width 4
        end
      end
    end
    view 'krypton' do
      line do
        text 'Kr'
      end
    end
  end

  def self.start
    Vedeu::Launcher.new(['--debug']).execute!
  end
end

VedeuCursorApp.start
