#!/usr/bin/env ruby

require 'bundler/setup'
require 'vedeu'

# An example application to demonstrate colours, cursor and interface movement,
# maximising/unmaximising of interfaces and toggling of cursors and interfaces.
#
# If you have cloned this repository from GitHub, you can run this example:
#
#     ./test/support/examples/material_colours_app.rb
#
class VedeuEditorApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  # Be aware that running an application with profiling enabled will affect
  # performance.
  Vedeu.configure do
    debug!
    fake!
    log '/tmp/vedeu_editor_app.log'
    # profile!
    # renderers Vedeu::Renderers::File.new
  end

  Vedeu.interface 'main_interface' do
    border 'main_interface' do
      colour foreground: '#ffffff', background: :default
      title 'Editor'
      caption('Ctrl+C = Quit')
    end
    colour foreground: '#ffffff', background: :default
    cursor!
    geometry 'main_interface' do
      x  columns(1)
      xn columns(11)
      y  rows(1)
      yn rows(1) + 4
    end
    zindex 1
  end

  Vedeu.keymap('_global_') do
    key(:up)    { Vedeu.trigger(:_cursor_up_)    }
    key(:right) { Vedeu.trigger(:_cursor_right_) }
    key(:down)  { Vedeu.trigger(:_cursor_down_)  }
    key(:left)  { Vedeu.trigger(:_cursor_left_)  }

    key('q')        { Vedeu.trigger(:_exit_) }
    key(:escape)    { Vedeu.trigger(:_mode_switch_) }
    key(:shift_tab) { Vedeu.trigger(:_focus_prev_) }
    key(:tab)       { Vedeu.trigger(:_focus_next_) }
  end

  Vedeu.renders do
    view 'main_interface' do
      line { line '' }
    end
  end

  Vedeu.focus_by_name 'main_interface'

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # VedeuEditorApp

VedeuEditorApp.start(ARGV)
