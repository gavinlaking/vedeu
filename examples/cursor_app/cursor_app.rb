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
    width   12
  end

  keys do
    key(:up)    { trigger(:_cursor_up_)    }
    key(:right) { trigger(:_cursor_right_) }
    key(:down)  { trigger(:_cursor_down_)  }
    key(:left)  { trigger(:_cursor_left_)  }
  end

  focus('iron')

  render do
    view 'iron' do
      line 'A_23456789'
      line 'B_23456789'
      line 'C_23456789'
      line 'D_23456789'
      line 'E_23456789'
      line 'F_23456789'
      line 'G_23456789'
    end
  end

  def self.start
    Vedeu::Launcher.new(['--debug']).execute!
  end
end

VedeuCursorApp.start
