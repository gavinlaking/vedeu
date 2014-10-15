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
    width   15
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
      line 'A 23456789 hydrogen helium'
      line 'B 23456789 lithium beryllium boron nitrogen'
      line 'C 23456789 carbon oxygen fluorine'
      line 'D 23456789'
      line
      line 'E 23456789 neon sodium'
      line 'F 23456789 magnesium aluminium'
      line 'G 23456789 silicon'
      line 'H 234'
    end
  end

  def self.start
    Vedeu::Launcher.new(['--debug']).execute!
  end
end

VedeuCursorApp.start
