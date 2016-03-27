#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

# This example application shows how interface focus works.
#
# If you have cloned this repository from GitHub, you can run this example:
#
#     ./test/support/examples/focus_app.rb
#
# First, we set up the interfaces, noting that 'copper' should have focus when
# the application starts. Also note that 'status' should not show a cursor.
#
# The focus order is: copper, aluminium, boron, dubnium, status.
#
# Use 'space' to change focus, 'q' to exit.
class VedeuFocusApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  # Be aware that running an application with profiling enabled will affect
  # performance.
  Vedeu.configure do
    debug!
    log Dir.tmpdir + '/vedeu_focus_app.log'
    # profile!
  end

  update = proc do
    Vedeu.focus_next

    Vedeu.renders { view('status') { lines { line(Vedeu.focus) } } }
  end

  Vedeu.keymap('_global_') do
    key('q') { Vedeu.exit }
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

end # VedeuFocusApp

VedeuFocusApp.start(ARGV)
