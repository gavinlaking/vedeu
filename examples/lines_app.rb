#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

-> { its -> { a } }
trap('INT') { exit! }

require 'vedeu'

class VedeuLinesApp
  include Vedeu

  configure do
    colour_mode 16777216
    debug!
    log '/tmp/vedeu_lines_app.log'
  end

  bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  interface 'ruthenium' do
    geometry do
      centred true
      height  5
      width   40
    end
    colour  foreground: '#ffffff', background: '#000000'
  end

  interface 'tantalum' do
    colour  foreground: '#00aadd', background: '#000000'
    geometry do
      height  1
      width   40
      x       Vedeu.use('ruthenium').left
      y       Vedeu.use('ruthenium').south
    end
  end

  keymap('_global_') do
    key(:up)    { Vedeu.trigger(:_cursor_up_)    }
    key(:right) { Vedeu.trigger(:_cursor_right_) }
    key(:down)  { Vedeu.trigger(:_cursor_down_)  }
    key(:left)  { Vedeu.trigger(:_cursor_left_)  }
  end

  renders do
    view 'ruthenium' do
      lines do
        line 'Ruthenium is a chemical element with'
        line 'symbol Ru and atomic number 44. It is a'
        line 'rare transition metal belonging to the'
        line 'platinum group of the periodic table.'
        line 'Like the other metals of the platinum'
        line 'group, ruthenium is inert to most other'
        line 'chemicals.'
      end
    end
    view 'tantalum' do
      lines do
        line 'Use cursor keys to navigate, Q to quit.'
      end
    end
  end

  focus_by_name 'ruthenium'

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end
end

VedeuLinesApp.start(ARGV)
