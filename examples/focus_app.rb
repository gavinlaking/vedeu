#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'vedeu'

# This example application shows how interface focus works.
#
# First, we set up the interfaces, noting that 'copper' should have focus when
# the application starts. Also note that 'status' should not show a cursor.
#
# The focus order is: copper, aluminium, boron, dubnium, status.
#
# Use 'space' to change focus, 'q' to exit.
class VedeuFocusApp

  # Be aware that running an application with debugging enabled will affect
  # performance.
  Vedeu.configure do
    # debug!
    log '/tmp/vedeu_focus_app.log'
  end

  update = proc do
    Vedeu.focus_next

    Vedeu.renders { view('status') { lines { line(Vedeu.focus) } } }
  end

  Vedeu.interface 'aluminium' do
    colour  foreground: '#ffffff', background: '#330000'
    cursor  true
    geometry do
      height 3
      width  10
      x      3
      y      3
    end
    keymap { key(' ') { update.call } }
  end

  Vedeu.interface 'boron' do
    colour   foreground: '#ffffff', background: '#003300'
    cursor   true
    geometry do
      height 3
      width  10
      x      15
      y      3
    end
    keymap { key(' ') { update.call } }
  end

  Vedeu.interface 'copper' do
    colour  foreground: '#ffffff', background: '#000033'
    cursor  true
    focus!
    geometry do
      height 3
      width  10
      x      3
      y      8
    end
    keymap { key(' ') { update.call } }
  end

  Vedeu.interface 'dubnium' do
    colour  foreground: '#ffffff', background: '#333300'
    cursor  true
    geometry do
      height 3
      width  10
      x      15
      y      8
    end
    keymap { key(' ') { update.call } }
  end

  Vedeu.interface 'status' do
    colour  foreground: '#ffffff', background: '#000000'
    cursor  false
    geometry do
      height 3
      width  10
      x      3
      y      13
    end
    keymap { key(' ') { update.call } }
  end

  Vedeu.renders do
    view('aluminium') do
      lines do
        line 'Aluminium'
      end
    end
    view('boron') do
      lines do
        line 'Boron'
      end
    end
    view('copper') do
      lines do
        line 'Copper'
      end
    end
    view('dubnium') do
      lines do
        line 'Dubnium'
      end
    end
    view('status') do
      lines do
        line Vedeu.focus
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end

VedeuFocusApp.start(ARGV)
