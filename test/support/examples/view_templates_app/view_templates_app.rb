#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

# An example application to demonstrate templates.
class VedeuViewTemplateApp

  Vedeu.configure do
    debug!
    log Dir.tmpdir + '/vedeu_view_templates_app.log'
  end

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.interface 'default' do
    colour foreground: '#ff0000', background: '#000000'
    cursor!
  end

  Vedeu.interface 'prune' do
    colour foreground: '#00ff00', background: '#000000'
    cursor!
  end

  Vedeu.interface 'wrap' do
    colour foreground: '#0000ff', background: '#000000'
    cursor!
  end

  Vedeu.keymap('_global_') do
    key(:up,    'k') { Vedeu.trigger(:_cursor_up_)    }
    key(:right, 'l') { Vedeu.trigger(:_cursor_right_) }
    key(:down,  'j') { Vedeu.trigger(:_cursor_down_)  }
    key(:left,  'h') { Vedeu.trigger(:_cursor_left_)  }

    key('q')        { Vedeu.trigger(:_exit_) }
    key(:escape)    { Vedeu.trigger(:_mode_switch_) }
    key(:shift_tab) { Vedeu.trigger(:_focus_prev_) }
    key(:tab)       { Vedeu.trigger(:_focus_next_) }
  end

  Vedeu.border('default') do
    colour foreground: '#aadd00', background: '#000000'
  end

  Vedeu.border('prune') do
    colour foreground: '#00aadd', background: '#000000'
  end

  Vedeu.border('wrap') do
    colour foreground: '#dd00aa', background: '#000000'
  end

  Vedeu.geometry('prune') do
    align vertical: :middle, horizontal: :centre, width: 25, height: 6
  end

  Vedeu.geometry 'default' do
    height 6
    width  25
    x      use('prune').left
    y      use('prune').north(7)
  end

  Vedeu.geometry 'wrap' do
    height 6
    width  25
    x      use('prune').left
    y      use('prune').south(1)
  end

  def self.default_template
    File.dirname(__FILE__) + '/default.erb'
  end

  def self.prune_template
    File.dirname(__FILE__) + '/prune.erb'
  end

  def self.wrap_template
    File.dirname(__FILE__) + '/wrap.erb'
  end

  Vedeu.renders do
    template_for('default', default_template, nil)
    template_for('prune', prune_template, nil, mode: :prune, width: 22)
    template_for('wrap', wrap_template, nil, mode: :wrap, width: 25)
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # VedeuViewTemplateApp

VedeuViewTemplateApp.start(ARGV)
