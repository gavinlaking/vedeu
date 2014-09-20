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

  interface 'krypton' do
    centred false
    colour  foreground: '#ffff00', background: '#000000'
    height  4
    width   12
    y       { use('iron').south }
    x       { use('iron').east(1) }
  end

  interface 'francium' do
    centred false
    colour  foreground: '#ff00ff', background: '#000000'
    height  4
    width   12
    y       { use('iron').north(5) }
    x       { use('iron').west(13) }
  end

  interface 'argon' do
    centred  false
    colour   foreground: '#00ff00', background: '#000000'
    height   4
    width    12
    y        { use('iron').south }
    x        { use('iron').west(13) }
  end

  keys do
    key(:up)    { trigger(:_cursor_up_)    }
    key(:right) { trigger(:_cursor_right_) }
    key(:down)  { trigger(:_cursor_down_)  }
    key(:left)  { trigger(:_cursor_left_)  }
  end

  render do
    view 'iron' do
      line 'shift+tab to'
      line 'move to the'
      line 'previous one'
    end
    view 'francium' do
      line 'Press tab to'
      line 'move to next'
      line 'interface or'
    end
    view 'krypton' do
      line 'Position is'
      line 'remembered'
      line 'between'
      line 'interfaces.'
    end
    view 'argon' do
      line 'To exit this'
      line 'just press Q'
    end
  end

  def self.start
    Vedeu::Launcher.new(['--debug']).execute!
  end
end

VedeuCursorApp.start
