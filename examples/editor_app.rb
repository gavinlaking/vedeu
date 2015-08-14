#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'vedeu'

# An example application to demonstrate colours, cursor and interface movement,
# maximising/unmaximising of interfaces and toggling of cursors and interfaces.
#
# If you have cloned this repository from GitHub, you can run this example:
#
#     ./examples/material_colours_app.rb
#
# Running this application once, and immediately exiting produces the diagram
# at `./examples/material_colours_app_20150721.svg`. Hopefully this will help
# you to understand how parts of Vedeu work together. Questions are always
# welcome at `https://github.com/gavinlaking/vedeu/issues`
#
class VedeuEditorApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  # Be aware that running an application with debugging enabled will affect
  # performance.
  Vedeu.configure do
    # debug!
    fake!
    log '/tmp/vedeu_editor_app.log'
    # renderers Vedeu::Renderers::File.new
  end

  Vedeu.interface 'main_interface' do
    border 'main_interface' do
      colour foreground: '#ffffff', background: :default
      title 'Editor'
      caption('Q = Quit')
    end
    colour foreground: '#ffffff', background: :default
    cursor!
    geometry 'main_interface' do
      x  columns(1)
      xn columns(11)
      y  rows(1)
      yn rows(12)
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
